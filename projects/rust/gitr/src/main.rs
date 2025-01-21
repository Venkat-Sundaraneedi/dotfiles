use chrono::Local;
use crossterm::{
    cursor::{Hide, Show},
    event::{self, Event, KeyCode},
    terminal::{disable_raw_mode, enable_raw_mode, Clear, ClearType},
    ExecutableCommand,
};
use git2::{Repository, Signature};
use skim::prelude::*;
use std::{
    env,
    error::Error,
    io::stdout,
    path::{Path, PathBuf},
};
use tui::{
    backend::CrosstermBackend,
    layout::{Constraint, Direction, Layout},
    style::{Color, Style},
    text::{Span, Spans},
    widgets::{Block, Borders, List, ListItem, Paragraph},
    Terminal,
};
use walkdir::WalkDir;

struct GitRepo {
    path: PathBuf,
    status: String,
}

fn find_git_repos(start_path: &Path) -> Vec<PathBuf> {
    let mut git_repos = Vec::new();

    for entry in WalkDir::new(start_path)
        .follow_links(true)
        .max_depth(10) // Limit depth to avoid searching too deep
        .into_iter()
        .filter_entry(|e| {
            // Skip hidden directories except .git
            let file_name = e.file_name().to_string_lossy();
            !file_name.starts_with('.') || file_name == ".git"
        })
    {
        if let Ok(entry) = entry {
            if entry.file_type().is_dir() && entry.file_name() == ".git" {
                if let Some(parent) = entry.path().parent() {
                    // Ensure the folder is a valid git repository
                    if Repository::open(parent).is_ok() {
                        git_repos.push(parent.to_path_buf());
                    }
                }
            }
        }
    }

    git_repos
}

fn select_repos(repos: Vec<PathBuf>) -> Option<Vec<PathBuf>> {
    let options = SkimOptionsBuilder::default()
        .height(Some("50%"))
        .multi(true)
        .select1(true) // Make the first item pre-selected
        .build()
        .unwrap();

    // Convert paths to strings for skim
    let mut items: Vec<String> = repos
        .iter()
        .map(|path| path.to_string_lossy().into_owned())
        .collect();
    items.push(String::from("All folders"));
    items.push(String::from("Quit"));

    let item_reader = SkimItemReader::default();
    let items = item_reader.of_bufread(std::io::Cursor::new(items.join("\n")));

    let selected = Skim::run_with(&options, Some(items)).map(|out| {
        // If "All folders" is selected, return all repos; otherwise, return selected items
        if out
            .selected_items
            .iter()
            .any(|item| item.text() == "All folders")
        {
            repos
        } else {
            out.selected_items
                .iter()
                .map(|item| PathBuf::from(item.text().to_string()))
                .collect::<Vec<_>>()
        }
    });

    //selected
    // Check if "Quit" was selected
    selected.and_then(|selected_repos| {
        if selected_repos
            .iter()
            .any(|repo| repo.to_string_lossy() == "Quit")
        {
            None // Return None to indicate quitting
        } else {
            Some(selected_repos)
        }
    })
}

fn main() -> Result<(), Box<dyn Error>> {
    // Get current directory
    let current_dir = env::current_dir()?;

    // Find all git repositories
    println!("Scanning for git repositories...");
    let found_repos = find_git_repos(&current_dir);

    if found_repos.is_empty() {
        println!("No git repositories found in the current directory tree.");
        return Ok(());
    }

    // Let user select repositories using skim
    println!("Select repositories to process (Tab to select multiple, Enter to confirm):");
    let selected_repos = match select_repos(found_repos) {
        Some(repos) if !repos.is_empty() => repos,
        _ => {
            println!("\nNo repositories selected.");
            std::process::Command::new("clear").status()?;
            return Ok(());
        }
    };

    // Initialize repos for TUI
    let mut repos: Vec<GitRepo> = selected_repos
        .into_iter()
        .map(|path| GitRepo {
            path,
            status: String::from("Pending"),
        })
        .collect();

    // Setup terminal
    enable_raw_mode()?;

    // Clear the entire screen and hide cursor before starting TUI
    stdout().execute(Clear(ClearType::All))?;
    stdout().execute(Hide)?;

    let backend = CrosstermBackend::new(stdout());
    let mut terminal = Terminal::new(backend)?;
    terminal.clear()?;

    loop {
        terminal.draw(|f| {
            let chunks = Layout::default()
                .direction(Direction::Vertical)
                .constraints([
                    Constraint::Length(3),
                    Constraint::Min(10),
                    Constraint::Length(3),
                ])
                .split(f.size());

            let title = Paragraph::new("Git Bulk Commit Manager")
                .style(Style::default().fg(Color::Cyan))
                .block(Block::default().borders(Borders::ALL));
            f.render_widget(title, chunks[0]);

            let items: Vec<ListItem> = repos
                .iter()
                .map(|repo| {
                    let color = match repo.status.as_str() {
                        "Success" => Color::Green,
                        "Error" => Color::Red,
                        _ => Color::White,
                    };
                    ListItem::new(Spans::from(vec![
                        Span::raw(format!("{}: ", repo.path.display())),
                        Span::styled(&repo.status, Style::default().fg(color)),
                    ]))
                })
                .collect();

            let repos_list = List::new(items)
                .block(Block::default().title("Repositories").borders(Borders::ALL));
            f.render_widget(repos_list, chunks[1]);

            let instructions = Paragraph::new("Press 'c' to commit all • Press 'q' to quit")
                .style(Style::default().fg(Color::Yellow))
                .block(Block::default().borders(Borders::ALL));
            f.render_widget(instructions, chunks[2]);
        })?;

        if let Event::Key(key) = event::read()? {
            match key.code {
                KeyCode::Char('q') => break,
                KeyCode::Char('c') => {
                    for repo in &mut repos {
                        match commit_changes(&repo.path) {
                            Ok(_) => repo.status = String::from("Success"),
                            Err(e) => repo.status = format!("Error: {}", e),
                        }
                    }
                }
                _ => {}
            }
        }
    }

    // Cleanup
    disable_raw_mode()?;
    stdout().execute(Show)?;
    terminal.clear()?;
    terminal.show_cursor()?;

    // Clear the terminal using the "clear" command
    std::process::Command::new("clear").status()?;

    Ok(())
}

fn commit_changes(repo_path: &Path) -> Result<(), Box<dyn Error>> {
    let repo = Repository::open(repo_path)?;
    let mut index = repo.index()?;

    // Stage all changes
    index.add_all(["*"].iter(), git2::IndexAddOption::DEFAULT, None)?;
    index.write()?;

    let tree_id = index.write_tree()?;
    let tree = repo.find_tree(tree_id)?;

    //// Get the current branch's HEAD
    //let head = repo.head()?;
    //let parent_commit = repo.find_commit(head.target().unwrap())?;

    // Check if the repository has a HEAD reference
    let parent_commit = if let Ok(head) = repo.head() {
        if head.is_branch() {
            Some(repo.find_commit(head.target().unwrap())?)
        } else {
            None
        }
    } else {
        None
    };

    // Create signature
    let signature = Signature::now("Automated Commit", "auto@commit.local")?;

    // Generate commit message with timestamp and folder name
    let timestamp = Local::now().format("%Y-%m-%d %H:%M:%S").to_string();
    let folder_name = repo_path.file_name().unwrap().to_str().unwrap();
    let commit_message = format!("Automated commit ({}) ({})", timestamp, folder_name);

    // Create commit
    repo.commit(
        Some("HEAD"),
        &signature,
        &signature,
        &commit_message,
        &tree,
        //&[&parent_commit],
        parent_commit
            .as_ref()
            .map(|c| vec![c])
            .unwrap_or_default()
            .as_slice(),
    )?;

    Ok(())
}
