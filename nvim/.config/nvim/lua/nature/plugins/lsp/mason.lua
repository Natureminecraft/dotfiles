return {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    -- list of servers for mason to install
    ensure_installed = {
      "html",
      "cssls",
      "tailwindcss",
      "lua_ls",
      "bashls",
      "pyright",
      "jsonls"
    },
  },
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "󰁔",
            package_uninstalled = "󰅖",
          },
        },
      },
    },
    "neovim/nvim-lspconfig"
  },
}
