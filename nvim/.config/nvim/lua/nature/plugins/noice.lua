return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      progress = {
        enabled = false, -- Disables the LSP loading/progress messages
      },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}
