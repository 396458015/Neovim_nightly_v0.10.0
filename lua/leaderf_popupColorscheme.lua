if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
    vim.api.nvim_command(" hi Lf_hl_popup_inputText    guifg=#b3b9c5 ctermfg=102 guibg=#27253f ctermbg=17")
    vim.api.nvim_command(" hi Lf_hl_popup_window       guifg=#b3b9c5 ctermfg=102 guibg=#27253f ctermbg=17")
    vim.api.nvim_command(" hi Lf_hl_popup_blank        guibg=#27253f ctermbg=23")
    vim.api.nvim_command(" hi Lf_hl_popup_cursor       guifg=#657b83 ctermfg=66  guibg=#93a1a1 ctermbg=109")
    vim.api.nvim_command(" hi Lf_hl_popup_prompt       guifg=#d3366f ctermfg=136 guibg=#27253f ctermbg=17   gui=bold cterm=bold")
    vim.api.nvim_command(" hi Lf_hl_popup_spin         guifg=#c4c9d2 ctermfg=230 guibg=#27253f ctermbg=17")
    vim.api.nvim_command(" hi Lf_hl_popup_normalMode   guifg=#c4c9d2 ctermfg=230 guibg=#93a1a1 ctermbg=109  gui=bold cterm=bold")
    vim.api.nvim_command(" hi Lf_hl_popup_inputMode    guifg=#c4c9d2 ctermfg=230 guibg=#d3366f ctermbg=136  gui=bold cterm=bold")
    vim.api.nvim_command(" hi Lf_hl_popup_category     guifg=#eee8d5 ctermfg=224 guibg=#657b83 ctermbg=66")
    vim.api.nvim_command(" hi Lf_hl_popup_nameOnlyMode guifg=#eee8d5 ctermfg=224 guibg=#268bd2 ctermbg=32")
    vim.api.nvim_command(" hi Lf_hl_popup_fullPathMode guifg=#eee8d5 ctermfg=224 guibg=#586e75 ctermbg=60")
    vim.api.nvim_command(" hi Lf_hl_popup_fuzzyMode    guifg=#eee8d5 ctermfg=224 guibg=#586e75 ctermbg=60")
    vim.api.nvim_command(" hi Lf_hl_popup_regexMode    guifg=#eee8d5 ctermfg=224 guibg=#dc322f ctermbg=166")
    vim.api.nvim_command(" hi Lf_hl_popup_cwd          guifg=#93a1a1 ctermfg=109 guibg=#27253f ctermbg=23")
    vim.api.nvim_command(" hi Lf_hl_popup_lineInfo     guifg=#eee8d5 ctermfg=224 guibg=#657b83 ctermbg=66")
    vim.api.nvim_command(" hi Lf_hl_popup_total        guifg=#c4c9d2 ctermfg=230 guibg=#93a1a1 ctermbg=109")

    vim.api.nvim_command("hi link Lf_hl_popupBorder Normal")

    vim.api.nvim_command("hi Lf_hl_cursorline         guifg=#c4c9d2 ctermfg=230")

    vim.api.nvim_command("hi Lf_hl_match              guifg=#d3366f ctermfg=136 guibg=NONE    ctermbg=NONE gui=bold cterm=bold")
    vim.api.nvim_command("hi Lf_hl_match0             guifg=#d33682 ctermfg=168 guibg=NONE    ctermbg=NONE gui=bold cterm=bold")
    vim.api.nvim_command("hi Lf_hl_match1             guifg=#6c71c4 ctermfg=62  guibg=NONE    ctermbg=NONE gui=bold cterm=bold")
    vim.api.nvim_command("hi Lf_hl_match2             guifg=#268bd2 ctermfg=32  guibg=NONE    ctermbg=NONE gui=bold cterm=bold")
    vim.api.nvim_command("hi Lf_hl_match3             guifg=#2aa198 ctermfg=36  guibg=NONE    ctermbg=NONE gui=bold cterm=bold")
    vim.api.nvim_command("hi Lf_hl_match4             guifg=#859900 ctermfg=100 guibg=NONE    ctermbg=NONE gui=bold cterm=bold")
    vim.api.nvim_command("hi Lf_hl_matchRefine        guifg=#cb4b16 ctermfg=166")
elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
    vim.api.nvim_command("hi Lf_hl_popup_inputText    guifg=#657b83 ctermfg=66  guibg=#e1e2e7 ctermbg=230")
    vim.api.nvim_command("hi Lf_hl_popup_window       guifg=#657b83 ctermfg=66  guibg=#e1e2e7 ctermbg=230")
    vim.api.nvim_command("hi Lf_hl_popup_blank        guibg=#eee8d5 ctermbg=224")
    vim.api.nvim_command("hi Lf_hl_popup_cursor       guifg=#d3366f ctermfg=136 guibg=#586e75 ctermbg=60")
    vim.api.nvim_command("hi Lf_hl_popup_prompt       guifg=#27253f ctermfg=23  guibg=#e1e2e7 ctermbg=230  gui=bold cterm=bold")
    vim.api.nvim_command("hi Lf_hl_popup_spin         guifg=#27253f ctermfg=17  guibg=#e1e2e7 ctermbg=230")
    vim.api.nvim_command("hi Lf_hl_popup_normalMode   guifg=#e1e2e7 ctermfg=230 guibg=#586e75 ctermbg=60   gui=bold cterm=bold")
    vim.api.nvim_command("hi Lf_hl_popup_inputMode    guifg=#e1e2e7 ctermfg=230 guibg=#d3366f ctermbg=136  gui=bold cterm=bold")
    vim.api.nvim_command("hi Lf_hl_popup_category     guifg=#eee8d5 ctermfg=224 guibg=#abb2bf ctermbg=102")
    vim.api.nvim_command("hi Lf_hl_popup_nameOnlyMode guifg=#eee8d5 ctermfg=224 guibg=#268bd2 ctermbg=32")
    vim.api.nvim_command("hi Lf_hl_popup_fullPathMode guifg=#eee8d5 ctermfg=224 guibg=#93a1a1 ctermbg=109")
    vim.api.nvim_command("hi Lf_hl_popup_fuzzyMode    guifg=#eee8d5 ctermfg=224 guibg=#93a1a1 ctermbg=109")
    vim.api.nvim_command("hi Lf_hl_popup_regexMode    guifg=#eee8d5 ctermfg=224 guibg=#dc322f ctermbg=166")
    vim.api.nvim_command("hi Lf_hl_popup_cwd          guifg=#586e75 ctermfg=60  guibg=#eee8d5 ctermbg=224")
    vim.api.nvim_command("hi Lf_hl_popup_lineInfo     guifg=#eee8d5 ctermfg=224 guibg=#abb2bf ctermbg=102")
    vim.api.nvim_command("hi Lf_hl_popup_total        guifg=#e1e2e7 ctermfg=230 guibg=#586e75 ctermbg=60")

    vim.api.nvim_command("hi link Lf_hl_popupBorder Normal")

    vim.api.nvim_command("hi Lf_hl_cursorline         guifg=#002b36 ctermfg=17")

    vim.api.nvim_command("hi Lf_hl_match              guifg=#d3366f ctermfg=136 guibg=NONE    ctermbg=NONE gui=bold cterm=bold")
    vim.api.nvim_command("hi Lf_hl_match0             guifg=#d33682 ctermfg=168 guibg=NONE    ctermbg=NONE gui=bold cterm=bold")
    vim.api.nvim_command("hi Lf_hl_match1             guifg=#6c71c4 ctermfg=62  guibg=NONE    ctermbg=NONE gui=bold cterm=bold")
    vim.api.nvim_command("hi Lf_hl_match2             guifg=#268bd2 ctermfg=32  guibg=NONE    ctermbg=NONE gui=bold cterm=bold")
    vim.api.nvim_command("hi Lf_hl_match3             guifg=#2aa198 ctermfg=36  guibg=NONE    ctermbg=NONE gui=bold cterm=bold")
    vim.api.nvim_command("hi Lf_hl_match4             guifg=#859900 ctermfg=100 guibg=NONE    ctermbg=NONE gui=bold cterm=bold")
    vim.api.nvim_command("hi Lf_hl_matchRefine        guifg=#cb4b16 ctermfg=166 guibg=NONE    ctermbg=NONE gui=bold cterm=bold")
end










