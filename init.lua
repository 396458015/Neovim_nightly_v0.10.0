-- Last Modified Date: 2023.04.24
-- Desc              : NEOVIM 0.10.0(support Python, Lua)
--                          __
--  __  ____   __   __  __ /\_\    ___ ___     ____   ____
-- |  \/  \ \ / /  /\ \/\ \\/\ \ /'' __` _`\  |  _ \ / ___|
-- | |\/| |\ V /   \ \ \_/ |\ \ \/\ \/\ \/\ \ | |_) | |
-- | |  | | | |     \ \___/  \ \_\ \_\ \_\ \_\|  _ <| |___
-- |_|  |_| |_|      \/__/    \/_/\/_/\/_/\/_/|_| \_\\____|
-- ========================================================

-- {{{ mapping - original neovim
vim.g.mapleader      = " "
vim.g.maplocalleader = ","

local neomap        = vim.keymap.set  -- vim.api.nvim_set_keymap
local key_opts_ns   = { noremap = true, silent = true }
local key_opts_n    = { noremap = true }
local key_opts_s    = { silent = true }
neomap("", ";", ":", key_opts_n)
neomap("n", "s", "<nop>", key_opts_ns)
neomap("x", "s", "<nop>", key_opts_ns)
neomap("n", "r", "<nop>", key_opts_ns)
neomap("x", "r", "<nop>", key_opts_ns)
neomap("n", "<Space>", "<nop>", key_opts_ns)
neomap("n", ",", "<nop>", key_opts_ns)
-- x,c仅复制,不更改寄存器.(d为剪切)
neomap("n", "x", "\"_x", key_opts_ns)
neomap("v", "x", "\"_x", key_opts_ns)
neomap("n", "c", "\"_c", key_opts_ns)
neomap("v", "c", "\"_c", key_opts_ns)
neomap("n", "Y", "y$", key_opts_ns)
neomap("v", "p", "pgvy", key_opts_ns)
neomap("v", "P", "Pgvy", key_opts_ns)
-- 光标移动
neomap("i", "<m-h>", "<Left>", key_opts_ns)
neomap("i", "<m-j>", "<Down>", key_opts_ns)
neomap("i", "<m-k>", "<Up>", key_opts_ns)
neomap("i", "<m-l>", "<Right>", key_opts_ns)
-- INSERT Mode下使用光标移动一个单词
neomap("i", "<C-h>", "<C-Left>", key_opts_ns)
neomap("i", "<C-l>", "<C-Right>", key_opts_ns)
-- Indentation
neomap("n", "<", "<<", key_opts_ns)
neomap("n", ">", ">>", key_opts_ns)
-- 单词的 选/改/删
--[[ neomap("n", "vi", "viw", key_opts_ns)
neomap("n", "ci", "ciw", key_opts_ns)
neomap("n", "di", "diw", key_opts_ns) ]]
-- IDE like delete
neomap("i", "<C-BS>", "<Esc>b\"_dei", key_opts_ns)
-- 代码折叠
neomap("n", "<Tab>", "@=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>", key_opts_ns)
-- zf:创建折叠;zd:删除折叠,仅在manual/marker中有效;zD:删除嵌套折叠,仅在manual/marker中有效;za:打开/关闭当前折叠;zM:关闭所有折叠;zR:打开所有折叠
-------------------- spell checking --------------------
-- 设置拼写检查开关
neomap('n', '<Leader>sc', ':set spell!<CR>', key_opts_ns)
-- 拼写检查导航
neomap('n', '<leader>sn', ']s', key_opts_ns)
neomap('n', '<leader>sp', '[s', key_opts_ns)
neomap('n', '<leader>sa', 'zg', key_opts_ns)
-- 显示单词拼写建议
neomap('n', '<leader>s?', 'z=', key_opts_ns)
-- 查找并替换
neomap('n', '<leader>z', [[:%s/\<<C-R>=expand("<cword>")<CR>\>/<C-R>=expand("<cword>")<CR>/g<left><left>]], key_opts_n)
neomap('v', '<leader>z', [[:s///g<left><left><left>]], key_opts_n)
-- 创建列表
neomap('n', '<leader>b', [[:put =range(,,1)<left><left><left><left>]], key_opts_n)
-------------------- 分屏 --------------------
neomap('n', '<C-F12>', [[:set splitright<CR>:vsplit<CR>]], key_opts_ns)
neomap('n', '<C-F11>', [[:set splitbelow<CR>:split<CR>]], key_opts_ns)
-- 互换分割窗口
neomap('n', '<S-h>', '<C-w>b<C-w>H', key_opts_ns)
-- neomap('n', 'srh', '<C-w>b<C-w>K', {}) -- 注释掉，因为与 <S-h> 冲突
-- 光标移动
neomap('n', '<C-l>', '<C-W><C-L>', key_opts_ns)
neomap('n', '<C-h>', '<C-W><C-H>', key_opts_ns)
-- neomap('n', '<C-j>', '<C-W><C-J>', {}) -- 注释掉，因为与终端分屏窗口移动冲突
-- neomap('n', '<C-k>', '<C-W><C-K>', {}) -- 注释掉，因为与终端分屏窗口移动冲突
-- 终端分屏窗口移动，split navigations,smart way to move between windows
neomap('t', '<C-h>', '<C-w><C-h>', key_opts_s)
neomap('t', '<C-j>', '<C-w><C-j>', key_opts_s)
neomap('t', '<C-k>', '<C-w><C-k>', key_opts_s)
neomap('t', '<C-l>', '<C-w><C-l>', key_opts_s)
neomap('t', '<Esc>', '<C-\\><C-n>', key_opts_s)
-- 调整分屏尺寸
neomap('n', '<S-up>', ':resize -3<CR>', key_opts_ns)
neomap('n', '<S-down>', ':resize +3<CR>', key_opts_ns)
neomap('n', '<S-left>', ':vertical resize +3<CR>', key_opts_ns)
neomap('n', '<S-right>', ':vertical resize -3<CR>', key_opts_ns)
-------------------- 标签页 --------------------
-- 支持Alt+n切换标签页
neomap('n', '<M-1>', '1gt', key_opts_ns)
neomap('n', '<M-2>', '2gt', key_opts_ns)
neomap('n', '<M-3>', '3gt', key_opts_ns)
neomap('n', '<M-4>', '4gt', key_opts_ns)
neomap('n', '<M-5>', '5gt', key_opts_ns)
neomap('n', '<M-6>', '6gt', key_opts_ns)
neomap('n', '<M-7>', '7gt', key_opts_ns)
neomap('n', '<M-8>', '8gt', key_opts_ns)
neomap('n', '<M-9>', '9gt', key_opts_ns)
neomap('n', '<M-0>', ':tablast<CR>', key_opts_ns)
-- Alt+左右键来移动标签顺序
neomap('n', '<M-left>', [[<Cmd>if tabpagenr() == 1 | execute "tabm " . tabpagenr("$") | else | execute "tabm " . (tabpagenr()-2) | endif<CR>]], key_opts_ns)
neomap('n', '<M-right>', [[<Cmd>if tabpagenr() == tabpagenr("$") | tabm 0 | else | execute "tabm " . tabpagenr() | endif<CR>]], key_opts_ns)
------------- Command Mode related ---------------
neomap('c', '<C-a>', '<Home>', key_opts_n)
neomap('c', '<C-e>', '<End>', key_opts_n)
-- neomap('c', '<C-K>', '<C-U>', key_opts_n)
neomap('c', '<C-h>', '<C-Left>', key_opts_n)
neomap('c', '<C-l>', '<C-Right>', key_opts_n)
-- cmdline move
neomap('c', '<M-h>', '<left>', key_opts_n)
neomap('c', '<M-l>', '<right>', key_opts_n)
neomap('c', '<M-j>', '<down>', key_opts_n)
neomap('c', '<M-k>', '<up>', key_opts_n)
neomap('c', '<C-j>', '<down>', key_opts_n)
neomap('c', '<C-k>', '<up>', key_opts_n)
-- 在命令行粘贴的快捷键
neomap('c', '<C-V>', '<C-R>+', key_opts_n)
-- -------------------- function --------------------
-- open Startify
neomap('n', '<leader>st', ':Startify<CR>', key_opts_ns)
-- diff line
neomap('n', '<leader>dt', ':Linediff<CR>', key_opts_n)
-- vimrc
neomap('n', '<leader>rc', ':edit $MYVIMRC<CR>', key_opts_ns)
neomap('n', '<leader>rr', ':source $MYVIMRC<CR>', key_opts_ns)
-- 插入时间
vim.cmd([[iab xtime <c-r>=strftime("20%y-%m-%d %a %H:%M")<CR>]])
vim.cmd([[iab xdate <c-r>=strftime("20%y-%m-%d (%a)")<CR>]])
-- 取消高亮
neomap('n', '<BS>', ':nohl<CR>', key_opts_ns)
-- 显示列表，使用`.`表示空格
neomap('n', '<F3>', ':set list!<CR>', key_opts_ns)
neomap('i', '<F3>', '<C-o>:set list!<CR>', key_opts_ns)
neomap('c', '<F3>', '<C-c>:set list!<CR>', key_opts_ns)
-- 高亮光标行列
neomap('n', '<F4>', ':set cuc! cul!<CR>', key_opts_ns)
neomap('i', '<F4>', '<C-o>:set cuc! cul!<CR>', key_opts_ns)
-- }}}

-- {{{ font
vim.opt.guifont     = "Delugia Mono:h11.6"  -- Cascadia Code, others: 'CodeNewRoman\ NFM', 'OperatorMono\ NF', 'ComicMono\ NF'
vim.opt.guifontwide = "inconsolatago qihei nf:h12.5"  -- 中文 Nerd Font
-- Adjust fontsize
vim.cmd[[
let s:guifontsize=12
let s:guifont="Delugia\\ Mono"
let s:guifontwide="inconsolatago\\ qihei\\ nf"
function! AdjustFontSize(amount)
    let s:guifontsize = s:guifontsize + a:amount
    execute "set guifont=" .. s:guifont .. ":h" .. s:guifontsize
    execute "set guifontwide=" .. s:guifontwide .. ":h" .. s:guifontsize
endfunction
]]
-- keyboard
neomap("n", "<m-->", ":call AdjustFontSize(-1)<CR>", key_opts_ns)
neomap("n", "<m-=>", ":call AdjustFontSize(1)<CR>", key_opts_ns)
neomap("n", "<m-BS>", ":set guifont=Delugia\\ Mono:h12.01<CR>", key_opts_ns)
neomap("i", "<m-->", "<C-o>:call AdjustFontSize(-1)<CR>", key_opts_ns)
neomap("i", "<m-=>", "<C-o>:call AdjustFontSize(1)<CR>", key_opts_ns)
neomap("i", "<m-BS>", "<C-o>:set guifont=Delugia\\ Mono:h12.01<CR>", key_opts_ns)
-- mouse
neomap("n", "<m-ScrollWheelUp>", ":call AdjustFontSize(1)<CR>", key_opts_ns)
neomap("n", "<m-ScrollWheelDown>", ":call AdjustFontSize(-1)<CR>", key_opts_ns)
neomap("i", "<m-ScrollWheelUp>", "<ESC>:call AdjustFontSize(1)<CR>a", key_opts_ns)
neomap("i", "<m-ScrollWheelDown>", "<ESC>:call AdjustFontSize(-1)<CR>a", key_opts_ns)
-- }}}

-- {{{ options
local vim_opts = {
    autochdir = true,  -- 设定文件浏览器目录为当前目录
    autoindent = true,  -- 自动对齐
    backspace = "indent,eol,start",
    backup = false,
    backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
    clipboard = "unnamedplus",  -- Sync with system clipboard
    cmdheight = 1,
    confirm = true,
    cursorline = false,
    encoding = "utf-8",
    errorbells = false,
    expandtab = true,  -- 在输入tab后,vim用个空格来填充这个tab
    fileencoding = "utf-8",
    fileencodings = "utf-8,gbk,gb18030,big5,ucs-bom,euc-jp,latin1",
    foldenable = true,
    foldlevel = 33,
    foldmethod = 'marker',  -- 折叠类型---对文中标志折叠
    formatoptions = "1jcroql",
    hidden = true,  -- 允许在有未保存的修改时切换缓冲区
    hlsearch = true,
    ignorecase = true,  -- 忽略大小写
    incsearch = true,  -- 开启实时搜索功能
    laststatus = 2,
    linebreak = true,
    list = false,
    listchars = "trail:.,extends:>,precedes:<,space:.",
    magic = true,
    mouse = "a",
    number = true,
    relativenumber = true,
    ruler = false,  -- 右下角显示光标位置的状态行
    scrolloff = 5,  -- 设置目标行与顶部底部的距离(5行)
    sessionoptions = "buffers,curdir,help,tabpages,winsize",
    shiftround = true,
    shiftwidth = 4,  -- Size of an indent
    showcmd = true,
    showmatch = true,  -- 显示括号配对情况
    sidescroll = 5,
    sidescrolloff = 15,
    signcolumn = "yes",
    smartcase = true,
    smartindent = true,  -- Insert indents automatically
    softtabstop = 4,  -- 退格键的长度
    spelllang = "en_us",
    splitbelow = true,
    splitright = true,
    startofline = false,
    swapfile = false,
    tabstop = 4,  -- 设置tab键的宽度
    termguicolors = true,
    ttimeoutlen = 0,
    undofile = true,
    updatetime = 200,
    visualbell = true,
    whichwrap = "h,l,<,>,[,],~",  -- 允许backspace和光标键跨越行边界
    wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
    wildignorecase = true,
    wildmenu = true,
    wildmode = "longest:full,full",  -- Command-line completion mode
    wrap = true,
    writebackup = false,
}
for k, v in pairs(vim_opts) do
    vim.opt[k] = v
end

vim.cmd[[
language en
filetype indent on
filetype plugin on
set foldcolumn=2
]]
if vim.fn.has("nvim-0.9.0") == 1 then
  vim.opt.splitkeep = "screen"
  vim.opt.shortmess:append({ C = true })
end
-- Windows or WSL2: Requires equalsraf/win32yank.  try: choco install win32yank
vim.g.clipboard = {
    name = 'win32yank',
    copy = {
        ['+'] = 'win32yank.exe -i --crlf',
        ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
        ['+'] = 'win32yank.exe -o --lf',
        ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0,
}
-- ENV-Python
vim.g.python_host_prog  = 'C:/Python/Python311/python.exe'
vim.g.python3_host_prog = 'C:/Python/Python311/python.exe'
vim.cmd([[ let $PYTHONUNBUFFERED=1 ]]) -- 禁用python stdout缓冲 ]
-- Return to last edit position when opening files (You want this!)
vim.cmd([[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]])
-- }}}

-- {{{ Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "mg979/vim-visual-multi",
    keys = {
        {"<C-j>"},
        {"<C-k>"},
        {"<C-z>"},
        { "<C-n>", mode = { "n", "x" }, desc = "visual multi" },
    },
    init = function()
      vim.g.VM_highlight_matches = 'underline'
      vim.g.VM_maps = {
        ["Find Under"]         = "<C-n>",
        ["Find Subword Under"] = "<C-n>",
        ["Select All"]         = "<C-z>",
        ["Add Cursor Up"]      = "<C-k>",
        ["Add Cursor Down"]    = "<C-j>",
      }
    end,
  },
-- Local plugins
-- {{{ Dir = vim-speeddating-master
  { dir = "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/Local_Plugins/vim-speeddating-master", ft = {"markdown", "org"} }, --modified
-- }}}
-- {{{ Dir = lualine.nvim-master
  {
    dir = "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/Local_Plugins/lualine.nvim-master",
    event = "VeryLazy",
    config = function()
    require "lualine".setup {
        globalstatus = true,
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = '\\' },
            section_separators = { left = '', right = ''},
            disabled_filetypes = {'neotree'},
            always_divide_middle = true,
            globalstatus = false,
        },
        sections = {
            lualine_a = {{
                'windows',
                show_modified_status = true,
                mode = 0,
                max_length = vim.o.columns * 2 / 3,
                symbols = {
                    modified = ' [𝓐 ]',-- 🈚,[+],
                    alternate_file = ' o',
                    directory = ' z',
                },
                filetype_names = {
                    startify = 'Startify',
                    dashboard = 'Dashboard',
                },
            }},
            lualine_b = { 'branch', 'diff', {
                "diagnostics",
                    sources = { "nvim_diagnostic" },
                    sections = { "error", "warn", "hint", "info" },
                    symbols = {
                        error = ' ',
                        warn = ' ',
                        hint = ' ',
                        info = ' ',
                    },
                    colored = true,
                    update_in_insert = false,
                    always_visible = false,
                },
            },
            lualine_c = { '% [ %F -  %p%% ]' },
            lualine_x = { 'os.date("%H:%M %a")', 'filetype' },
            lualine_y = { '%c' },
            lualine_z = { '%l - %L' },
        },
    }
    --Match colorscheme
    if vim.g.colors_name == 'nightfox' then
        require'lualine'.setup {options = { theme = 'max_lualine_theme_nightfox' }}
    elseif vim.g.colors_name == 'nordfox' then
        require'lualine'.setup {options = { theme = 'max_lualine_theme_nordfox' }}
    elseif vim.g.colors_name == 'duskfox' then
        require'lualine'.setup {options = { theme = 'max_lualine_theme_duskfox' }}
    elseif vim.g.colors_name == 'terafox' then
        require'lualine'.setup {options = { theme = 'max_lualine_theme_terafox' }}
    elseif vim.g.colors_name == 'dayfox' then
        require'lualine'.setup {options = { theme = 'max_lualine_theme_dayfox' }}
    elseif vim.g.colors_name == 'tokyonight' then
        require'lualine'.setup {options = { theme = 'max_lualine_theme_dayfox' }}
    elseif vim.g.colors_name == 'catppuccin-frappe' then
        require'lualine'.setup {options = { theme = 'max_lualine_theme_frappe' }}
    elseif vim.g.colors_name == 'catppuccin-macchiato' then
        require'lualine'.setup {options = { theme = 'max_lualine_theme_macchiato' }}
    elseif vim.g.colors_name == 'catppuccin-mocha' then
        require'lualine'.setup {options = { theme = 'max_lualine_theme_mocha' }}
    elseif vim.g.colors_name == 'catppuccin-latte' then
        require'lualine'.setup {options = { theme = 'max_lualine_theme_latte' }}
    elseif vim.g.colors_name == 'github_dark' then
        require'lualine'.setup {options = { theme = 'max_lualine_theme_github_dark' }}
    elseif vim.g.colors_name == 'github_light' then
        require'lualine'.setup {options = { theme = 'max_lualine_theme_github_light' }}
    end
    end,
  }, --modified
-- }}}
-- {{{ Dir = weather3day.nvim-main
  {
    dir = "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/Local_Plugins/weather3day.nvim-main", --modified
    cmd = "Weather3day",
    init = function()
    vim.g.weather_city = "Xi'an"--weather3day plug
    end,
  },
-- }}}
-- Github plugins
-- {{{ nvimdev/dashboard-nvim
    {
        "nvimdev/dashboard-nvim",
        event = 'BufWinEnter',
        config = function()
            require('dashboard').setup {
                theme = 'doom',
                config = {
                    header ={
                        [[                                           ]],
                        [[                                           ]],
                        [[                                           ]],
                        [[                                           ]],
                        [[                                           ]],
                        [[                                           ]],
                        [[                                           ]],
                        [[                                           ]],
                        [[                                           ]],
                        [[   ▄████▄              ▒▒▒▒▒       ▒▒▒▒▒   ]],
                        [[  ███▄█▀              ▒ ▄▒ ▄▒     ▒ ▄▒ ▄▒  ]],
                        [[ ▐████     █  █  █   ▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒▒ ]],
                        [[  █████▄             ▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒▒ ]],
                        [[   ▀████▀            ▒ ▒ ▒ ▒ ▒   ▒ ▒ ▒ ▒ ▒ ]],
                        [[                                           ]],
                        [[                                           ]],
                        [[                                           ]],
                        [[                                           ]],
                    },
                    center = {
                        {
                            icon    = '  ',
                            icon_hl = 'Title',
                            desc    = 'New File',
                            desc_hl = 'String',
                            key     = 'i',
                            key_hl  = 'Number',
                            action  = 'enew',
                        },
                        {
                            icon    = '  ',
                            icon_hl = 'Title',
                            desc    = 'Find File',
                            desc_hl = 'String',
                            key     = 'f',
                            keymap  = 'SPC f f',
                            key_hl  = 'Number',
                            action  = 'Telescope file_browser path=:/<left><left>'
                        },
                        {
                            icon    = '  ',--
                            icon_hl = 'Title',
                            desc    = 'Recently Files',
                            desc_hl = 'String',
                            key     = 'r',
                            key_hl  = 'Number',
                            keymap  = ', r',
                            action = 'LeaderfMru',
                            --keymap  = 'SPC f r',  --Telescope
                            --action  = 'Telescope oldfiles',  --Telescope
                        },
                        {
                            icon    = '  ',
                            icon_hl = 'Title',
                            desc    = 'Last Session',
                            desc_hl = 'String',
                            key     = 's',
                            key_hl  = 'Number',
                            keymap  = 'SPC s l',
                            action = 'lua require("persistence").load({ last = true })',
                        },
                        {
                            icon    = '💤 ',-- 鈴
                            icon_hl = 'Title',
                            desc    = 'Manage Plugins',
                            desc_hl = 'String',
                            key     = 'l',
                            key_hl  = 'Number',
                            action  = 'Lazy',
                        },
                        {
                            icon    = '  ',
                            icon_hl = 'Title',
                            desc    = 'Dotfile',
                            desc_hl = 'String',
                            key     = 'd',
                            keymap  = 'SPC r c',
                            key_hl  = 'Number',
                            action  = 'edit $MYVIMRC | tcd %:p:h', --tabnew;edit
                        },
                        {
                            icon    = "  ",
                            icon_hl = 'Title',
                            desc    = "Exit",
                            desc_hl = 'String',
                            key     = "q",
                            key_hl  = 'Number',
                            action  = "qa",
                        },
                    },
                    footer = function()
                        return {
                            '',
                            '',
                            '',
                            '',
                            "🎉 NVIM(v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch .. ") " .. "loaded " .. require("lazy").stats().count .. " plugins  in " .. require"lazy".stats().startuptime .. " ms 🎉",
                        }
                    end
                },
                hide = {
                    statusline = true,
                    tabline = true,
                    winbar = true,
                },
                vim.api.nvim_command("hi DashboardHeader guifg='#925ba6'")
            }
        end,
    },
-- }}}
-- {{{ folke/persistence.nvim
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
        save_empty = false,
    },
    keys = {
      { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    },
  },
-- }}}
-- {{{ mbbill/undotree
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    init = function()
    if vim.fn.has('persistent_undo') then
      vim.cmd('set undofile')
      vim.cmd('set undodir=C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/cache/undodir')
    end
    vim.g.undotree_DiffAutoOpen = 1
    vim.g.undotree_HelpLine = 1
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_ShortIndicators = 1
    vim.g.undotree_TreeNodeShape = "├"
    vim.g.undotree_TreeVertShape = "│"
    vim.g.undotree_TreeSplitShape = "─┘"
    vim.g.undotree_TreeReturnShape = "─┐"
    neomap('n', '<leader>u', vim.cmd.UndotreeToggle, key_opts_ns)
    end,
    -- 增加系统环境变量Path"D:\Program Files\Git\usr\bin",解决打开插件报错的问题.
  },
-- }}}
-- {{{ dstein64/vim-startuptime
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
    vim.g.startuptime_tries = 10
    neomap("n", "<F12>", ":StartupTime<CR>", key_opts_ns)
    end,
  },
-- }}}
-- {{{ arecarn/vim-crunch
  {
    "arecarn/vim-crunch",
    keys = {
            { "<Plug>(crunch-operator-line)", mode = {"n"} },
            { "<Plug>(visual-crunch-operator)", mode = { "x" } },
           },
    init =function()
    neomap("n", "<leader>,", "<Plug>(crunch-operator-line)", key_opts_ns)
    neomap("x", "<leader>,", "<Plug>(visual-crunch-operator)<cr>", key_opts_ns)
    end,
  },
-- }}}
-- {{{ sustech-data/wildfire.nvim
  {
  	"sustech-data/wildfire.nvim",
    keys = { "<CR>" },
  	dependencies = { "nvim-treesitter/nvim-treesitter" },
  	config = function()
  		require("wildfire").setup({
  			surrounds = {
  				{ "(", ")" },
  				{ "{", "}" },
  				{ "<", ">" },
  				{ "[", "]" },
  			},
  			keymaps = {
                  init_selection = "<CR>",
                  node_incremental = "<CR>",
                  node_decremental = "<BS>",
  			},
  		})
  	end,
  },
-- }}}
-- {{{ AndrewRadev/linediff.vim
  { "AndrewRadev/linediff.vim", cmd = {"Linediff", "LinediffAdd"} },
-- }}}
-- {{{ alpertuna/vim-header
  {
    "alpertuna/vim-header",
    cmd = "AddHeader",
    config = function()
    vim.g.header_field_author           = 'Max'
    vim.g.header_field_author_email     = 'ismaxiaolong@gmail.com'
    vim.g.header_field_timestamp_format = '%Y.%m.%d'
    vim.g.header_field_modified_by      = 0
    vim.g.header_field_license_id       = ''
    end,
    init = function()
    neomap("n", "<F2>", ":AddHeader<CR>", key_opts_ns)
    end,
  },
-- }}}
-- {{{ iqxd/vim-mine-sweeping
  { "iqxd/vim-mine-sweeping", cmd = "MineSweep" },
-- }}}
-- {{{ Yggdroot/LeaderF
  {
    "Yggdroot/LeaderF",
    build = ":LeaderfInstallCExtension",
    event = 'BufWinEnter',
    cmd = { "LeaderfFile", "Leaderf", "LeaderfLine", "LeaderfMru" },
    config = function()
    vim.g.Lf_Ctags = "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/ctags.exe"
    vim.g.Lf_Rg = 'C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/rg.exe'
    vim.g.Lf_ShortcutF = ""
    vim.g.Lf_ShortcutB = ""
	vim.g.Lf_CursorBlink  = 0
    vim.g.Lf_ShowDevIcons = 1
    vim.g.Lf_DevIconsFont = "Delugia Mono"
    vim.g.Lf_ReverseOrder = 1
    vim.g.Lf_HideHelp = 1
    vim.g.Lf_UseCache = 1
    vim.g.Lf_UseMemoryCache = 1
    vim.g.Lf_UseVersionControlTool = 0
    vim.g.Lf_IgnoreCurrentBufferName = 1
    vim.cmd([[source C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/Local_Plugins/leaderf_popupColorscheme_nightfox.vim]])  -- PopupColorscheme
	vim.g.Lf_WorkingDirectoryMode = 'Ac'
	vim.g.Lf_DefaultMode = 'NameOnly'
    vim.g.Lf_PreviewCode = 1
    vim.g.Lf_PreviewInPopup = 1
    vim.g.Lf_StlSeparator = { left = "", right = "" }
    vim.g.Lf_JumpToExistingWindow = 0
    vim.g.Lf_PreviewResult = {
        File = 1,
        Buffer = 0,
        Mru = 0,
        Tag = 0,
        BufTag = 1,
        Function = 1,
        Line = 1,
        Colorscheme = 0,
        Rg = 1,
        Gtags = 0,
    }-- 0:不自动预览; 1:自动预览
    vim.g.Lf_NeedCacheTime = 0.1  -- cache the files list,if time > 0.1s.
    vim.g.Lf_CacheDirectory = "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/cache/leaderf_mru_cache"
    vim.g.Lf_MruMaxFiles = 2048
    vim.g.Lf_MruEnableFrecency = 0
    vim.g.Lf_ShowRelativePath = 0
    vim.g.Lf_WildIgnore = {
      dir = { ".svn", ".git", ".hg" },
      file = { "*.sw?", "~$*", "*.bak", "*.exe", "*.o", "*.so", "*.py[co]" },
    }
    -- 使用:LeaderfRg 路径不全时, 默认搜索该文件目录下的文件
    vim.cmd([[command! -bar -nargs=? -complete=dir LeaderfRg Leaderf! rg "" <q-args>]])

    -- Bottom mode & Change statusline color (not popup mode)
    vim.g.Lf_WindowPosition = 'bottom'
    vim.api.nvim_command("hi link Lf_hl_stlName StatuslineNC")
    vim.api.nvim_command("hi link Lf_hl_stlMode StatuslineNC")
    vim.api.nvim_command("hi link Lf_hl_stlSeparator0 StatuslineNC")
    vim.api.nvim_command("hi link Lf_hl_stlSeparator1 StatuslineNC")
    vim.api.nvim_command("hi link Lf_hl_stlSeparator2 StatuslineNC")
    vim.api.nvim_command("hi link Lf_hl_stlSeparator3 StatuslineNC")
    vim.api.nvim_command("hi link Lf_hl_stlSeparator4 StatuslineNC")
    vim.api.nvim_command("hi link Lf_hl_stlSeparator5 StatuslineNC")
    vim.api.nvim_command("hi link Lf_hl_stlLineInfo Statusline")
    vim.api.nvim_command("hi link Lf_hl_stlRegexMode StatuslineNC")
    vim.api.nvim_command("hi link Lf_hl_stlFullPathMode StatuslineNC")
    vim.api.nvim_command("hi link Lf_hl_stlFuzzyMode StatuslineNC")
    vim.api.nvim_command("hi link Lf_hl_stlBlank Statusline")
    vim.api.nvim_command("hi link Lf_hl_stlTotal Statusline")
    if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
        vim.api.nvim_set_hl(0, "Lf_hl_stlCategory", { bg="#303446", fg="#429940", bold=true, italic=true } ) --2 domain
        vim.api.nvim_set_hl(0, "Lf_hl_stlNameOnlyMode", { bg="#303446",fg="#737994" } )                      --3 domain
        vim.api.nvim_set_hl(0, "Lf_hl_stlCwd", { fg="#b09a6f" } )                                            --4 domain
    elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
        vim.api.nvim_set_hl(0, "Lf_hl_stlCategory", { bg="#e1e2e7",fg="#8839ef", bold=true, italic=true } )  --2 domain
        vim.api.nvim_set_hl(0, "Lf_hl_stlNameOnlyMode", { bg="#e1e2e7",fg="#838ba7" } )                      --3 domain
        vim.api.nvim_set_hl(0, "Lf_hl_stlCwd", { bg="#e1e2e7", fg="#de6d78" } )                              --4 domain
    end

    -- Popup mode
    --[[ vim.g.Lf_WindowPosition       = 'popup'
    vim.g.Lf_WindowHeight         = 0.4
    vim.g.Lf_PopupHeight          = 0.4
    vim.g.Lf_PopupWidth           = 0.8
    vim.g.Lf_PopupPosition        = { 1, 0 }
    vim.g.Lf_PopupPreviewPosition = 'bottom'
    vim.g.Lf_PreviewPosition      = 'center'
	vim.g.Lf_PopupShowStatusline  = 0
	vim.g.Lf_PopupShowBorder      = 1
	vim.g.Lf_PopupBorders         = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' } ]]
    end,

    init = function()
    neomap("n", "<localleader>fb", ":LeaderfFile :/<left><left>", key_opts_n)
    neomap("n", "<localleader>fp", ":Leaderf rg<CR>", key_opts_ns)
    neomap("n", "<localleader>fl", ":LeaderfLine<CR>", key_opts_ns)
    neomap("n", "<localleader>t", ":Leaderf bufTag<CR>", key_opts_ns)
    neomap("n", "<localleader>ff", ":Leaderf function<CR>", key_opts_ns)
    neomap("n", "<localleader>fc", ":Leaderf colorscheme<CR>", key_opts_ns)
    neomap("n", "<localleader>r", ":LeaderfMru<CR>", key_opts_ns)
    end,
  },
-- }}}
-- {{{ voldikss/vim-floaterm
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermNew", "FloatermSend" },
    config = function()
        if vim.o.background == 'dark' then
            vim.api.nvim_command("hi FloatermBorder guibg=#303446 guifg=#868c9a")
        elseif vim.o.background == 'light' then
            vim.api.nvim_command("hi FloatermBorder guibg=#e1e2e7 guifg=#5c6370")
        end
    end,
    init = function()
            vim.g.floaterm_wintype = 'float'
            vim.g.floaterm_title = '─────  Terminal [$1|$2] '
            vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
            vim.g.floaterm_autoclose = 0
            vim.g.floaterm_keymap_kill = '<C-q>'
            vim.g.floaterm_keymap_next = '<leader>tn'
            neomap("n","<leader>to",":FloatermNew<CR>")
            neomap("n","<leader>tt",":FloatermToggle<CR>")
            neomap("n","<leader>tr",":FloatermNew<CR>rg.exe<Space>")
            neomap('n', '<M-o>', ':FloatermNew SumatraPdf <C-r><C-l><CR>', {})
            vim.cmd[[
            augroup Compiler_code
                au!
                au FileType floaterm nnoremap <buffer> <Esc> :q<CR>
                " -- Python --
                au FileType python nnoremap <C-CR> :FloatermNew py "%:p"<CR>
                au FileType python nnoremap <C-g> :FloatermNew py "%:p"<CR>
                au FileType python noremap! <C-CR>  <Esc>:FloatermToggle<CR>
                au FileType python noremap! <C-g>  <Esc>:FloatermToggle<CR>
                " au FileType python tnoremap <C-CR>  <C-\><C-n>:FloatermToggle<CR>
                " -- Python REPL --
                nnoremap <leader>tp :FloatermNew --width=0.5 --wintype=vsplit --name=repl --position=rightbelow ipython<CR>
                au FileType python nnoremap <leader>w :FloatermSend<CR>
                au FileType python vnoremap <leader>w :FloatermSend<CR>
                " -- Matlab --
                au FileType matlab nnoremap <silent><C-CR> :! matlab -nosplash -nodesktop -r %:r<CR><CR>
                au FileType matlab nnoremap <silent><C-g> :! matlab -nosplash -nodesktop -r %:r<CR><CR>
                " TERMINAL运行matlab代码,以'test.m'代码为例 'matlab -nosplash -nodesktop -r test'
                " -- Fortran --
                au FileType fortran nnoremap <C-CR> :FloatermNew<CR>compilervars.bat intel64<CR>ifort<Space>
                au FileType fortran nnoremap <C-g> :FloatermNew<CR>compilervars.bat intel64<CR>ifort<Space>
                " -- Typst --
                " highligth file 'D:\Program Files\Neovim\share\nvim\runtime\syntax\typst.vim'
                au BufRead,BufNewFile *.typ setlocal filetype=typst
                au FileType typst nnoremap <C-CR> :FloatermNew --height=1.0 typst watch %:p<CR>
                au FileType typst nnoremap <C-g> :FloatermNew --height=1.0 typst watch %:p<CR>
                au FileType typst command! TypstPDF execute "FloatermNew! sumatrapdf %:p<C-h><C-h><C-h>pdf<CR>"
            augroup END
            " Git
            command! Push execute "FloatermNew!git add init.lua<CR>git commit --allow-empty-message -m \"\"<CR>git push<CR>"
            command! Pull execute "FloatermNew!git fetch --all<CR>git reset --hard origin/main<CR>"
            command! Gitlog execute "FloatermNew!git log --all --oneline --graph<CR>"
            " Administrator CMD mode
            nnoremap  <leader>ta  :FloatermNew<CR>runas /user:ThinkPad\Administrator cmd<CR>1234<CR>
            " nnoremap  <leader>ta  :FloatermNew<CR>runas /user:administrator cmd<CR>1234<CR>
            " 'runas /user:administrator cmd' 进入管理员CMD的前提是开启管理员账号
            " 开启管理员账号: net user administrator /active:yes
            " 关闭管理员账号: net user administrator /active:no
            " 设置管理员密码(1234): net user administrator 1234
            ]]
    end,
  },
-- }}}
-- {{{ kdheepak/lazygit.nvim
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
	keys = {
		{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
	},
    init = function()
    vim.g.lazygit_floating_window_winblend = 0
    vim.g.lazygit_floating_window_scaling_factor = 0.9
    vim.g.lazygit_floating_window_corner_chars = { "╭", "╮", "╰", "╯" }
    vim.g.lazygit_floating_window_use_plenary = 0
    vim.g.lazygit_use_neovim_remote = 0
    end,
  },
-- }}}
-- {{{ iamcco/markdown-preview.nvim
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_refresh_slow = 0
    vim.g.mkdp_command_for_global = 0
    vim.g.mkdp_open_to_the_world = 0
    vim.g.mkdp_open_ip = ""
    vim.g.mkdp_echo_preview_url = 0
    vim.g.mkdp_browserfunc = ""
    vim.g.mkdp_preview_options = {
      mkit = {},
      katex = {},
      uml = {},
      maid = {},
      disable_sync_scroll = 0,
      sync_scroll_type = "middle",
      hide_yaml_meta = 1,
      sequence_diagrams = {},
      flowchart_diagrams = {},
      content_editable = "v:false",
      disable_filename = 0,
    }
    --设置预览代码高亮(绝对路径)
    vim.g.mkdp_markdown_css = "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/github-markdown.css"
    vim.g.mkdp_highlight_css = "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/markdown.css"
    --vim.g.mkdp_highlight_css = "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/markdown_highlight_solarized_dark.css"
    vim.g.mkdp_port = ""
    vim.g.mkdp_page_title = "「${name}」"
    vim.cmd[[
    augroup markdown_preview
        au!
        au FileType markdown nnoremap <C-CR> <Plug>MarkdownPreview
        au FileType markdown nnoremap <C-g> <Plug>MarkdownPreview
    augroup END
    ]]
    end,
  },
-- }}}
-- {{{ plasticboy/vim-markdown
  {
    "plasticboy/vim-markdown",
    ft = "markdown",
    config = function()
    vim.g.vim_markdown_toc_autofit = 1                 -- Enable TOC window auto-fit,调节合适的窗口尺寸

    vim.g.vim_markdown_conceal = 0                     -- 取消隐藏 Markdown          语法符号
    vim.g.vim_markdown_conceal_code_blocks = 0         -- 取消隐藏 代码块            符号 ```
    vim.g.tex_conceal = ""                             -- 取消隐藏 LaTeX math syntax 符号

    vim.g.vim_markdown_math = 1                        -- 高亮显示 LaTeX math
    vim.g.vim_markdown_strikethrough = 1               -- 划线文本显示,由 ~~xx~~ 变为 划线~~xx~~划线

    vim.g.vim_markdown_new_list_item_indent = 2        -- *item1 *item2 缩进距离为2(默认是4).
    vim.g.vim_markdown_auto_insert_bullets = 0

    vim.g.vim_markdown_folding_disabled = 1            -- 取消 markdown 折叠
    --let g.vim_markdown_no_default_key_mappings = 1    -- 取消默认按键映射
    vim.g.vim_markdown_fenced_languages = {
        "c++=cpp",
        "viml=vim",
        "bash=sh",
        "ini=dosini",
        "js=javascript",
        "json=javascript",
        "jsx=javascriptreact",
        "tsx=typescriptreact",
        "docker=Dockerfile",
        "makefile=make",
        "py=python",
    }
    vim.g.vim_markdown_follow_anchor = 1
    vim.g.vim_markdown_edit_url_in = 'vsplit'       -- tab  vsplit  hsplit  current
    vim.g.vim_markdown_folding_disabled = 0         -- 开启折叠功能
    vim.g.vim_markdown_folding_style_pythonic = 1   -- 折叠样式
    vim.g.vim_markdown_folding_level = 1            -- n级不自动折叠
    end,
  },
-- }}}
-- {{{ dhruvasagar/vim-table-mode
  { "dhruvasagar/vim-table-mode", ft = {"markdown", "org"} },
-- }}}
-- {{{ lervag/vimtex
  { "lervag/vimtex",
    ft = {"tex", "latex", "bib"},
    config = function()
    vim.g.tex_flavor = "latex"
    vim.g.vimtex_quickfix_mode = 1
    vim.g.vimtex_compiler_progname = "nvr"
    vim.g.vimtex_view_reverse_search_edit_cmd = "nvr --remote-silent %f -c %l"
    vim.g.vimtex_compiler_latexmk = {
      continuous = 0,
    }
    vim.g.vimtex_compiler_latexmk_engines = { _ = "-xelatex" } --{["_"] = "-lualatex"}
    vim.g.vimtex_view_automatic = 1
    vim.g.vimtex_indent_on_ampersands = 0
    vim.g.vimtex_view_general_viewer = "SumatraPDF"
    vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
    vim.g.vimtex_fold_enabled = true
    -- Using Treesitter requires these settings
    vim.g.vimtex_syntax_enabled = 0
    vim.g.vimtex_syntax_conceal_disable = 1
    -- neovim ---(highlight)---> pdf by 'lv'
    function open_sumatra_pdf()
        local pdf_file = vim.fn.expand('%:r') .. '.pdf'
        if vim.fn.filereadable(pdf_file) == 0 then
          pdf_file = ""
        end
        local cmd = 'cmd /c start /b "" SumatraPDF -reuse-instance ' .. pdf_file
        os.execute(cmd)
    end
    vim.api.nvim_create_autocmd({"BufReadPost"}, {
      pattern = {"*.tex", "*.latex"},
      callback = open_sumatra_pdf,
    })
    -- Disable conceal
    vim.g.vimtex_syntax_conceal = {
        accents = 0,
        cites = 0,
        fancy = 0,
        greek = 0,
        math_bounds = 0,
        math_delimiters = 0,
        math_fracs = 0,
        math_super_sub = 0,
        math_symbols = 0,
        sections = 0,
        styles = 0,
    },
    neomap("n", "<localleader>li", "<plug>(vimtex-info)", key_opts_ns)
    neomap("n", "<localleader>lt", "<plug>(vimtex-toc-open)", key_opts_ns)
    neomap("n", "<localleader>lT", "<plug>(vimtex-toc-toggle)", key_opts_ns)
    neomap("n", "<localleader>lv", "<plug>(vimtex-view)", key_opts_ns)
    neomap("n", "<localleader>ll", "<plug>(vimtex-compile)", key_opts_ns)
    neomap("n", "<localleader>lo", "<plug>(vimtex-compile-output)", key_opts_ns)
    neomap("n", "<localleader>lg", "<plug>(vimtex-status)", key_opts_ns)
    neomap("n", "<localleader>lG", "<plug>(vimtex-status-all)", key_opts_ns)
    neomap("n", "<localleader>lc", "<plug>(vimtex-clean)", key_opts_ns)
    neomap("n", "<localleader>lC", "<plug>(vimtex-clean-full)", key_opts_ns)
    end,
  },
-- }}}
-- {{{ mhinz/vim-startify
  {
    "mhinz/vim-startify",
    cmd = "Startify",
    config = function()
    vim.g.startify_files_number = 16  -- 起始页显示的列表长度
    vim.api.nvim_command("hi StartifyBracket ctermfg=10 guifg=#444B6A")
    vim.api.nvim_command("hi StartifyNumber ctermfg=10 guifg=#FF9E64")
    vim.api.nvim_command("hi StartifyPath ctermfg=10 guifg=#786591")
    vim.api.nvim_command("hi StartifySlash ctermfg=10 guifg=#786591")
    vim.api.nvim_command("hi StartifySection ctermfg=10 guifg=#7AA2F7")
    vim.api.nvim_command("hi StartifyHeader ctermfg=10 guifg=#8687b0")
    vim.api.nvim_command("hi StartifyFooter ctermfg=10 guifg=#F7768E")
    vim.api.nvim_command("hi StartifySpecial ctermfg=10 guifg=#444B6A")
    vim.g.ascii_neovim = {
      '                                                                   ',
      '                                                                   ',
      '                                                                   ',
      '                                                                   ',
      '                                                                   ',
      '                                                                   ',
      '            ,                                                      ',
      '           / ,,_  ."|                                              ',
      '         [[| /]]]]/_."                                             ',
      '       ]]]]` "[["  ".                                              ',
      '     [[[[[    _   ;,                                               ',
      '  ,]]]]]]    /o`  ` ;)                                             ',
      ' [[[[[[   /           (                                            ',
      ' ]]]]]]   |                      ___________________________       ',
      '[[[[[[[[                        /                           |      ',
      ']]]]]]]]]   ".__      _  |     /                            |      ',
      '[[[[[[[[       /`._  (_ /     |     Still waters run deep!  |      ',
      ' ]]]]]]"      |    //___/   --=:                            |      ',
      ' `[[[[`       |     `--`       |                            |      ',
      '  ]]]`                          ____________________________/      ',
    }
    vim.g.startify_custom_footer = 'startify#pad(g:ascii_neovim)'

    -- show startify icon
    function _G.webDevIcons(path)
      local filename = vim.fn.fnamemodify(path, ':t')
      local extension = vim.fn.fnamemodify(path, ':e')
      return require'nvim-web-devicons'.get_icon(filename, extension, { default = true })
    end

    vim.cmd[[
    function! StartifyEntryFormat() abort
      return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
    endfunction
    ]]

    -- dark & light colorscheme
    if vim.o.background == 'dark' then
        vim.api.nvim_command("hi StartifyFile ctermfg=10 guifg=#9ECE6A")
    elseif vim.o.background == 'light' then
        vim.api.nvim_command("hi StartifyFile ctermfg=10 guifg=#12970e")
    end
    end,
  },
-- }}}
-- {{{ wellle/targets.vim
  { "wellle/targets.vim", keys = { "c", "d", "y", "v"} },
-- }}}
-- {{{ chrisbra/csv.vim
  { "chrisbra/csv.vim", ft = "csv" },
-- }}}
-- {{{ ntpeters/vim-better-whitespace
  {
    "ntpeters/vim-better-whitespace",
    event = "InsertEnter",
    config = function()
    vim.g.better_whitespace_guicolor='red'
    vim.g.strip_whitespace_on_save=0
    vim.g.better_whitespace_filetypes_blacklist = {
                'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown',
                'startify', 'dashboard'
    }
    neomap("n", "<leader>si", ":StripWhitespace<CR>", key_opts_ns)
    end,
  },
-- }}}
-- {{{ lfv89/vim-interestingwords
  {
    "lfv89/vim-interestingwords",
    keys = {
            { "<leader>k", mode = { "n" } },
            { "<leader>k", mode = { "v" } },
           },
    config = function()
    neomap("n", "<leader>k", ":call InterestingWords('n')<cr>", key_opts_ns)
    neomap("v", "<leader>k", ":call InterestingWords('v')<cr>", key_opts_ns)
    neomap("n", "<leader>K", ":call UncolorAllWords()<cr>", key_opts_ns)
    vim.g.interestingWordsGUIColors = {
                '#72b5e4', '#f0c53f', '#ff8784', '#c5c7f1',
                '#c2d735', '#78d3cc', '#ea8336', '#e43542',
                '#ebab35', '#ebe735', '#aadd32', '#dcca6b',
                '#219286', '#2f569c', '#ffb577', '#5282a4',
                '#edfccf', '#67064c', '#f5bca7', '#95c474',
                '#dece83', '#de9783', '#f2e700', '#e9e9e9',
                '#69636d', '#626b98', '#f5f5a7', '#dcca6b',
                '#b72a83', '#6f2b9d', '#69636d', '#5f569c',
    }
    end,
  },
-- }}}
-- {{{ markonm/traces.vim
  {
    "markonm/traces.vim",
    event = {"CursorMoved", "CmdlineEnter"},
    config = function()
    vim.g.traces_normal_preview = 1
    vim.g.traces_num_range_preview = 1
    end,
  },
-- }}}
-- {{{ triglav/vim-visual-increment
  {
    "triglav/vim-visual-increment",
    event = "InsertEnter",
    config = function()
    vim.cmd[[set nrformats=alpha,octal,hex]]
    end,
  },
-- }}}
-- {{{ itchyny/vim-cursorword
  { "itchyny/vim-cursorword", event = "BufReadPre" },
-- }}}
-- {{{ bronson/vim-visual-star-search
  { "bronson/vim-visual-star-search", event = "BufReadPre" },
-- }}}
-- {{{ alvarosevilla95/luatab.nvim
  {
    "alvarosevilla95/luatab.nvim",
    event = "BufReadPre",
    config = function()
    require('luatab').setup{
    	separator = function()
    		return ""
    	end,
        windowCount = function(index) -- 显示buffer数字
            return index .. ' '
        end,
        --windowCount = function() -- 不显示buffer数字
        --  return ""
        --end,
        modified = function(bufnr)
            return vim.fn.getbufvar(bufnr, '&modified') == 1 and ' ' or ''  -- '[+] ', '● ', '🈚 '
        end,
        title = function(bufnr)
            local file = vim.fn.bufname(bufnr)
            local buftype = vim.fn.getbufvar(bufnr, '&buftype')
            local filetype = vim.fn.getbufvar(bufnr, '&filetype')

            if buftype == 'help' then
                return 'help:' .. vim.fn.fnamemodify(file, ':t:r')
            elseif buftype == 'quickfix' then
                return 'quickfix'
            elseif filetype == 'TelescopePrompt' then
                return 'Telescope'
            elseif buftype == 'terminal' then
                local _, mtch = string.match(file, "term:(.*):(%a+)")
                return mtch ~= nil and mtch or vim.fn.fnamemodify(vim.env.SHELL, ':t')
            elseif file == '' then
                return '[No Name]'
            else
                return vim.fn.fnamemodify(file, ':p:h:t') .. '/' .. vim.fn.fnamemodify(file, ':t')
            end
        end
    }
    end,
  },
-- }}}
-- {{{ shellRaining/hlchunk.nvim
  {
    "shellRaining/hlchunk.nvim",
    event = "BufRead",
    config = function()
    require('hlchunk').setup({
        chunk = {
            enable = true,
            use_treesitter = true,
            notify = true, -- notify if some situation(like disable chunk mod double time)
            exclude_filetypes = {
                aerial = true,
                dashboard = true,
            },
            support_filetypes = {
                "*.lua",
                "*.js",
                "*.m",
                "*.py",
            },
            chars = {
                horizontal_line = "─",
                vertical_line = "│",
                left_top = "╭",
                left_bottom = "╰",
                right_arrow = ">",
            },
            style = {
                { fg = "#806d9c" },
            },
        },

        indent = {
            enable = true,
            use_treesitter = false,
			chars = { "│", "¦", "┆", "┊", },
            style = {
                { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui") }
            },
        },

        line_num = {
            enable = true,
            use_treesitter = false,
            style = "#806d9c",
        },

        blank = {
            enable = false,
            chars = {
                "․",
            },
            style = {
                vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
            },
        },
    })
    end,
  },
-- }}}
-- {{{ chentoast/marks.nvim
  {
    "chentoast/marks.nvim",
	keys = {
		{ "mm", mode = { "n" }, "<Plug>(Marks-setnext)", desc = "Set nextMark" },
		{ "mc", mode = { "n" }, "<Plug>(Marks-deletebuf)", desc = "Clear Marks" },
	},
    config = function()
    require'marks'.setup {
        default_mappings = false,
        builtin_marks = { ".", "<", ">", "^" },
        cyclic = true,
        force_write_shada = false,
        refresh_interval = 250,
        sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
        excluded_filetypes = {},
        bookmark_0 = {
            sign = "⚑",
            virt_text = "hello world"
        },
    }
    neomap("n", "<C-m>", "<Plug>(Marks-next)", key_opts_ns)
    neomap("n", "<S-m>", "<Plug>(Marks-prev)", key_opts_ns)
    end,
  },
-- }}}
-- {{{ windwp/nvim-autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
    require("nvim-autopairs").setup {}
        local disable_filetype = { "TelescopePrompt" }
        local disable_in_macro = false  -- disable when recording or executing a macro
        local disable_in_visualblock = false -- disable when insert after visual block mode
        local ignored_next_char = [=[[%w%%%'%[%"%.]]=]
        local enable_moveright = true
        local enable_afterquote = true  -- add bracket pairs after quote
        local enable_check_bracket_line = true  --- check bracket in same line
        local enable_bracket_in_quote = true --
        local break_undo = true -- switch for basic rule break undo sequence
        local check_ts = false
        local map_cr = true
        local map_bs = true  -- map the <BS> key
        local map_c_h = false  -- Map the <C-h> key to delete a pair
        local map_c_w = false -- map <c-w> to delete a pair if possible
    end,
  },
-- }}}
-- {{{ karb94/neoscroll.nvim
  {
    "karb94/neoscroll.nvim",
    event = "BufReadPre",
    config = function()
    require('neoscroll').setup({
        mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
                    '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
        performance_mode = false,    -- Disable "Performance Mode" on all buffers.
    })
    local t = {}
    t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '45'}}
    t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '45'}}
    t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '90'}}
    t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '90'}}
    t['<C-y>'] = {'scroll', {'-0.10', 'false', '20'}}
    t['<C-e>'] = {'scroll', { '0.10', 'false', '20'}}
    t['zt']    = {'zt', {'90'}}
    t['zz']    = {'zz', {'90'}}
    t['zb']    = {'zb', {'90'}}
    require('neoscroll.config').set_mappings(t)
    end,
  },
-- }}}
-- {{{ petertriho/nvim-scrollbar
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPre",
  	dependencies = {
        {
          "kevinhwang91/nvim-hlslens",
          event = "InsertEnter",
          config = function()
          require('hlslens').setup({
              override_lens = function(render, posList, nearest, idx, relIdx)
                  local sfw = vim.v.searchforward == 1
                  local indicator, text, chunks
                  local absRelIdx = math.abs(relIdx)
                  if absRelIdx > 1 then
                      indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '▲' or '▼')
                  elseif absRelIdx == 1 then
                      indicator = sfw ~= (relIdx == 1) and '▲' or '▼'
                  else
                      indicator = ''
                  end

                  local lnum, col = unpack(posList[idx])
                  if nearest then
                      local cnt = #posList
                      if indicator ~= '' then
                          text = ('[%s %d/%d]'):format(indicator, idx, cnt)
                      else
                          text = ('[%d/%d]'):format(idx, cnt)
                      end
                      chunks = {{' ', 'Ignore'}, {text, 'HlSearchLensNear'}}
                  else
                      text = ('[%s %d]'):format(indicator, idx)
                      chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
                  end
                  render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
              end,
              build_position_cb = function(plist, _, _, _)
                  require("scrollbar.handlers.search").handler.show(plist.start_pos)
              end
          })
          --mapping
          vim.cmd[[nnoremap <leader>/ /\<<C-R>=expand("<cword>")<CR>\><left><left>]]
          --color
          vim.api.nvim_command("hi default link HlSearchNear IncSearch")
          vim.api.nvim_command("hi default link HlSearchLens WildMenu")
          vim.api.nvim_command("hi default link HlSearchLensNear IncSearch")
          vim.api.nvim_command("hi default link HlSearchFloat IncSearch")
          if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
              vim.api.nvim_command("hi IncSearch guibg=#d73a4a")
          elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
              vim.api.nvim_command("hi IncSearch guibg=#e78284")
          end
          vim.api.nvim_command("hi IncSearch guifg=black")
          end,
        },
    },
    config = function()
            if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
                require("scrollbar").setup({
                    handle = {
                        text = " ",
                        color = "#abb2bf",
                        cterm = nil,
                        highlight = "CursorColumn",
                        hide_if_all_visible = true, -- Hides handle if all lines are visible
                    },
                    marks = {
                        Cursor = {
                            text = "•",
                            color = 'black',
                        },
                        Search = {
                            text = { "-", "=" },
                            priority = 0,
                            color = "#e1e2e7",
                            cterm = nil,
                            highlight = "Search",
                        },
                    },
                })
            elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
                require("scrollbar").setup({
                    handle = {
                        text = " ",
                        color = "#4d688e",
                        cterm = nil,
                        highlight = "CursorColumn",
                        hide_if_all_visible = true, -- Hides handle if all lines are visible
                    },
                    marks = {
                        Cursor = {
                            text = "•",
                            color = "black",
                        },
                        Search = {
                            text = { "-", "=" },
                            priority = 0,
                            color = "black",
                            cterm = nil,
                            highlight = "Search",
                        },
                    },
                })
            end
    require("scrollbar.handlers.search").setup({})
    end,
  },
-- }}}
-- {{{ b3nj5m1n/kommentary
  {
    "b3nj5m1n/kommentary",
    keys = {
            { "<leader>cc", mode = { "n", "v" } },
            { "<leader>ci", mode = { "n", "v" } },
        },
    config = function()
    require("kommentary")
    vim.g.kommentary_create_default_mappings = false
    neomap("n", "<leader>cc", "<Plug>kommentary_line_increase", {})
    neomap("x", "<leader>cc", "<Plug>kommentary_visual_increase", {})
    neomap("n", "<leader>ci", "<Plug>kommentary_line_decrease", {})
    neomap("x", "<leader>ci", "<Plug>kommentary_visual_decrease", {})
    end,
  },
-- }}}
-- {{{ nvim-neo-tree/neo-tree.nvim
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    cmd = { "Neotree" },
	keys = {
		{
			'<Leader>e',
			'<cmd>Neotree filesystem left toggle dir=./<CR>',
			desc = 'Explorer NeoTree Toggle',
		},
		{
			'<F7>',
			'<cmd>Neotree filesystem left toggle dir=c:/Users/ThinkPad/Desktop/<CR>',
			desc = 'Desktop',
		},
	},
  	dependencies = {
        {
            "nvim-lua/plenary.nvim",
            lazy = true,
        },
        {
            "MunifTanjim/nui.nvim",
            lazy = true,
        },
        {
            "kyazdani42/nvim-web-devicons",
            branch = "master",
            commit = "9697285",
            event = "VeryLazy",
        },
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    neomap("n", "<leader>.", ":Neotree dir=:/<left><left>", {})
    end,
    config = function()
    require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style = "rounded",
        window = {
            auto_expand_width = true,
        },
        filesystem = {
            follow_current_file = true,
            use_libuv_file_watcher = true,
            hijack_netrw_behavior = "open_current",
        },
        default_component_configs = {
            container = {
              enable_character_fade = true,
            },
            indent = {
              indent_size = 2,
              padding = 1, -- extra padding on left hand side
              with_markers = true,
              indent_marker = "│",
              last_indent_marker = "└", -- └
              highlight = "NeoTreeIndentMarker",
              with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
              expander_highlight = "NeoTreeExpander",
            },
            icon = {
              folder_closed = "",
              folder_open = "",
              folder_empty = "",
              default = " ",
              highlight = "NeoTreeFileIcon",
            },
            modified = {
              symbol = "[+]",
              highlight = "NeoTreeModified",
            },
            name = {
              trailing_slash = false,
              use_git_status_colors = true,
              highlight = "NeoTreeFileName",
            },
            git_status = {
              symbols = {
                untracked = "",
                ignored = "",
                unstaged = "U",
                staged = "",
                conflict = "",
              },
            },
        },
    })
    -- change neo-tree background color (transparency)
    vim.api.nvim_command("hi NeoTreeNormal guibg=none ctermbg=none guifg=none")
    vim.api.nvim_command("hi NeoTreeStatusLine guibg=none ctermbg=none guifg=none")
    vim.api.nvim_command("hi NeoTreeStatusLineNC guibg=none ctermbg=none guifg=none")
    vim.api.nvim_command("hi NeoTreeNormalNC guibg=none ctermbg=none guifg=none")
    vim.api.nvim_command("hi NeoTreeVertSplit guibg=none ctermbg=none guifg=none")
    -- change color for NeoTreeIndent to light blue
    vim.api.nvim_command("hi NeoTreeIndentMarker guifg=#3FC5FF")
    end,
  },
-- }}}
-- {{{ ellisonleao/weather.nvim
  {
    "ellisonleao/weather.nvim",
    cmd = "Weather",
    config = function()
    require("weather").setup({
        city = "Xi'an",
        win_height = 10,
        win_width = 50,
    })
    end,
    init = function()
    neomap("n", "<localleader>we", ":Weather<CR>", key_opts_ns)
    neomap("n", "<localleader>wd", ":Weather3day<CR>", key_opts_ns)
    end,
  },
-- }}}
-- {{{ Vonr/align.nvim
  {
    "Vonr/align.nvim",
    keys = { "<leader>a", mode = { "x" } },
    init = function()
    --neomap('x','<leader>aa',function()require'align'.align_to_char(1,true)end,key_opts_ns)--Alignsto1character,lookingleft
    --neomap('x','<leader>as',function()require'align'.align_to_char(2,true,true)end,key_opts_ns)--Alignsto2characters,lookingleftandwithpreviews
    neomap('x','<leader>a',function()require'align'.align_to_string(false,true,true)end,key_opts_ns)--Alignstoastring,lookingleftandwithpreviews
    --neomap('x','<leader>ar',function()require'align'.align_to_string(true,true,true)end,key_opts_ns)--AlignstoaLuapattern,lookingleftandwithpreviews
     end,
  },
-- }}}
-- {{{ kylechui/nvim-surround
  { "kylechui/nvim-surround",
    keys = {
            { mode = "n", "ys" },
            { mode = "n", "cs" },
            { mode = "n", "ds" },
            { mode = "x", "<C- >" },
        },
    config = function()
    require("nvim-surround").setup({
        keymaps = {
            normal = "ys",
            change = "cs",
            delete = "ds",
            visual = "<C- >",
        },--S, dss, css
    })
    end,
  },
-- }}}
-- {{{ folke/flash.nvim
  {
    "folke/flash.nvim",
    keys = {
           { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
           { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
           { "f", mode = { "n" } },
           { "F", mode = { "n" } },
           { "t", mode = { "n" } },
           { "T", mode = { "n" } },
           -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
           -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
           -- { "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
	opts = {
        jump = {
            -- automatically jump when there is only one match
            autojump = false,
        },
		label = {
            after = { 0, 0 },
			rainbow = {
                enabled = true,
                shade = 3,
            },
		},
		modes = {
            -- `f`, `F`, `t`, `T`, `;` and `,` motions
            char = {
                enabled = true,
                jump_labels = true,
                autohide = true,
                char_actions = function()
                  return {
                    [";"] = "right", -- set to `right` to always go right
                    [","] = "left", -- set to `left` to always go left
                  }
                end,
            },
            -- a regular search with `/` or `?`
			search = {
				enabled = false,
			},
		},
	},
  },
-- }}}
-- {{{ EdenEast/nightfox.nvim
  {
    "EdenEast/nightfox.nvim",
    event = "BufReadPre",
    config = function()
    require('nightfox').setup({
      options = {
        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled", -- Compiled file suffix
        transparent = false,    -- Disable setting background
        terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
        dim_inactive = false,   -- Non focused panes set to alternative background
        styles = {              -- Style to be applied to different syntax groups
          comments = "NONE",    -- Value is any valid attr-list value `:help attr-list`
          conditionals = "italic",
          constants = "NONE",
          operators = "NONE",
          strings = "NONE",
          types = "italic,bold",
          variables = "NONE",
          functions = "italic",
          keywords = "bold",
          numbers = "italic",
        },
        inverse = {
          match_paren = true,
          visual = false,       -- default is true
          search = false,
        },
        modules = {
          neotree = true,
          cmp = true,
          telescope = true,
          treesitter = true,
          whichkey = true,
          tsrainbow2 = true,
          indent_blanklines = true,
          dashboard = true,
        },
        },
      groups = {
        all = {
          NormalFloat = { bg = "bg1" },
          NormalNC = { bg = "NONE" },
        },
      },
    })
    end,
    opts = function()
    local palettes = {
      nightfox  = {
        white   = "#abb2bf",
        fg1     = "#b2b2b2",
        comment = "#5c6370",
        sel0    = "#364a82", --visual
      },
      duskfox   = {
        white   = "#abb2bf",
        fg1     = "#b2b2b2",
        comment = "#5c6370",
        sel0    = "#364a82", --visual
      },
      terafox   = {
        white   = "#abb2bf",
        fg1     = "#b2b2b2",
        comment = "#5c6370",
        sel0    = "#364a82", --visual
      },
      nordfox   = {
        white   = "#abb2bf",
        fg1     = "#b2b2b2",
        comment = "#5c6370",
        sel0    = "#364a82", --visual
      },
      carbonfox = {
        white   = "#abb2bf",
        fg1     = "#b2b2b2",
        comment = "#5c6370",
        sel0    = "#364a82", --visual
      },
      dayfox    = {
        bg1     = "#e1e2e7",
        fg1     = "#4d688e",
        fg3     = "#a8aecb", --line number
        sel0    = "#99a7df", --visual
        orange  = "#b15c00", --number
      },
    }
    require("nightfox").setup({ palettes = palettes })
    end,
  },
-- }}}
-- {{{ folke/tokyonight.nvim
  {
    "folke/tokyonight.nvim",
    event = "BufReadPre",
    config = function()
    require("tokyonight").setup({
      style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      light_style = "day", -- The theme is used when the background is set to light
      transparent = false, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      styles = {
        comments = { italic = false },
        keywords = { bold = true },
        functions = { italic = true },
        variables = { },
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
      },
      sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
      dim_inactive = false, -- dims inactive windows
      lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

      on_colors = function(colors) end,

      on_highlights = function(highlights, colors) end,
    })
    end,
  },
-- }}}
-- {{{ catppuccin/nvim
  {
    "catppuccin/nvim",
    name = "catppuccin",
    event = "BufReadPre",
    config = function()
    require("catppuccin").setup({
        transparent_background = false,
        show_end_of_buffer = false, -- show the '~' characters after the end of buffers
        term_colors = true,
        dim_inactive = {
            enabled = false,
            shade = "dark",
            percentage = 0.15,
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = {
            comments = {},
            conditionals = { "italic" },
            loops = {},
            functions = { "italic" },
            keywords = { "bold" },
            strings = {},
            variables = {},
            numbers = { "italic" },
            booleans = {},
            properties = {},
            types = { "italic", "bold" },
            operators = {},
        },
        color_overrides = {
                    latte = {
                        base = '#e1e2e7',
                        mantle = "#e1e2e7",
                    },
                    frappe = {
                        text   = "#abb2bf",
                        mantle = "#303446",
                    },
                    macchiato = {
                        text   = "#abb2bf",
                        mantle = "#24273A",
                    },
                    mocha = {
                        text     = "#abb2bf",
                        --text = "#F4CDE9",
                        subtext1 = "#DEBAD4",
                        subtext0 = "#C8A6BE",
                        overlay2 = "#B293A8",
                        overlay1 = "#9C7F92",
                        overlay0 = "#866C7D",
                        surface2 = "#705867",
                        surface1 = "#5A4551",
                        surface0 = "#44313B",
                        base     = "#352939",
                        mantle   = "#352939", --origin "#1E1E2E"
                        crust    = "#1a1016",
                    },
        },
        custom_highlights = {},
        integrations = {
            cmp = true,
            telescope = true,
            dashboard = true,
            markdown = true,
            mason = true,
            neotree = true,
            treesitter = true,
            treesitter_context = true,
            ts_rainbow2 = true,
            which_key = true,
        },
    })
    end,
  },
-- }}}
-- {{{ projekt0n/github-nvim-theme
  {
    "projekt0n/github-nvim-theme",
    event = "BufReadPre",
    config = function()
    require('github-theme').setup({
    options = {
      -- Compiled file's destination location
      compile_path = vim.fn.stdpath('cache') .. '/github-theme',
      compile_file_suffix = '_compiled', -- Compiled file suffix
      hide_end_of_buffer = true, -- Hide the '~' character at the end of the buffer for a cleaner look
      hide_nc_statusline = true, -- Override the underline style for non-active statuslines
      transparent = false,       -- Disable setting background
      terminal_colors = true,    -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
      dim_inactive = false,      -- Non focused panes set to alternative background
      module_default = true,     -- Default enable value for modules
      styles = {                 -- Style to be applied to different syntax groups
        comments = 'NONE',     -- Value is any valid attr-list value `:help attr-list`
        functions = 'italic',
        keywords = 'bold',
        variables = 'NONE',
        conditionals = 'italic',
        constants = 'NONE',
        numbers = 'italic',
        operators = 'NONE',
        strings = 'NONE',
        types = 'italic, bold',
      },
      inverse = {                -- Inverse highlight for different types
        match_paren = false,
        visual = false,
        search = false,
      },
      darken = {                 -- Darken floating windows and sidebar-like windows
        floats = false,
        sidebars = {
          enable = true,
          list = {},             -- Apply dark background to specific windows
        },
      },
      modules = {                -- List of various plugins and additional options
            'cmp',
            'dashboard',
            'indent_blankline',
            'native_lsp',
            'neotree',
            'telescope',
            'treesitter',
            'treesitter_context',
            'whichkey',
            'markdown',
            'mason',
            'ts_rainbow2',
            'which_key',
      },
    },
    palettes = {},
    specs = {},
    groups = {},
    })
    end,
  },
-- }}}
-- {{{ norcalli/nvim-colorizer.lua
  {
    "norcalli/nvim-colorizer.lua",
	keys = {
		{ "<leader>co", mode = { "n" }, "<cmd>ColorizerToggle<cr>", desc = "Toggle color highlighter" },
	},
    config = function()
    require'colorizer'.setup()
    end,
  },
-- }}}
-- {{{ nvim-telescope/telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    dependencies = {
        {
        "nvim-telescope/telescope-file-browser.nvim",
        config =function()
        require("telescope").load_extension "file_browser"
        end,
        },
        { "nvim-lua/plenary.nvim" },
    },
    config = function()
    require("telescope").setup {
        defaults = {
            initial_mode = 'normal',
            prompt_prefix = " ",
            selection_caret = " ",
            path_display = { "smart" },
            dynamic_preview_title = true,
        },
        pickers = {
            find_files = {
            hidden = true,
            --find_command = { "fd", "f" },
            find_command = { "rg", "--files" },
            mappings = {
                n = {
                    ["cd"] = function(prompt_bufnr)
                    local selection = require("telescope.actions.state").get_selected_entry()
                    local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                    require("telescope.actions").close(prompt_bufnr)
                    -- Depending on what you want put `cd`, `lcd`, `tcd`
                    vim.cmd(string.format("silent lcd %s", dir))
                end
                }
            }
            },
       },
        extensions = {
            file_browser = {
            theme = "ivy",
            hijack_netrw = true,
            },
        },
    }
    end,
    init = function()
    --neomap("n", "<leader>fp", ":Telescope file_browser<cr>", key_opts_ns)
    neomap("n", "<leader>ff", ":Telescope file_browser path=:/<left><left>", key_opts_n)
    vim.cmd[[nnoremap <silent> <leader>fb :lua require("telescope.builtin").find_files({layout_strategy="vertical"})<cr>]]
    neomap("n", "<leader>fp", ":Telescope current_buffer_fuzzy_find<cr>", key_opts_ns)
    neomap("n", "<leader>fl", ":Telescope live_grep<cr>", key_opts_ns)
    neomap("n", "<leader>fc", ":Telescope command_history<cr>", key_opts_ns)
    neomap("n", "<leader>fs", ":Telescope search_history<cr>", key_opts_ns)
    neomap("n", "<leader>fr", ":Telescope oldfiles<cr>", key_opts_ns)
    end,
  },
-- }}}
-- {{{ nvim-orgmode/orgmode
  {
    "nvim-orgmode/orgmode",
    ft = "org",
    dependencies = {
        {
          "akinsho/org-bullets.nvim",
          ft = "org",
          config = function()
          require('org-bullets').setup({
              show_current_line = false,
              concealcursor = true,
              indent = true,
              symbols = {
                  list = "•",
                  headlines = {"◉", "◎", "○", "✺", "▶", "⤷" }, -- neorg level1:◉⦿
                  --headlines = { "◉", "○", "✸", "✿" },        -- orgmode
                  --headlines = {"🌸","🌱","💧","✨","💗" },   -- others
                  checkboxes = {
                      cancelled = { '', 'OrgCancelled' },
                      half = { '', 'OrgTSCheckboxHalfChecked' },
                      done = { '', 'OrgDone' },--✓
                      todo = { '', 'OrgTODO' },--×
                  },
              },
          })
          end,
        },
    },
    config = function()
    local orgmode = require('orgmode')
    orgmode.setup_ts_grammar()
    orgmode.setup({
       org_agenda_files = { 'C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/Org/**' },
       org_default_notes_file = 'C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/Org/index.org',
       org_hide_leading_stars = true,
       org_hide_emphasis_markers = true,
       org_todo_keywords = { 'TODO(t)', 'WAITING', 'IN-PROGRESS', '|', 'DONE(d)', 'CANCELLED' },
       org_todo_keyword_faces = {
           ['TODO'] = ':background cyan :foreground black',
           ['WAITING'] = ':background darkyellow :foreground black',
           ['IN-PROGRESS'] = ':background coral :foreground black',
           ['DONE'] = ':background chartreuse :foreground black',
           ['CANCELLED'] = ':background red :foreground black',
       }
    })
    end,
    init = function()
    vim.cmd([[au FileType org setlocal nofoldenable]]) -- 关闭打开org默认folding
    neomap("n", "<leader>ss", ":Neotree C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/Org/<CR>", key_opts_ns)
    neomap("n", "<leader>ro", ":<C-U>e C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/friendly-snippets/snippets/org.json<CR>", key_opts_ns)
    end,
  },
-- }}}
-- {{{ nvim-treesitter/nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = {
            "TSInstall",
            "TSUninstall",
            "TSUpdate",
            "TSUpdateSync",
            "TSInstallInfo",
            "TSInstallSync",
            "TSInstallFromGrammar",
    },
    dependencies = {
            { "HiPhish/nvim-ts-rainbow2" },
    },
    config = function()
    local rainbow = require 'ts-rainbow'
    local treesitter_list = { "python", "fortran", "c", "vim", "lua", "latex", "markdown", "org", "matlab" }
    require 'nvim-treesitter.install'.compilers = { "clang" }
    require'nvim-treesitter.configs'.setup {
      ensure_installed = treesitter_list,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = treesitter_list,
      },
      incremental_selection = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      rainbow = {
          enable = true,
          query = {
             'rainbow-parens',
          },
          extended_mode = true,
          strategy = rainbow.strategy.global,
      },
    }
    end,
  },
-- }}}
-- {{{ hrsh7th/nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "onsails/lspkind.nvim",
            branch = "master",
            commit = "c68b3a0",
            config = function()
                local lspkind_icons = require('lspkind').presets['default']
                lspkind_icons['Constructor']   = '  '-- 
                lspkind_icons['Field']         = '  '-- ⌘ 
                lspkind_icons['Interface']     = ' ﰮ '
                lspkind_icons['Unit']          = '  '
                lspkind_icons['Snippet']       = '  '-- ✂️   
                lspkind_icons['Reference']     = '  '
                lspkind_icons['Struct']        = ' פּ '-- 
                lspkind_icons['Event']         = '  '
                lspkind_icons['TypeParameter'] = '  '
                lspkind_icons['Text']          = '  '
                lspkind_icons['Method']        = '  '
                lspkind_icons['Function']      = ' ƒ '-- ƒ
                lspkind_icons['Variable']      = '  '
                lspkind_icons['Class']         = ' ﴯ '
                lspkind_icons['Module']        = '  '
                lspkind_icons['Property']      = ' ﰠ '
                lspkind_icons['Value']         = '  '
                lspkind_icons['Enum']          = '  '
                lspkind_icons['Keyword']       = '  '
                lspkind_icons['Color']         = '  '
                lspkind_icons['File']          = '  '
                lspkind_icons['Folder']        = '  '
                lspkind_icons['EnumMember']    = '  '
                lspkind_icons['Constant']      = '  '
                lspkind_icons['Operator']      = '  '
            end,
        },
        { "hrsh7th/cmp-emoji" },
        { "hrsh7th/cmp-calc" },
        { "mstanciu552/cmp-matlab" },
        { "lukas-reineke/cmp-under-comparator" },
        {
          "uga-rosa/cmp-dictionary",
          branch = "main",
          commit = "93f3e2c",
          config = function()
          require("cmp_dictionary").setup({
              dic = {
		          --["*"] = { "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/Directionary-8813.dic" },
        	      ["*"] = { "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/Directionary-69903.dic" },
              },
	          exact = 2,
	          first_case_insensitive = true,
	          document = false,
	          document_command = "wn %s -over",
	          async = true,     --If you are using a very large dictionary and the body operation is blocked, try 'true'
	          max_items = -1,   --This is the maximum number of candidates that this source will return to the nvim-cmp body. -1 means no limit.
	          capacity = 5,
	          debug = false,
          })
           --require("cmp_dictionary").update() -- THIS
          vim.cmd("CmpDictionaryUpdate")
        end,
        },
        { "ray-x/cmp-treesitter" },
    },
    opts = function()
    local lspkind = require('lspkind')
    local source_mapping = {
        nvim_lsp = 'ﲳ',--[LSP]
        path = '🖫 ',--[PATH]
        luasnip = '',
        buffer = '﬘',--[BUF]
        calc = '',--[CALC]
        emoji = '😄',--[EMOJI]
        cmp_matlab = '[MAT]',
        dictionary = '',--[Dict]
        treesitter = '',--[TS]
        orgmode = '',--[Org]
        --latex_symbols = '[TEX]',
        --nuspell = '[SPELL]',
        --spell = '暈[SPELL]',
    }
    local cmp = require'cmp'
    return {
        completion = {
            completeopt = "menu,menuone,noinsert",
        },
        snippet = {
            expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
        },
        window = {
            completion = cmp.config.window.bordered({
                side_padding = 0,
                col_offset = -4,
            }),
            documentation = {
                border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
            },
        },
        experimental = {
            ghost_text = true,
            native_menu = false,
        },

        sorting = {
            priority_weight = 2,
            comparators = {
                require("cmp-under-comparator").under,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
            ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
            ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
            ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
            ["<C-c>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close(), },
            ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true, },
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
                elseif require("luasnip").expand_or_jumpable() then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
                else
                    fallback()
                end
            end, { "i", "s" }
            ),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
               	cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
            	vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
            	fallback()
            end
            end, { "i", "s" }
            ),
        }),
        formatting = {
            -- fields = { "abbr", "kind", "menu" },
            fields = { "kind", "abbr", "menu" },
			maxwidth = 60,
			maxheight = 10,
          	format = function(entry, vim_item)
           		vim_item.kind = lspkind.symbolic(vim_item.kind, {mode = "symbol"})
                -- vim_item.kind = string.format('%s %s', lspkind.symbolic(vim_item.kind, {mode = "symbol"}), vim_item.kind)
           		vim_item.menu = source_mapping[entry.source.name]
           		-- vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
                function trim(text)
                    local max = 40
                    if text and text:len() > max then
                        text = text:sub(1,max) .. "..."
                    end
                    return text
                end
                vim_item.abbr = trim(vim_item.abbr)
           		-- vim_item.abbr = vim_item.abbr:match("[^(]+")
           		return vim_item
            end,
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'calc' },
            { name = 'emoji' },
            { name = 'cmp_matlab' },
            { name = "dictionary", keyword_length = 2 },
            { name = "treesitter" },
            { name = "orgmode" },
            --{ name = "latex_symbols" },
        })
    }
    end,
  },
-- }}}
-- {{{ hrsh7th/cmp-cmdline
  {
    "hrsh7th/cmp-cmdline",
    --event = "BufReadPre",
    --event = "CmdlineEnter",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp", "hrsh7th/cmp-path", "hrsh7th/cmp-buffer" },
    config = function()
    local cmp = require'cmp'
    require("cmp").setup.cmdline({ "/", "?" }, {
        mapping = require("cmp").mapping.preset.cmdline({
          ['<Tab>'] = cmp.mapping(cmp.mapping.confirm({ select = true }), { 'i', 'c' }),
        }),
        sources = require("cmp").config.sources({
          { name = "buffer", keyword_length = 1 },
        }),
    })
    require("cmp").setup.cmdline(":", {
        mapping = require("cmp").mapping.preset.cmdline({
          ['<Tab>'] = cmp.mapping(cmp.mapping.confirm({ select = true }), { 'i', 'c' }),
        }),
        sources = require("cmp").config.sources({
          { name = "path", keyword_length = 1 },
        }, {
          { name = "cmdline", keyword_length = 1 },
        }),
    })
    end,
  },
-- }}}
-- {{{ saadparwaiz1/cmp_luasnip
  {
    "saadparwaiz1/cmp_luasnip",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip" },
  },
-- }}}
-- {{{ neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        {
          "williamboman/mason.nvim",
          build = ":MasonUpdate",
          config = function()
          require("mason").setup()
          end,
        },
        { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
    -- local lsp_list = { "pylsp", "vimls", "lua_ls", "matlab_ls" }
    local lsp_list = { "pylsp" }
    require("mason-lspconfig").setup({
        ensure_installed = lsp_list
    })
    for _, lsp in pairs(lsp_list) do
      if lsp == 'diagnosticls' then
        require('lspconfig')[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 150,
          }
        }
      else
        require('lspconfig')[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 150,
          }
        }
      end
    end
    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev) -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        neomap('n', 'gd', vim.lsp.buf.definition, opts)
        neomap('n', 'gD', vim.lsp.buf.type_definition, opts)
        neomap('n', 'K', vim.lsp.buf.hover, opts)
        neomap('n', 'gr', vim.lsp.buf.references, opts)
        neomap('n', 'gi', vim.lsp.buf.implementation, opts)
        neomap('n', '<space>r', vim.lsp.buf.rename, opts)
        neomap('i', '<C-h>', vim.lsp.buf.signature_help, opts)
        -- neomap({ 'n', 'v' }, ';', vim.lsp.buf.code_action, opts)
        -- neomap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        -- neomap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        -- neomap('n', '<space>wl', function()
        --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, opts)
      end,
    })
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "single",
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "single",
    })
    ------------ lsp language config ------------
    -- pylsp
    -- change C:\Users\ThinkPad\AppData\Local\nvim-data\mason\packages\python-lsp-server\venv\pyvenv.cfg:
    -- include-system-site-packages = true
    -- for completions 3rd party modules
    require('lspconfig').pylsp.setup {
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        settings = {
            pylsp = {
                plugins = {
                    jedi_completion = {
                        enabled = true,
                        fuzzy = true,
                        include_params = true, -- this line enables snippets
                        cache_for = { 'numpy','matplotlib' },
                    },
                    pycodestyle = {
                        maxLineLength = 150,
                    },
                },
            },
        },
    }
    if vim.fn.executable('lua-language-server')==1 then
        require('lspconfig').lua_ls.setup {
            capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = { enable = false },
                    format = { enable = false },
                    semantic = { enable = false },
                },
            },
        }
    end
    end,
    opts = function()
    -- diagnostic
    vim.diagnostic.config({
        underline = true,
        signs = true,
        virtual_text = false, -- default is true
        float = {
            show_header = true,
            source = 'if_many',
            border = 'rounded',
            focusable = false,
        },
        update_in_insert = false, -- default is false
        severity_sort = false, -- default is false
    })
    local diagnostics_active = true
    local toggle_diagnostics = function()
      diagnostics_active = not diagnostics_active
      if diagnostics_active then
        vim.diagnostic.show()
      else
        vim.diagnostic.hide()
      end
    end
    neomap('n', '<F6>', toggle_diagnostics)
    neomap('n', '<F5>', '<cmd>lua vim.diagnostic.open_float()<CR>', key_opts_ns)
    --neomap('n', '<leader>d[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', key_opts_ns)
    --neomap('n', '<leader>d]', '<cmd>lua vim.diagnostic.goto_next()<CR>', key_opts_ns)
    --neomap('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', key_opts_ns)
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end -- 取消代码诊断信息显示
    neomap('n', '<leader>=', function() vim.lsp.buf.format { async = true } end, key_opts_ns) -- Format
    end,
  },
-- }}}
-- {{{ ray-x/lsp_signature.nvim
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
    require'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key
    require'lsp_signature'.on_attach(cfg, bufnr) -- no need to specify bufnr if you don't use toggle_key
    end,
    opts = function()
    cfg = {
     debug = false, -- set to true to enable debug logging
     log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
     -- default is  ~/.cache/nvim/lsp_signature.log
     verbose = false, -- show debug line number

     bind = true, -- This is mandatory, otherwise border config won't get registered.
                  -- If you want to hook lspsaga or other signature handler, pls set to false
     doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                    -- set to 0 if you DO NOT want any API comments be shown
                    -- This setting only take effect in insert mode, it does not affect signature help in normal
                    -- mode, 10 by default

     max_height = 12, -- max height of signature floating_window
     max_width = 80, -- max_width of signature floating_window
     noice = false, -- set to true if you using noice to render markdown
     wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long

     floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
     floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
     -- will set to true when fully tested, set to false will use whichever side has more space
     -- this setting will be helpful if you do not want the PUM and floating win overlap

     floating_window_off_x = 1, -- adjust float windows x position.
     floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines

     close_timeout = 4000, -- close floating window after ms when laster parameter is entered
     fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
     hint_enable = true, -- virtual hint enable
     hint_prefix = "🧐 ",--🐼,🧐🤔
     hint_scheme = "String",
     hi_parameter = "lsp_signature_highlight",  -- "Cursor" "IncSearch" "Visual" "Search"
     handler_opts = {
       border = "rounded"   -- double, rounded, single, shadow, none, or a table of borders
     },

     always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

     auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
     extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
     zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

     padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

     transparency = nil, -- disabled by default, allow floating win transparent value 1~100
     shadow_blend = 36, -- if you using shadow as border use this set the opacity
     shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
     timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
     toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

     select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
     move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
    }
    end,
  },
-- }}}
-- {{{ L3MON4D3/LuaSnip
  { "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    config = function()
    require("luasnip/loaders/from_vscode").lazy_load({ paths = {"C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/friendly-snippets"}})
    end,
    init = function()
    neomap("n", "<leader>rm", ":<C-U>e C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/friendly-snippets/snippets/add_snippets/matlab.json<CR>", key_opts_ns)
    neomap("n", "<leader>rp", ":<C-U>e C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/friendly-snippets/snippets/python/Maxl_python.json<CR>", key_opts_ns)
    end,
  },
-- }}}
-- {{{ Eandrju/cellular-automaton.nvim
  {
    "Eandrju/cellular-automaton.nvim",
    keys = {
        { "<localleader>,", "<cmd>CellularAutomaton make_it_rain<CR>", mode = "n", desc = "make it rain" },
    }
  },
-- }}}
-- {{{ HaoHao-Ting/vim-matlab-formatter
  { "HaoHao-Ting/vim-matlab-formatter",
    ft = "matlab",
    cmd = "MatlabFormatter",
    config = function()
    if vim.bo.filetype == 'matlab' then
      neomap('n', '<leader>=', ':MatlabFormatter<CR>', key_opts_ns)
    end
    end,
  },
-- }}}
-- {{{ lewis6991/gitsigns.nvim
  {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local gitsigns = require("gitsigns")
		gitsigns.setup({
			signs = {
				add          = { text = '▐' },--
				change       = { text = '▐' },--
				delete       = { text = '▐' },--
				topdelete    = { text = '▐' },--
				changedelete = { text = '▐' },
				untracked    = { text = '▐' },--★
			},
			signcolumn     = true,  -- Toggle with `:Gitsigns toggle_signs`
			linehl         = false, -- Toggle with `:Gitsigns toggle_linehl`
			numhl          = false, -- Toggle with `:Gitsigns toggle_nunhl`
			word_diff      = false, -- Toggle with `:Gitsigns toggle_word_diff`
			sign_priority  = 9,
			watch_gitdir   = {
				interval     = 1000,
			},
			attach_to_untracked = false,
		})
	if pcall(require, "scrollbar") then
		require("scrollbar.handlers.gitsigns").setup()
	end
	end,
  },
-- }}}
-- {{{ nguyenvukhang/nvim-toggler
  {
    "nguyenvukhang/nvim-toggler",
    keys = {
            { "<leader>cl", mode = { "n", "v" }, desc = "Toggle word" },
        },
	config = function()
    require('nvim-toggler').setup({
      -- your own inverses
      inverses = {
        ['true'] = 'false',
        ['yes'] = 'no',
        ['on'] = 'off',
        ['left'] = 'right',
        ['up'] = 'down',
        -- ['!='] = '==',
      },
      remove_default_keybinds = true, -- removes the default <leader>i keymap
      neomap({ 'n', 'v' }, '<leader>cl', require('nvim-toggler').toggle),
      remove_default_inverses = true, -- removes the default set of inverses
    })
	end,
  },
-- }}}
  {
    "seandewar/bad-apple.nvim",
    cmd = { "BadApple" },
  },
-- {{{ folke/which-key.nvim
  {
    "folke/which-key.nvim",
    event = { "VeryLazy" },
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
          {
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = false,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      operators = { gc = "Comments" },
      key_labels = {
      },
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
      },
      popup_mappings = {
        scroll_down = '<c-d>',
        scroll_up = '<c-u>',
      },
      window = {
        border = "none",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 2, 2, 2, 2 },
        winblend = 0
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
      },
      ignore_missing = false,
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "},
      show_help = true,
      triggers = "auto",
      triggers_blacklist = {
        i = { "j", "k" },
        v = { "j", "k" },
      },
      }
      })
    end,
    opts = function()
    local L_all = require('which-key')
    L_all.register({
    ['a'] = {'Align'},
    ['b'] = {'Columns Num'},
    ['c'] = {
        name = 'Comment',
        ['c'] = {'Comment' },
        ['i'] = {'Uncomment' },
        },
    ['e'] = {'Tree'},
    g = {
        name = "Git",
        g = {"LazyGit" },
        },
    f = {
        name = "Telescope",
        s = {"Search History" },
        c = {"Command History" },
        b = {"CWD File" },
        p = {"Fuzze Word" },
        l = {"Word Line" },
        f = {"File Browser" },
        r = {"Recently files" },
        },
    ['z'] = {'Replace Word'},
    ['q'] = {'Close Buffer'},
    ['w'] = {'Python Send'},
    ['u'] = {'Undotree'},
    ['k'] = {'Color Word'},
    ['K'] = {'Uncolor Word'},
    ['/'] = {'Search <Pattern>'},
    ['.'] = {'Open Path'},
    [','] = {'Calculator'},
    ['='] = {'Format'},
    ['r'] = {
        name = 'VIMRC & Snippets',
        ['c'] = {'Edit VIMRC' },
        ['r'] = {'Reload VIMRC' },
        ['m'] = {'Matlab-Snippets' },
        ['o'] = {'Org-Snippets' },
        ['p'] = {'Python-Snippets' },
        },
    ['s'] = {
        name = 'Tools',
        ['s'] = {'Todo' },
        ['c'] = {'Spell Word' },
        ['n'] = {'Next Wrong Word' },
        ['p'] = {'previou Wrong Word' },
        ['t'] = {'Startify' },
        ['i'] = {'WhiteSpace' },
        ['?'] = {'Word Candidate' },
        },
    ['t'] = {
        name = 'Terminal',
        ['o'] = {'Term New' },
        ['t'] = {'Term Toggle' },
        ['n'] = {'Term Next' },
        ['r'] = {'Term Rg' },
        ['p'] = {'IPyhon' },
        ['a'] = {'Term(Admin)' },
        },
    }, { prefix = '<leader>' })

    local LL_others = require('which-key')
    LL_others.register({
    f = {
        name = "LeaderF",
        b = {"File Search" },
        c = {"Colorscheme" },
        f = {"Function" },
        l = {"Word Line" },
        p = {"Fuzze Word" },
        },
    ['t'] = {'Tag'},
    ['r'] = {'Recently files'},
    w = {
        name = "Weather Forecast",
        d = {"3 day" },
        e = {"1 day" },
        },
    }, { prefix = ',' })
    end,
  },
-- }}}
})
-- }}}

-- {{{ autocmds
vim.cmd[[
" 中/英输入法切换
augroup input_switching
    au!
    au VimEnter * :silent :!C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/im-select.exe 1033
    au InsertLeave * :silent :!C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/im-select.exe 1033
    au VimLeave * :silent :!C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/im-select.exe 1033
    " au InsertEnter * :silent :!C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/im-select.exe 2052
augroup END

" 解决matlab中文乱码的问题
augroup matlab_filetype
    au!
    au FileType matlab set fileencoding=cp936
augroup END

augroup python_related
    au!
    au BufNewFile,BufRead *.py set fileformat=unix
    au BufNewFile,BufRead *.rpy set syntax=python
augroup END

" 文本超过一定长度时自动换行
augroup tex_md_width
    au!
    au FileType tex set textwidth=72
    au FileType markdown set textwidth=80
augroup END

" 高亮加下划线显示每行第80个字符
" Fortran语言,高亮加下划线显示每行第72个字符(遵循Fortran77固定格式)
augroup line_font
    au!
    au BufRead,BufNewFile *.asm,*.c,*.cpp,*.java,*.cs,*.sh,*.lua,*.pl,*.pm,*.py,*.rb,*.hs,*.vim,*.md 2match Underlined /.\%81v/
    au BufRead,BufNewFile *.for 2match Underlined /.\%73v/
augroup END

" 当剩余的窗口都不是文件编辑窗口时,自动退出vim
augroup Buffer_quit
    au!
    au BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif
augroup END

" Highlihgt yank
set background=light " 放到这里的目的,为了tokyonight-day显示复制颜色(HighlightedyankRegion)
highlight HighlightedyankRegion ctermbg=237 guibg=#c34043
augroup highlight_yank
    au!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="HighlightedyankRegion", timeout=120}
augroup END

" << plasticboyvim-markdown >>
augroup markdown_type
    au!
    au FileType markdown setl conceallevel=2
augroup END

" << Plugin - table-mode >>
augroup markdown_table
    au!
    au FileType markdown let g:table_mode_corner = '|'
    au FileType markdown let g:table_mode_delimiter = ' '
    au FileType markdown let g:table_mode_verbose = 0
    au FileType markdown let g:table_mode_auto_align = 0
    au FileType markdown TableModeEnable
augroup END
]]
-- }}}

-- {{{ colorscheme
random_color = {
--light
    'catppuccin-latte',
    -- 'tokyonight-day',
    -- 'github_light',
    -- 'dayfox',
--dark
    -- 'duskfox',
    -- 'terafox',
    -- 'nordfox',
    -- 'nightfox',
    -- 'catppuccin-frappe',
    -- 'catppuccin-macchiato',
    -- 'catppuccin-mocha',
    -- 'github_dark',
}
math.randomseed(os.time())
local mycolor = random_color[math.random(table.getn(random_color))]
vim.cmd('colorscheme ' .. mycolor)
-- }}}

-- {{{ highlihgt (origin neovim & plugins)
-- cmp color
local fgdark = "#2E3440"

vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "#949cbb", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#808080", bg = "NONE", strikethrough = true })
-- CmpItemAbbrMatch
if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#9CDCFE", bg = "NONE", bold = true })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#e64553", bg = "NONE", bold = true })
elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#2E3440", bg = "NONE", bold = true })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#d73a4a", bg = "NONE", bold = true })
end

vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#ef9f76", bg = "NONE", italic = true })-- #abb2bf

vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = fgdark, bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = fgdark, bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = fgdark, bg = "#B5585F" })

vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = fgdark, bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = fgdark, bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = fgdark, bg = "#9FBD73" })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = fgdark, bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = fgdark, bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = fgdark, bg = "#D4BB6C" })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = fgdark, bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = fgdark, bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = fgdark, bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = fgdark, bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = fgdark, bg = "#A377BF" })

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = fgdark, bg = "#9CDCFE" })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = fgdark, bg = "#9CDCFE" })

vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = fgdark, bg = "#eb5e28" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = fgdark, bg = "#eb5e28" })
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = fgdark, bg = "#eb5e28" })

vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = fgdark, bg = "#7287fd" })
vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = fgdark, bg = "#7287fd" })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = fgdark, bg = "#7287fd" })

vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = fgdark, bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = fgdark, bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = fgdark, bg = "#58B5A8" })

-- dark & light colorscheme
if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
    -- search color
    vim.api.nvim_command("hi Search guibg=#228b22 guifg=#ccd0da")
    -- cuc cul color
    vim.cmd('hi CursorLine gui=NONE guibg=#3C4452')
    vim.cmd('hi Cursorcolumn gui=NONE guibg=#3C4452')
elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
    -- search color
    vim.api.nvim_command("hi Search guibg=#40a02b guifg=#e1e2e7")
    -- cuc cul color
    vim.cmd('hi CursorLine gui=NONE guibg=#c6cbd9')
    vim.cmd('hi Cursorcolumn gui=NONE guibg=#c6cbd9')
end
-- diff color (original neovim)
vim.api.nvim_command("hi DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=bold guifg=bg guibg=#87af87")  -- 新增的行
vim.api.nvim_command("hi DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=bold guifg=bg guibg=#86abdc")  -- 删除的行
vim.api.nvim_command("hi DiffChange cterm=none ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=#8787af")  -- 变化的行
vim.api.nvim_command("hi DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=bold guifg=bg guibg=#f7768e")  -- 变化的文字
-- lsp_signature.nvim color
vim.api.nvim_command("hi lsp_signature_highlight guifg=black guibg=#f68e26")
-- mg979/vim-visual-multi theme
if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
    vim.g.VM_theme = 'iceblue'
elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
    vim.g.VM_theme = 'lightblue2'
end
-- which-key background color (transparency)
vim.api.nvim_command("hi WhichKeyFloat ctermbg=black ctermfg=black guibg=0")
vim.api.nvim_command("hi WhichKeyBorder ctermbg=black ctermfg=black guibg=0")
-- }}}

-- {{{ GUI&TERM
if vim.g.neovide then-- neovide
    vim.g.neovide_cursor_vfx_mode = "railgun"  -- "torpedo", "pixiedust", "ripple"
    vim.g.neovide_cursor_vfx_particle_density = 7.0
    vim.g.neovide_cursor_trail_length = 0.05
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_animation_length = 0.02
    vim.g.neovide_transparency = 0.97
    vim.g.neovide_fullscreen = false
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_remember_window_position = true
    vim.g.neovide_confirm_quit = true              -- 修改文件后退出提示
    vim.g.neovide_hide_mouse_when_typing = true    -- 输入时隐藏鼠标
    -- vim.g.neovide_profiler = true               -- 左上角显示帧数
    vim.g.neovide_scroll_animation_length = 0.3
    -- Adjust transparency
    neomap('n', '<M-,>', ':let g:neovide_transparency -= 0.02<CR>:let g:neovide_transparency<CR>', {})
    neomap('n', '<M-.>', ':let g:neovide_transparency += 0.02<CR>:let g:neovide_transparency<CR>', {})
    neomap('i', '<M-,>', '<C-o>:let g:neovide_transparency -= 0.02<CR><C-o>:let g:neovide_transparency<CR>', {})
    neomap('i', '<M-.>', '<C-o>:let g:neovide_transparency += 0.02<CR><C-o>:let g:neovide_transparency<CR>', {})
    -- Toggle fullscreen
    neomap("n", "<m-CR>", function()
        vim.g.neovide_fullscreen = vim.g.neovide_fullscreen == 1 and 0 or 1
    end, { desc = "Toggle fullscreen" })
elseif vim.g.goneovim then-- gonevim
    neomap("n", "<m-CR>", ":GonvimMaximize<CR>", key_opts_ns)
    neomap("n", "<leader>rg", ":<C-U>e C:/Users/ThinkPad/AppData/Roaming/.goneovim/settings.toml<CR>", key_opts_ns)
elseif vim.g.nvy then-- nvy
else-- terminal
    -- vim.api.nvim_command("hi Normal guibg=NONE")
    -- vim.api.nvim_command("hi NonText guibg=NONE")
    -- vim.api.nvim_command("hi SignColumn guibg=NONE")
end
-- }}}







