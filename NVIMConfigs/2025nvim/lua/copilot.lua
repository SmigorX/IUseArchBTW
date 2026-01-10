return {
    "github/copilot.vim",
    config = function()
      -- Keybindings for Copilot
      vim.g.copilot_no_tab_map = true   -- Disable default <Tab> mapping
      vim.api.nvim_set_keymap("i", "<C-l>", "copilot#Accept('<CR>')", { expr = true, silent = true })
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      
      -- Copilot suggestion appearance
      vim.cmd("highlight CopilotSuggestion guifg=#555555 ctermfg=8")  -- Set a dim color for suggestions
    end,
}
