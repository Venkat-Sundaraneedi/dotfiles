function download_retro_game
  # download_retro_game - Download all zip files from a directory URL, extract, and show progress with failure tracking
  # Usage: download_retro_game <directory_url>
  
  set url $argv[1]
  
  if not set -q url
    echo "Warning: No URL provided. Usage: download_retro_game <directory_url>"
    return 1
  end
  
  # Check dependencies
  if not command -q python3
    echo "Error: Python 3 is required for URL decoding. Install it and try again."
    return 1
  end
  if not command -q unzip
    echo "Error: unzip is required for extraction. Install it and try again."
    return 1
  end
  
  echo "Fetching directory listing from $url..."
  
  # Fetch the directory HTML with user-agent and follow redirects
  set html (xh --follow "$url" "User-Agent: Mozilla/5.0" 2>/dev/null)
  
  if test $status -ne 0
    echo "Error: Failed to fetch directory listing."
    return 1
  end
  
  # Extract zip file hrefs (encoded filenames)
  set zip_hrefs (echo $html | grep -o 'href="[^"]*\.zip"' | sed 's/href="//;s/"$//')
  
  if test (count $zip_hrefs) -eq 0
    echo "No zip files found in the directory."
    return 0
  end
  
  set total (count $zip_hrefs)
  set downloaded 0
  set extracted 0
  set failed_extractions 0
  set downloaded_files
  
  echo "Found $total zip files. Starting downloads..."
  
  for href in $zip_hrefs
    # Decode the filename for local saving
    set decoded (python3 -c "import urllib.parse; print(urllib.parse.unquote('$href'))" 2>/dev/null)
    
    if test $status -ne 0
      echo "Warning: Failed to decode filename for $href. Skipping."
      continue
    end
    
    set full_url "$url$href"
    
    echo "Downloading: $decoded"
    xh --follow -d --timeout 60 -o "$decoded" "$full_url" "User-Agent: Mozilla/5.0"
    
    if test $status -eq 0
      set downloaded (math $downloaded + 1)
      set downloaded_files $downloaded_files "$decoded"
      echo (set_color green)"$downloaded of $total downloaded"(set_color normal)
    else
      echo "Warning: Failed to download $decoded"
    end
  end
  
  # Now extract downloaded files sequentially (assumed fast)
  echo "Downloads complete. Starting extractions..."
  for file in $downloaded_files
    echo "Extracting: $file"
    unzip "$file" >/dev/null 2>&1
    if test $status -eq 0
      set extracted (math $extracted + 1)
      rm "$file"
      echo "Extracted and deleted: $file"
    else
      set failed_extractions (math $failed_extractions + 1)
      echo "Warning: Failed to extract $file"
    end
  end
  
  # Display final counts
  echo (set_color green)"$extracted of $total extracted"(set_color normal)
  if test $failed_extractions -gt 0
    echo (set_color red)"$failed_extractions extractions failed"(set_color normal)
  end
  
  echo "Process complete. Failed zips retained for manual handling."
end
