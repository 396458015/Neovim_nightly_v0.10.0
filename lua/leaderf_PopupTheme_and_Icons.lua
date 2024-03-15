if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
    vim.cmd[[
     hi Lf_hl_popup_inputText    guifg=#b3b9c5 ctermfg=102 guibg=#27253f ctermbg=17
     hi Lf_hl_popup_window       guifg=#b3b9c5 ctermfg=102 guibg=#27253f ctermbg=17
     hi Lf_hl_popup_blank        guibg=#27253f ctermbg=23
     hi Lf_hl_popup_cursor       guifg=#657b83 ctermfg=66  guibg=#93a1a1 ctermbg=109
     hi Lf_hl_popup_prompt       guifg=#d3366f ctermfg=136 guibg=#27253f ctermbg=17   gui=bold cterm=bold
     hi Lf_hl_popup_spin         guifg=#c4c9d2 ctermfg=230 guibg=#27253f ctermbg=17
     hi Lf_hl_popup_normalMode   guifg=#c4c9d2 ctermfg=230 guibg=#93a1a1 ctermbg=109  gui=bold cterm=bold
     hi Lf_hl_popup_inputMode    guifg=#c4c9d2 ctermfg=230 guibg=#d3366f ctermbg=136  gui=bold cterm=bold
     hi Lf_hl_popup_category     guifg=#eee8d5 ctermfg=224 guibg=#657b83 ctermbg=66
     hi Lf_hl_popup_nameOnlyMode guifg=#eee8d5 ctermfg=224 guibg=#268bd2 ctermbg=32
     hi Lf_hl_popup_fullPathMode guifg=#eee8d5 ctermfg=224 guibg=#586e75 ctermbg=60
     hi Lf_hl_popup_fuzzyMode    guifg=#eee8d5 ctermfg=224 guibg=#586e75 ctermbg=60
     hi Lf_hl_popup_regexMode    guifg=#eee8d5 ctermfg=224 guibg=#dc322f ctermbg=166
     hi Lf_hl_popup_cwd          guifg=#93a1a1 ctermfg=109 guibg=#27253f ctermbg=23
     hi Lf_hl_popup_lineInfo     guifg=#eee8d5 ctermfg=224 guibg=#657b83 ctermbg=66
     hi Lf_hl_popup_total        guifg=#c4c9d2 ctermfg=230 guibg=#93a1a1 ctermbg=109

     hi link Lf_hl_popupBorder Normal

     hi Lf_hl_cursorline         guifg=#c4c9d2 ctermfg=230")

     hi Lf_hl_match              guifg=#d3366f ctermfg=136 guibg=NONE    ctermbg=NONE gui=bold cterm=bold
     hi Lf_hl_match0             guifg=#d33682 ctermfg=168 guibg=NONE    ctermbg=NONE gui=bold cterm=bold
     hi Lf_hl_match1             guifg=#6c71c4 ctermfg=62  guibg=NONE    ctermbg=NONE gui=bold cterm=bold
     hi Lf_hl_match2             guifg=#268bd2 ctermfg=32  guibg=NONE    ctermbg=NONE gui=bold cterm=bold
     hi Lf_hl_match3             guifg=#2aa198 ctermfg=36  guibg=NONE    ctermbg=NONE gui=bold cterm=bold
     hi Lf_hl_match4             guifg=#859900 ctermfg=100 guibg=NONE    ctermbg=NONE gui=bold cterm=bold
     hi Lf_hl_matchRefine        guifg=#cb4b16 ctermfg=166")
    ]]
elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
    vim.cmd[[
    hi Lf_hl_popup_inputText    guifg=#657b83 ctermfg=66  guibg=#e1e2e7 ctermbg=230
    hi Lf_hl_popup_window       guifg=#657b83 ctermfg=66  guibg=#e1e2e7 ctermbg=230
    hi Lf_hl_popup_blank        guibg=#eee8d5 ctermbg=224
    hi Lf_hl_popup_cursor       guifg=#d3366f ctermfg=136 guibg=#586e75 ctermbg=60
    hi Lf_hl_popup_prompt       guifg=#27253f ctermfg=23  guibg=#e1e2e7 ctermbg=230  gui=bold cterm=bold
    hi Lf_hl_popup_spin         guifg=#27253f ctermfg=17  guibg=#e1e2e7 ctermbg=230
    hi Lf_hl_popup_normalMode   guifg=#e1e2e7 ctermfg=230 guibg=#586e75 ctermbg=60   gui=bold cterm=bold
    hi Lf_hl_popup_inputMode    guifg=#e1e2e7 ctermfg=230 guibg=#d3366f ctermbg=136  gui=bold cterm=bold
    hi Lf_hl_popup_category     guifg=#eee8d5 ctermfg=224 guibg=#abb2bf ctermbg=102
    hi Lf_hl_popup_nameOnlyMode guifg=#eee8d5 ctermfg=224 guibg=#268bd2 ctermbg=32
    hi Lf_hl_popup_fullPathMode guifg=#eee8d5 ctermfg=224 guibg=#93a1a1 ctermbg=109
    hi Lf_hl_popup_fuzzyMode    guifg=#eee8d5 ctermfg=224 guibg=#93a1a1 ctermbg=109
    hi Lf_hl_popup_regexMode    guifg=#eee8d5 ctermfg=224 guibg=#dc322f ctermbg=166
    hi Lf_hl_popup_cwd          guifg=#586e75 ctermfg=60  guibg=#eee8d5 ctermbg=224
    hi Lf_hl_popup_lineInfo     guifg=#eee8d5 ctermfg=224 guibg=#abb2bf ctermbg=102
    hi Lf_hl_popup_total        guifg=#e1e2e7 ctermfg=230 guibg=#586e75 ctermbg=60

    hi link Lf_hl_popupBorder Normal

    hi Lf_hl_cursorline         guifg=#002b36 ctermfg=17

    hi Lf_hl_match              guifg=#d3366f ctermfg=136 guibg=NONE    ctermbg=NONE gui=bold cterm=bold
    hi Lf_hl_match0             guifg=#d33682 ctermfg=168 guibg=NONE    ctermbg=NONE gui=bold cterm=bold
    hi Lf_hl_match1             guifg=#6c71c4 ctermfg=62  guibg=NONE    ctermbg=NONE gui=bold cterm=bold
    hi Lf_hl_match2             guifg=#268bd2 ctermfg=32  guibg=NONE    ctermbg=NONE gui=bold cterm=bold
    hi Lf_hl_match3             guifg=#2aa198 ctermfg=36  guibg=NONE    ctermbg=NONE gui=bold cterm=bold
    hi Lf_hl_match4             guifg=#859900 ctermfg=100 guibg=NONE    ctermbg=NONE gui=bold cterm=bold
    hi Lf_hl_matchRefine        guifg=#cb4b16 ctermfg=166 guibg=NONE    ctermbg=NONE gui=bold cterm=bold
    ]]
end

-- 修改leaderf的icon和icon颜色
vim.g.Lf_DevIconsExtensionSymbols = {
    ["txt"]   =   "",
    ["md"]    =   "",
    ["tex"]   =   "ﭨ",
    ["org"]   =   "",
    ["norg"]  =   "",
    ["zip"]   =   "",
    ["rar"]   =   "",
    ["tar"]   =   "",
    ["gz"]    =   "",
    ["7z"]    =   "",
    ["bz2"]   =   "",
    ["xz"]    =   "",
    ["pdf"]   =   "",
    ["caj"]   =   "",
    ["doc"]   =   "",
    ["doct"]  =   "",
    ["docx"]  =   "",
    ["dot"]   =   "",
    ["pom"]   =   "",
    ["pot"]   =   "",
    ["ppm"]   =   "",
    ["pps"]   =   "",
    ["ppt"]   =   "",
    ["potx"]  =   "",
    ["ppmx"]  =   "",
    ["ppsx"]  =   "",
    ["pptx"]  =   "",
    ["xlc"]   =   "",
    ["xlm"]   =   "",
    ["xls"]   =   "",
    ["xlt"]   =   "",
    ["xlsm"]  =   "",
    ["xlsx"]  =   "",
    ["csv"]   =   "",
    ["ods"]   =   "",
    ["ots"]   =   "",
    ["mp3"]   =   "",
    ["flac"]  =   "",
    ["wav"]   =   "",
    ["aac"]   =   "",
    ["ogg"]   =   "",
    ["m4a"]   =   "",
    ["mp2"]   =   "",
    ["mp4"]   =   "",
    ["mkv"]   =   "",
    ["avi"]   =   "",
    ["mov"]   =   "",
    ["webm"]  =   "",
    ["rmvb"]  =   "",
    ["jpg"]   =   "",
    ["jpeg"]  =   "",
    ["tif"]   =   "",
    ["png"]   =   "",
    ["gif"]   =   "",
    ["emf"]   =   "",
    ["webp"]  =   "",
    ["bmp"]   =   "",
    ["ico"]   =   "",
    ["svg"]   =   "",
    ["c"]     =   "",
    ["cpp"]   =   "",
    ["h"]     =   "",
    ["hpp"]   =   "",
    ["rs"]    =   "",
    ["go"]    =   "",
    ["py"]    =   "",
    ["pyc"]   =   "",
    ["pyd"]   =   "",
    ["pyi"]   =   "",
    ["pyo"]   =   "",
    ["pyx"]   =   "",
    ["js"]    =   "",
    ["ts"]    =   "",
    ["tsx"]   =   "",
    ["jsx"]   =   "",
    ["rb"]    =   "",
    ["php"]   =   "",
    ["java"]  =   "",
    ["sh"]    =   "",
    ["vim"]   =   "",
    ["lua"]   =   "",
    ["html"]  =   "",
    ["css"]   =   "",
    ["scss"]  =   "",
    ["json"]  =   "",
    ["toml"]  =   "",
    ["yml"]   =   "",
    ["yaml"]  =   "",
    ["ini"]   =   "",
    ["conf"]  =   "",
    ["lock"]  =   "",
    ["nix"]   =   "",
    ["m"]     =   "",
    ["for"]   =   "",
    ["lnk"]   =   "",
    ["opju"]  =   "ﴝ",
    ["log"]   =   "",
    ["DAT"]   =   "",
    ["db"]    =   "",
    ["dll"]   =   "",
    ["ahk"]   =   "",
    ["tmp"]   =   "",
    ["el"]    =   "",
    ["lib"]   =   "",
    ["ttf"]   =   "",
    ["otf"]   =   "",
    ["stp"]   =   "",
    ["step"]  =   "",
    ["igs"]   =   "",
    ["iges"]  =   "",
    ["x_t"]   =   "",
    ["cae"]   =   "",
    ["inp"]   =   "",
    ["rpy"]   =   "",
    ["odb"]   =   "",
    ["com"]   =   "",
    ["prt"]   =   "",
    ["msg"]   =   "",
    ["hm"]    =   "ﴧ",
    ["cfg"]   =   "",
    ["bin"]   =   "",
    ["exe"]   =   "",
    ["pkg"]   =   "",
    ["bat"]   =   "",
    ["xmind"] =   "",
}
vim.g.Lf_DevIconsPalette = {
    dark = {
        ["txt"]    =  { guifg = "#89e051", ctermfg = "15" },
        ["md"]     =  { guifg = "#ffffff", ctermfg = "15" },
        ["tex"]    =  { guifg = "#46c8a8", ctermfg = "15" },
        ["org"]    =  { guifg = "#5dbd7e", ctermfg = "15" },
        ["norg"]   =  { guifg = "#5dbd7e", ctermfg = "15" },
        ["zip"]    =  { guifg = "#f4b8e4", ctermfg = "15" },
        ["rar"]    =  { guifg = "#f4b8e4", ctermfg = "15" },
        ["tar"]    =  { guifg = "#f4b8e4", ctermfg = "15" },
        ["gz"]     =  { guifg = "#f4b8e4", ctermfg = "15" },
        ["7z"]     =  { guifg = "#f4b8e4", ctermfg = "15" },
        ["bz2"]    =  { guifg = "#f4b8e4", ctermfg = "15" },
        ["xz"]     =  { guifg = "#f4b8e4", ctermfg = "15" },
        ["pdf"]    =  { guifg = "#b30b00", ctermfg = "15" },
        ["caj"]    =  { guifg = "#b30b00", ctermfg = "15" },
        ["doc"]    =  { guifg = "#185abd", ctermfg = "15" },
        ["doct"]   =  { guifg = "#185abd", ctermfg = "15" },
        ["docx"]   =  { guifg = "#185abd", ctermfg = "15" },
        ["dot"]    =  { guifg = "#185abd", ctermfg = "15" },
        ["pom"]    =  { guifg = "#cb4a32", ctermfg = "15" },
        ["pot"]    =  { guifg = "#cb4a32", ctermfg = "15" },
        ["ppm"]    =  { guifg = "#cb4a32", ctermfg = "15" },
        ["pps"]    =  { guifg = "#cb4a32", ctermfg = "15" },
        ["ppt"]    =  { guifg = "#cb4a32", ctermfg = "15" },
        ["potx"]   =  { guifg = "#cb4a32", ctermfg = "15" },
        ["ppmx"]   =  { guifg = "#cb4a32", ctermfg = "15" },
        ["ppsx"]   =  { guifg = "#cb4a32", ctermfg = "15" },
        ["pptx"]   =  { guifg = "#cb4a32", ctermfg = "15" },
        ["xlc"]    =  { guifg = "#207245", ctermfg = "15" },
        ["xlm"]    =  { guifg = "#207245", ctermfg = "15" },
        ["xls"]    =  { guifg = "#207245", ctermfg = "15" },
        ["xlt"]    =  { guifg = "#207245", ctermfg = "15" },
        ["xlsm"]   =  { guifg = "#207245", ctermfg = "15" },
        ["xlsx"]   =  { guifg = "#207245", ctermfg = "15" },
        ["csv"]    =  { guifg = "#207245", ctermfg = "15" },
        ["ods"]    =  { guifg = "#207245", ctermfg = "15" },
        ["ots"]    =  { guifg = "#207245", ctermfg = "15" },
        ["mp3"]    =  { guifg = "#d39ede", ctermfg = "15" },
        ["flac"]   =  { guifg = "#d39ede", ctermfg = "15" },
        ["wav"]    =  { guifg = "#d39ede", ctermfg = "15" },
        ["aac"]    =  { guifg = "#d39ede", ctermfg = "15" },
        ["ogg"]    =  { guifg = "#d39ede", ctermfg = "15" },
        ["m4a"]    =  { guifg = "#d39ede", ctermfg = "15" },
        ["mp2"]    =  { guifg = "#d39ede", ctermfg = "15" },
        ["mp4"]    =  { guifg = "#9ea3de", ctermfg = "15" },
        ["mkv"]    =  { guifg = "#9ea3de", ctermfg = "15" },
        ["avi"]    =  { guifg = "#9ea3de", ctermfg = "15" },
        ["mov"]    =  { guifg = "#9ea3de", ctermfg = "15" },
        ["webm"]   =  { guifg = "#9ea3de", ctermfg = "15" },
        ["rmvb"]   =  { guifg = "#9ea3de", ctermfg = "15" },
        ["jpg"]    =  { guifg = "#3AFFDB", ctermfg = "15" },
        ["jpeg"]   =  { guifg = "#3AFFDB", ctermfg = "15" },
        ["tif"]    =  { guifg = "#3AFFDB", ctermfg = "15" },
        ["png"]    =  { guifg = "#3AFFDB", ctermfg = "15" },
        ["gif"]    =  { guifg = "#3AFFDB", ctermfg = "15" },
        ["emf"]    =  { guifg = "#3AFFDB", ctermfg = "15" },
        ["webp"]   =  { guifg = "#3AFFDB", ctermfg = "15" },
        ["bmp"]    =  { guifg = "#3AFFDB", ctermfg = "15" },
        ["ico"]    =  { guifg = "#3AFFDB", ctermfg = "15" },
        ["svg"]    =  { guifg = "#3AFFDB", ctermfg = "15" },
        ["c"]      =  { guifg = "#519aba", ctermfg = "15" },
        ["cpp"]    =  { guifg = "#519aba", ctermfg = "15" },
        ["h"]      =  { guifg = "#a074c4", ctermfg = "15" },
        ["hpp"]    =  { guifg = "#a074c4", ctermfg = "15" },
        ["rs"]     =  { guifg = "#dea584", ctermfg = "15" },
        ["go"]     =  { guifg = "#7FD6E9", ctermfg = "15" },
        ["py"]     =  { guifg = "#FFBC03", ctermfg = "15" },
        ["pyc"]    =  { guifg = "#ffe291", ctermfg = "15" },
        ["pyd"]    =  { guifg = "#ffe291", ctermfg = "15" },
        ["pyi"]    =  { guifg = "#ffbc03", ctermfg = "15" },
        ["pyo"]    =  { guifg = "#ffe291", ctermfg = "15" },
        ["pyx"]    =  { guifg = "#5aa7e4", ctermfg = "15" },
        ["js"]     =  { guifg = "#cbcb41", ctermfg = "15" },
        ["ts"]     =  { guifg = "#519aba", ctermfg = "15" },
        ["tsx"]    =  { guifg = "#519aba", ctermfg = "15" },
        ["jsx"]    =  { guifg = "#519aba", ctermfg = "15" },
        ["rb"]     =  { guifg = "#701516", ctermfg = "15" },
        ["php"]    =  { guifg = "#a074c4", ctermfg = "15" },
        ["java"]   =  { guifg = "#cc3e44", ctermfg = "15" },
        ["sh"]     =  { guifg = "#4d5a5e", ctermfg = "15" },
        ["vim"]    =  { guifg = "#019833", ctermfg = "15" },
        ["lua"]    =  { guifg = "#51a0cf", ctermfg = "15" },
        ["html"]   =  { guifg = "#e34c26", ctermfg = "15" },
        ["css"]    =  { guifg = "#61afef", ctermfg = "15" },
        ["scss"]   =  { guifg = "#f55385", ctermfg = "15" },
        ["json"]   =  { guifg = "#cbcb41", ctermfg = "15" },
        ["toml"]   =  { guifg = "#6d8086", ctermfg = "15" },
        ["yml"]    =  { guifg = "#6d8086", ctermfg = "15" },
        ["yaml"]   =  { guifg = "#6d8086", ctermfg = "15" },
        ["ini"]    =  { guifg = "#6d8086", ctermfg = "15" },
        ["conf"]   =  { guifg = "#6d8086", ctermfg = "15" },
        ["lock"]   =  { guifg = "#f80000", ctermfg = "15" },
        ["nix"]    =  { guifg = "#7ebae4", ctermfg = "15" },
        ["m"]      =  { guifg = "#c04c0b", ctermfg = "15" },
        ["for"]    =  { guifg = "#bd93f9", ctermfg = "15" },
        ["lnk"]    =  { guifg = "#e3459f", ctermfg = "15" },
        ["opju"]   =  { guifg = "#f66d54", ctermfg = "15" },
        ["log"]    =  { guifg = "#6d8086", ctermfg = "15" },
        ["DAT"]    =  { guifg = "#7ebae4", ctermfg = "15" },
        ["db"]     =  { guifg = "#6d8086", ctermfg = "15" },
        ["dll"]    =  { guifg = "#6d8086", ctermfg = "15" },
        ["ahk"]    =  { guifg = "#019833", ctermfg = "15" },
        ["tmp"]    =  { guifg = "#ffffff", ctermfg = "15" },
        ["el"]     =  { guifg = "#7f5ab6", ctermfg = "15" },
        ["lib"]    =  { guifg = "#ffffff", ctermfg = "15" },
        ["ttf"]    =  { guifg = "#ECECEC", ctermfg = "15" },
        ["otf"]    =  { guifg = "#ECECEC", ctermfg = "15" },
        ["stp"]    =  { guifg = "#4273ca", ctermfg = "15" },
        ["step"]   =  { guifg = "#4273ca", ctermfg = "15" },
        ["igs"]    =  { guifg = "#4273ca", ctermfg = "15" },
        ["iges"]   =  { guifg = "#4273ca", ctermfg = "15" },
        ["x_t"]    =  { guifg = "#4273ca", ctermfg = "15" },
        ["cae"]    =  { guifg = "#11a7a3", ctermfg = "15" },
        ["inp"]    =  { guifg = "#11a7a3", ctermfg = "15" },
        ["rpy"]    =  { guifg = "#ffe291", ctermfg = "15" },
        ["odb"]    =  { guifg = "#11a7a3", ctermfg = "15" },
        ["com"]    =  { guifg = "#11a7a3", ctermfg = "15" },
        ["prt"]    =  { guifg = "#11a7a3", ctermfg = "15" },
        ["msg"]    =  { guifg = "#11a7a3", ctermfg = "15" },
        ["hm"]     =  { guifg = "#fa4616", ctermfg = "15" },
        ["cfg"]    =  { guifg = "#6d8086", ctermfg = "15" },
        ["bin"]    =  { guifg = "#05a6f0", ctermfg = "15" },
        ["exe"]    =  { guifg = "#00fa9a", ctermfg = "15" },
        ["pkg"]    =  { guifg = "#10bb10", ctermfg = "15" },
        ["bat"]    =  { guifg = "#C1F12E", ctermfg = "15" },
        ["xmind"]  =  { guifg = "#f4b8e4", ctermfg = "15" },
    }
}
