return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",

    config = function()
      local map = vim.keymap.set

      --  on_attach
      local on_attach = function(_, bufnr)
        local function opts(desc)
          return { buffer = bufnr, desc = "LSP " .. desc }
        end

        map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
        map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
        map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
        -- map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))
        -- map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
        -- map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))

        -- inc-rename
        map("n", "<leader>cr", function()
          local inc_rename = require("inc_rename")
          return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
        end, { expr = true, desc = "Rename with inc_rename", silent = true })

        -- map("n", "<leader>wl", function()
        -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, opts("List workspace folders"))

        -- map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
        -- map("n", "<leader>ra", require("nvchad.lsp.renamer"), opts("NvRenamer"))

        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
        map("n", "gr", vim.lsp.buf.references, opts("Show references"))
      end

      -- on_init
      local on_init = function(client, _)
        if client.supports_method("textDocument/semanticTokens") then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      capabilities.textDocument.completion.completionItem = {
        documentationFormat = { "markdown", "plaintext" },
        snippetSupport = true,
        preselectSupport = true,
        insertReplaceSupport = true,
        labelDetailsSupport = true,
        deprecatedSupport = true,
        commitCharactersSupport = true,
        tagSupport = { valueSet = { 1 } },
        resolveSupport = {
          properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
          },
        },
      }

      local servers = {
        lua_ls = {},
        jdtls = {},
        cairo_ls = {},
        gradle_ls = {},
        biome = {},
        -- pylyzer = {},
        pyright = {},
        bashls = {},
        solidity_ls_nomicfoundation = {},
        rust_analyzer = {},
      }

      for name, opts in pairs(servers) do
        opts.on_attach = on_attach
        opts.on_init = on_init
        opts.capabilities = capabilities

        require("lspconfig")[name].setup(opts)
      end
    end,
  },

  -- mason
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = function()
      return require("nvchad.configs.mason")
    end,
  },
}
