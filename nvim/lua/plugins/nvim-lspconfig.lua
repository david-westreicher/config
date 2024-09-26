local function prefer_bin_from_venv(executable_name)
  -- Return the path to the executable if $VIRTUAL_ENV is set and the binary exists somewhere beneath the $VIRTUAL_ENV path, otherwise get it from Mason
  if vim.env.VIRTUAL_ENV then
    local paths = vim.fn.glob(vim.env.VIRTUAL_ENV .. "/**/bin/" .. executable_name, true, true)
    local executable_path = table.concat(paths, ", ")
    if executable_path ~= "" then
      -- vim.api.nvim_echo(
      -- 	{ { "Using path for " .. executable_name .. ": " .. executable_path, "None" } },
      -- 	false,
      -- 	{}
      -- )
      return executable_path
    end
  end

  local mason_registry = require("mason-registry")
  local mason_path = mason_registry.get_package(executable_name):get_install_path() .. "/venv/bin/" .. executable_name
  -- vim.api.nvim_echo({ { "Using path for " .. executable_name .. ": " .. mason_path, "None" } }, false, {})
  return mason_path
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              disableOrganizeImports = true,
              analysis = {
                ignore = { "*" },
              },
            },
          },
        },
      },
      setup = {
        ruff = { mason = false, enabled = false },
        ruff_lsp = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "ruff_lsp" then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end)

          -- Organize Imports on save file
          vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function()
              local params = vim.lsp.util.make_range_params()
              params.context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }

              local clients = vim.lsp.get_clients({ bufnr = 0, method = "textDocument/codeAction" })
              if #clients == 0 then
                return
              end

              local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
              if not results then
                return
              end

              for _, result in pairs(results) do
                for _, action in pairs(result.result or {}) do
                  if action.kind == "source.organizeImports" then
                    vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
                    vim.wait(100)
                    break
                  end
                end
              end
            end,
          })
        end,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "mypy",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    enabled = true,
    opts = function(_, opts)
      local linters = require("lint").linters

      linters.mypy.cmd = prefer_bin_from_venv("mypy")

      local linters_by_ft = {
        python = { "mypy" },
      }

      -- extend opts.linters_by_ft
      for ft, linters_ in pairs(linters_by_ft) do
        opts.linters_by_ft[ft] = opts.linters_by_ft[ft] or {}
        vim.list_extend(opts.linters_by_ft[ft], linters_)
      end
    end,
  },
}
