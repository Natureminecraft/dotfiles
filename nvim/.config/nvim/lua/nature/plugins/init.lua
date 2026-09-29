-- Compatibility shim for Neovim 0.10+
if vim.treesitter.language.ft_to_lang == nil then
  vim.treesitter.language.ft_to_lang = function(ft)
    local ok, lang = pcall(vim.treesitter.language.get_lang, ft)
    return ok and lang or ft
  end
end
return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  "christoomey/vim-tmux-navigator", -- tmux & split window navigation
}
