-- Last Modified Date: 2023.04.24
-- Desc              : NEOVIM 0.10.0(support Python, Lua)
--                          __
--  __  ____   __   __  __ /\_\    ___ ___     ____   ____
-- |  \/  \ \ / /  /\ \/\ \\/\ \ /'' __` _`\  |  _ \ / ___|
-- | |\/| |\ V /   \ \ \_/ |\ \ \/\ \/\ \/\ \ | |_) | |
-- | |  | | | |     \ \___/  \ \_\ \_\ \_\ \_\|  _ <| |___
-- |_|  |_| |_|      \/__/    \/_/\/_/\/_/\/_/|_| \_\\____|
-- ========================================================

-- Starup random config
math.randomseed(os.time())

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
-- marks
neomap("n", "mc", ":delmarks!<cr>", key_opts_ns)  --删除所有小写marks
neomap("n", "mC", ":delmarks A-Z<cr>", key_opts_ns)  --删除所有大写marks
-- 单词的 选/改/删
--[[ neomap("n", "vi", "viw", key_opts_ns)
neomap("n", "ci", "ciw", key_opts_ns)
neomap("n", "di", "diw", key_opts_ns) ]]
-- IDE like delete
neomap("i", "<C-BS>", "<Esc>b\"_dei", key_opts_ns)
-- 代码折叠
neomap("n", "<Tab>", "@=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>", key_opts_ns)
-- zf:创建折叠;zd:删除折叠,仅在manual/marker中有效;zD:删除嵌套折叠,仅在manual/marker中有效;za:打开/关闭当前折叠;zM:关闭所有折叠;zR:打开所有折叠
-------------------- copy path(file) --------------------
-- path without filename
-- neomap("n", "<leader>y", [[:let @+=('cd ' .. expand('%:p:h'))<CR>:echo "File path in clipboard"<CR>]], { desc = 'Copy Path(file)' }) -- 路径没有引号
neomap("n", "<leader>y", [[:let @+=('cd ' .. "'" .. expand('%:p:h') .. "'")<CR>:echo "File path in clipboard"<CR>]], { desc = '[Y]ank Path (file)' }) -- 路径有引号
-- if "expand('%:p')", path with filename
-------------------- spell checking --------------------
-- 设置拼写检查开关
neomap('n', '<Leader>sc', ':set spell!<CR>', { desc = 'Spell Word' })
-- 拼写检查导航
neomap('n', '<leader>sn', ']s', { desc = 'Next Wrong Word' })
neomap('n', '<leader>sp', '[s', { desc = 'previou Wrong Word' })
neomap('n', '<leader>sa', 'zg', key_opts_ns)
-- 显示单词拼写建议
neomap('n', '<leader>s?', 'z=', { desc = 'Word Candidate' })
-- 查找并替换
neomap('n', '<leader>z', [[:%s/\<<C-R>=expand("<cword>")<CR>\>/<C-R>=expand("<cword>")<CR>/g<left><left>]], { desc = 'Replace Word' })
neomap('v', '<leader>z', [[:s///g<left><left><left>]], { desc = 'Replace Word' })
-- 创建列表
neomap('n', '<leader>b', [[:put =range(,,1)<left><left><left><left>]], { desc = 'Columns Num' })
-------------------- 分屏 --------------------
-- 分屏后窗口最大化和恢复
neomap("n", "<m-,>", "<c-w>_<c-w>|", key_opts_ns)
neomap("n", "<m-.>", "<c-w>=", key_opts_ns)
-- 互换分割窗口
neomap('n', '<S-h>', '<C-w>b<C-w>H', key_opts_ns)
-- neomap('n', 'srh', '<C-w>b<C-w>K', {}) -- 注释掉，因为与 <S-h> 冲突
-- 光标移动
neomap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
neomap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
neomap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
neomap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
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
-- 将新的空白缓冲区替换当前页
neomap('n', '<c-w>e', ':enew<cr>', key_opts_ns)
-- 新建标签页
neomap('n', '<leader><Tab>', ':tabnew<CR>', { desc = '[Tab]new' })
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
-- buffer
neomap('n', '<leader>q', ':bd<CR>', { desc = '[Q]uit/Kill Buffer' })  -- bd!: quit even not save
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
neomap('n', '<leader>st', ':Startify<CR>', { desc = 'Startify' })
-- diff this
neomap('n', '<leader>dt', ':diffthis<CR>', { desc = '[D]iff [T]his' })
-- vimrc
neomap('n', '<leader>rc', ':edit $MYVIMRC<CR>', { desc = 'Edit VIMRC' })
neomap('n', '<leader>rr', ':source $MYVIMRC<CR>', { desc = '[R]eload VIMRC' })
-- 插入时间
vim.cmd([[iab xtime <c-r>=strftime("20%y-%m-%d %a %H:%M")<CR>]])
vim.cmd([[iab xdate <c-r>=strftime("20%y-%m-%d (%a)")<CR>]])
-- 取消高亮
neomap('n', '<BS>', ':nohlsearch<CR>', key_opts_ns)
-- 显示列表，使用`.`表示空格
neomap('n', '<F3>', ':set list!<CR>', key_opts_ns)
neomap('i', '<F3>', '<C-o>:set list!<CR>', key_opts_ns)
neomap('c', '<F3>', '<C-c>:set list!<CR>', key_opts_ns)
-- 高亮光标行列
neomap('n', '<F4>', ':set cuc! cul!<CR>', key_opts_ns)
neomap('i', '<F4>', '<C-o>:set cuc! cul!<CR>', key_opts_ns)
-- smart split
function Smart_split()
    if vim.api.nvim_win_get_width(0) > vim.api.nvim_win_get_height(0) * 3 then
        -- vim.cmd("vsplit")  --当前文件分屏
        vim.cmd("vnew")  --空白分屏
    else
        -- vim.cmd("split")  --当前文件分屏
        vim.cmd("new")  --空白分屏
    end
end
neomap('n', '<leader>\\', ':lua Smart_split()<CR>', { desc = 'Smart split' })
-- neomap('n', '<C-\\>', [[:set splitright<CR>:vsplit<CR>]], key_opts_ns)
-- neomap('n', '<C-\\>', [[:set splitbelow<CR>:split<CR>]], key_opts_ns)
-------------------- Configuration file --------------------
vim.cmd[[
command! Psconfig execute "edit C:/Users/ThinkPad/Documents/PowerShell/Microsoft.PowerShell_profile.ps1"
command! Alconfig execute "edit C:/Users/ThinkPad/AppData/Roaming/alacritty/alacritty.toml"
command! Weconfig execute "edit C:/Users/ThinkPad/.config/wezterm/config/appearance.lua"
command! Yzconfig execute "edit C:/Users/ThinkPad/AppData/Roaming/yazi/config/yazi.toml"
command! Ssconfig execute "edit C:/Users/ThinkPad/Documents/PowerShell/starship.toml"
command! Wfconfig execute "edit C:/Users/ThinkPad/.config/winfetch/config.ps1"
command! Lgconfig execute "edit C:/Users/ThinkPad/AppData/Roaming/lazygit/config.yml"
command! Riconfig execute "edit C:/Users/ThinkPad/AppData/Roaming/Rime/default.custom.yaml"
]]
-- }}}

-- {{{ font
-- English (all have Nerd): 'Delugia Mono' ≈ Cascadia Code; 'CodeNewRoman NFM'; 'OperatorMono NF'; 'ComicMono NF'
-- 中文: 'Noto Sans Mono CJK SC' (whitout Nerd); LXGW WenKai Mono (whitout Nerd); 'inconsolatago qihei nf' (Nerd)
vim.opt.guifont     = "Delugia Mono:h12"
-- vim.opt.guifontwide = "Noto Sans Mono CJK SC:h12"
vim.opt.guifontwide = "LXGW WenKai Mono:h12"
-- Adjust fontsize
vim.cmd[[
let s:guifontsize=12
let s:guifont="Delugia\\ Mono"
"let s:guifontwide="Noto\\ Sans\\ Mono\\ CJK\\ SC"
let s:guifontwide="LXGW\\ WenKai\\ Mono"

function! AdjustFontSize(amount)
    let s:guifontsize = s:guifontsize + a:amount
    execute "set guifont=" .. s:guifont .. ":h" .. s:guifontsize
    execute "set guifontwide=" .. s:guifontwide .. ":h" .. s:guifontsize
endfunction

function!  AdjustFontSize_0()
    execute "set guifont=" .. s:guifont .. ":h12"
    execute "set guifontwide=" .. s:guifontwide .. ":h12"
endfunction
]]
-- keyboard
neomap("n", "<C-->", ":call AdjustFontSize(-1)<CR>", key_opts_ns)
neomap("n", "<C-=>", ":call AdjustFontSize(1)<CR>", key_opts_ns)
neomap("n", "<C-0>", ":call AdjustFontSize_0()<CR>", key_opts_ns)

neomap("i", "<C-->", "<C-o>:call AdjustFontSize(-1)<CR>", key_opts_ns)
neomap("i", "<C-=>", "<C-o>:call AdjustFontSize(1)<CR>", key_opts_ns)
neomap("i", "<C-0>", "<C-o>:call AdjustFontSize_0()<CR>", key_opts_ns)
-- mouse
neomap("n", "<C-ScrollWheelUp>", ":call AdjustFontSize(1)<CR>", key_opts_ns)
neomap("n", "<C-ScrollWheelDown>", ":call AdjustFontSize(-1)<CR>", key_opts_ns)
neomap("i", "<C-ScrollWheelUp>", "<ESC>:call AdjustFontSize(1)<CR>a", key_opts_ns)
neomap("i", "<C-ScrollWheelDown>", "<ESC>:call AdjustFontSize(-1)<CR>a", key_opts_ns)
-- }}}

-- {{{ options
vim.g.have_nerd_font = true
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
    showmode = false,
    hlsearch = true,
    ignorecase = true,  -- 忽略大小写
    incsearch = true,  -- 开启实时搜索功能
    laststatus = 2,  -- 3:global Statusline, default is 2
    linebreak = true,
    list = true,
    listchars = { tab = '» ', trail = '·', nbsp = '␣' },
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
    timeout = true,
    updatetime = 250,
    timeoutlen = 300,
    visualbell = true,
    whichwrap = "h,l,<,>,[,],~",  -- 允许backspace和光标键跨越行边界
    wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
    wildignorecase = true,
    wildmenu = true,
    wildmode = "longest:full,full",  -- Command-line completion mode
    wrap = true,
    writebackup = false,
    -- shell = "C:/PROGRA~1/PowerShell/7/pwsh.exe" -- pwsh7,启动速度200+ms
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
if vim.fn.has("nvim-0.9.5") == 1 then
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
        { "<C-Up>", desc = "Visual Multi up" },
        { "<C-Down>", desc = "Visual Multi down" },
        { "<C-z>", desc = "Visual Multi select all" },
        { "<C-n>", mode = { "n", "x" }, desc = "visual multi" },
    },
    init = function()
      vim.g.VM_highlight_matches = 'underline'
      vim.g.VM_maps = {
        ["Find Under"]         = "<C-n>",
        ["Find Subword Under"] = "<C-n>",
        ["Select All"]         = "<C-z>",
        ["Add Cursor Up"]      = "<C-Up>",
        ["Add Cursor Down"]    = "<C-Down>",
      }
    end,
  },
-- Local plugins
-- {{{ Dir = vim-speeddating-master
  { dir = "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/Local_Plugins/vim-speeddating-master", ft = { "markdown" } }, --modified
-- }}}
-- {{{ Dir = weather3day.nvim-main
  {
    dir = "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/Local_Plugins/weather3day.nvim-main", --modified
    keys = { { "<localleader>wd", ":Weather3day<CR>",   mode = { "n" }, desc = '3 day' } },
    init = function()
    vim.g.weather_city = "Xi'an"--weather3day plug
    end,
  },
-- }}}
-- Github plugins
-- {{{ nvim-lualine/lualine.nvim
  {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    config = function()

    local function modified()
      if vim.bo.modified then
        return '[+]'  -- +
      elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        return '-'
      end
      return ''
    end

    local function search_result()
      if vim.v.hlsearch == 0 then
        return ''
      end
      local last_search = vim.fn.getreg('/')
      if not last_search or last_search == '' then
        return ''
      end
      local searchcount = vim.fn.searchcount { maxcount = 9999 }
      return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
    end

    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = ''},
            disabled_filetypes = {
                statusline = { 'dashboard', 'startify' },
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = {
                {
                    'windows',
                    use_mode_colors = true,
                    show_filename_only = true,
                    show_modified_status = false,
                    mode = 0,
                    max_length = vim.o.columns * 2 / 3,
                    symbols = {
                        modified = ' [+]',  -- 🈚, [+], , ' [𝓐 ]'
                        alternate_file = '#',
                        directory =  '',
                    },
                    filetype_names = {
                        startuptime = '⏳',
                    },
                    padding = { right = 1 },  -- 该组件右侧空白长度
                },
                {   modified, color = { fg = '#ca1243', gui = 'bold' }, padding = { left = 0 }, },  -- bg = '#ca1243'
            },
            lualine_b = {
                {
                    'branch', icon = {'', align='right', color={fg='#ff8800'}},
                },  --  
                {
                    'diff',
                    symbols = {added = '+', modified = '~', removed = '-'},
                },
                {
                    'diagnostics',
                    sources = { "nvim_diagnostic" },
                    sections = { "error", "warn", "hint", "info" },
                    symbols = {
                        error = ' ', --
                        warn = ' ', --
                        hint = ' ', --
                        info = ' ', --
                    },
                    colored = true,
                    update_in_insert = false,
                    always_visible = false,
                },
            },
            lualine_c = {
                {
                    'filename',
                    file_status = false,
                    newfile_status = false,
                    path = 2,
                    shorting_target = 40,
                },
            },
            lualine_x = {
                {
                    search_result,
                },
                {
                    'filetype',
                    colored = true,
                    icon_only = true,
                },
            },  -- 'os.date("%H:%M %a")'
            lualine_y = { '%c' },
            lualine_z = { '%l - %L' },
        },
        extensions = {
            "neo-tree"
        }
    }

    --Match colorscheme
    local max_lualine_theme_frappe_transparent = require('lualine_custom_theme').max_lualine_theme_frappe_transparent
    local max_lualine_theme_latte_transparent  = require('lualine_custom_theme').max_lualine_theme_latte_transparent
    local max_lualine_theme_frappe             = require('lualine_custom_theme').max_lualine_theme_frappe
    local max_lualine_theme_latte              = require('lualine_custom_theme').max_lualine_theme_latte
    local max_lualine_theme_macchiato          = require('lualine_custom_theme').max_lualine_theme_macchiato
    local max_lualine_theme_mocha              = require('lualine_custom_theme').max_lualine_theme_mocha

    if vim.fn.has('gui_running') == 1 then
        if vim.g.colors_name == 'catppuccin-frappe' then
            require'lualine'.setup {options = { theme = max_lualine_theme_frappe }}
        elseif vim.g.colors_name == 'catppuccin-macchiato' then
            require'lualine'.setup {options = { theme = max_lualine_theme_macchiato }}
        elseif vim.g.colors_name == 'catppuccin-mocha' then
            require'lualine'.setup {options = { theme = max_lualine_theme_mocha }}
        elseif vim.g.colors_name == 'catppuccin-latte' then
            require'lualine'.setup {options = { theme = max_lualine_theme_latte }}
        end
    else
        if vim.g.colors_name == 'catppuccin-frappe' then
        require'lualine'.setup {options = { theme = max_lualine_theme_frappe_transparent }}
        elseif vim.g.colors_name == 'catppuccin-latte' then
        require'lualine'.setup {options = { theme = max_lualine_theme_latte_transparent }}
        end
    end
    end,
  },
-- }}}
-- {{{ nvimdev/dashboard-nvim
    {
        "nvimdev/dashboard-nvim",
        event = 'BufWinEnter',
        config = function()
            require('dashboard').setup {
                theme = 'doom',
                config = {
                    header ={
                        [[                                             ]],
                        [[                                             ]],
                        [[                                             ]],
                        [[   ▄████▄              ▒▒▒▒▒       ▒▒▒▒▒     ]],
                        [[  ███▄█▀              ▒ ▄▒ ▄▒     ▒ ▄▒ ▄▒    ]],
                        [[ ▐████     █  █  █   ▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒▒   ]],
                        [[  █████▄             ▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒▒   ]],
                        [[   ▀████▀            ▒ ▒ ▒ ▒ ▒   ▒ ▒ ▒ ▒ ▒  ]],
                        [[                                             ]],
                        [[                                             ]],
                        [[                                             ]],
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
                            action  = 'Leaderf file'
                        },
                        {
                            icon    = '  ',--
                            icon_hl = 'Title',
                            desc    = 'Recently Files',
                            desc_hl = 'String',
                            key     = 'r',
                            key_hl  = 'Number',
                            keymap  = ', r',
                            action = 'Leaderf mru',
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
                            icon    = '💤 ',--  鈴
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
                            icon    = '  ',
                            icon_hl = 'Title',
                            desc    = 'Todo List',
                            desc_hl = 'String',
                            key     = 'n',
                            key_hl  = 'Number',
                            keymap  = 'SPC n',
                            action = 'GlobalNote',
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
                            "🎉 NVIM(v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch .. ") " .. "loaded " .. require("lazy").stats().count .. " plugins  in " .. require"lazy".stats().startuptime .. " ms 🎉",
                        }
                    end
                },
                hide = {
                    statusline = true,
                    tabline = true,
                    winbar = true,
                },
            }

            -- random pacman color
            local pacman_color_list = {
                  '#000000', '#030303', '#080808', '#0D0D0D', '#121212', '#171717', '#1A1A1A',
                --'#fff304', '#e46e16', '#49b6b1', '#f4a6c5',
                --'#db231d', '#374392', '#0C0C0C', '#C50F1F',
                --'#13A10E', '#C19C00', '#0037DA', '#881798',
                --'#3A96DD', '#CCCCCC', '#767676', '#E74856',
                --'#16C60C', '#e6cf00', '#3B78FF', '#B4009E',
                --'#72b5e4', '#f0c53f', '#ff8784', '#c5c7f1',
                --'#c2d735', '#78d3cc', '#ea8336', '#e43542',
                --'#ebab35', '#ebe735', '#aadd32', '#dcca6b',
                --'#219286', '#2f569c', '#ffb577', '#5282a4',
                --'#edfccf', '#67064c', '#f5bca7', '#95c474',
                --'#dece83', '#de9783', '#f2e700', '#e9e9e9',
                --'#69636d', '#626b98', '#f5f5a7', '#dcca6b',
                --'#b72a83', '#6f2b9d', '#69636d', '#5f569c',
            }
            local randomIndex_pacman = math.random(1, #pacman_color_list)
            -- vim.api.nvim_command("hi DashboardHeader guifg='#925ba6'")
            vim.api.nvim_command("hi DashboardHeader guifg=" .. pacman_color_list[randomIndex_pacman])
        end,
    },
-- }}}
-- {{{ folke/persistence.nvim
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = { save_empty = false },
    keys = { { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" } },
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
    neomap('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndotree' })
    end,
    -- 增加系统环境变量Path"D:\Program Files\Git\usr\bin",解决打开插件报错的问题.
  },
-- }}}
-- {{{ dstein64/vim-startuptime
  {
    "dstein64/vim-startuptime",
	keys = { { "<F12>", mode = { "n" }, ":StartupTime<CR>", desc = "StartupTime" } },
    init = function()
    vim.g.startuptime_tries = 10
    end,
  },
-- }}}
-- {{{ arecarn/vim-crunch
  {
    "arecarn/vim-crunch",
    keys = {
        { "<leader>,", mode = { "n" }, "<Plug>(crunch-operator-line)", { desc = 'Calculator' } },
        { "<leader>,", mode = { "x" }, "<Plug>(visual-crunch-operator)", { desc = 'Calculator' } },
    },
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
  {
    "AndrewRadev/linediff.vim",
	keys = { { "<leader>dl", mode = { "n", "v" }, ":Linediff<CR>", desc = "[D]iff [L]ine" } },
  },
-- }}}
-- {{{ alpertuna/vim-header
  {
    "alpertuna/vim-header",
	keys = { { "<F2>", mode = { "n" }, ":AddHeader<CR>", desc = "Add Header" } },
    config = function()
    vim.g.header_field_author           = 'Max'
    vim.g.header_field_author_email     = 'ismaxiaolong@gmail.com'
    vim.g.header_field_timestamp_format = '%Y.%m.%d'
    vim.g.header_field_modified_by      = 0
    vim.g.header_field_license_id       = ''
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
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "Leaderf" },
    keys = {
        { "<leader>fs", mode = { "n" }, ":LeaderfFile :/<left><left>", desc = "File by Path" },
        { "<leader>fp", mode = { "n" }, "<cmd>Leaderf rg<cr>", desc = "Fuzzy word" },
        { "<leader>ff", mode = { "n" }, "<cmd>Leaderf file<cr>", desc = "[F]ile" },
        { "<leader>fg", mode = { "n" }, "<cmd>Leaderf git<cr>", desc = "[G]it" },
        { "<leader>fl", mode = { "n" }, "<cmd>Leaderf line<cr>", desc = "[L]ine" },
        { "<leader>fc", mode = { "n" }, "<cmd>Leaderf colorscheme<cr>", desc = "[C]olorscheme" },
        { "<leader>fh", mode = { "n" }, "<cmd>Leaderf searchHistory<cr>", desc = "Search [H]istory" },
        { "<localleader>T", mode = { "n" }, "<cmd>Leaderf bufTag<cr>", desc = "[T]ag" },
        { "<localleader>F", mode = { "n" }, "<cmd>Leaderf function<cr>", desc = "[F]unction" },
        { "<leader>fr", mode = { "n" }, "<cmd>Leaderf mru<cr>", desc = "[R]ecently Files" },
        { "<localleader>r", mode = { "n" }, "<cmd>Leaderf mru<cr>", desc = "[R]ecently Files" },
        { "<leader>fb", mode = { "n" }, "<cmd>Leaderf buffer<cr>", desc = "[B]uffer" },
    },
    init = function()
    vim.g.Lf_ShortcutF = ""
    vim.g.Lf_ShortcutB = ""
    end,
    config = function()
    require('leaderf_PopupTheme_and_Icons')  -- 修改leaderf主题配色和icon
    vim.g.Lf_Ctags = "C:/Users/ThinkPad/scoop/shims/ctags.exe"
    vim.g.Lf_Rg = 'C:/Users/ThinkPad/scoop/shims/rg.exe'
	vim.g.Lf_CursorBlink  = 0
    vim.g.Lf_ShowDevIcons = 1
    vim.g.Lf_SpacesAfterIcon = ' '
    vim.g.Lf_DevIconsFont = "Delugia Mono"
    vim.g.Lf_ReverseOrder = 1
    vim.g.Lf_HideHelp = 1
    vim.g.Lf_UseCache = 1
    vim.g.Lf_UseMemoryCache = 1
    vim.g.Lf_UseVersionControlTool = 0
    vim.g.Lf_IgnoreCurrentBufferName = 1
	vim.g.Lf_WorkingDirectoryMode = 'Ac'
	vim.g.Lf_DefaultMode = 'NameOnly'
    vim.g.Lf_PreviewCode = 1
    vim.g.Lf_PreviewInPopup = 1
    vim.g.Lf_StlSeparator = { left = "", right = "" }  -- left = "", right = ""
    vim.g.Lf_JumpToExistingWindow = 0
    vim.g.Lf_PreviewResult = {
        File        = 1,
        Buffer      = 0,
        Mru         = 0,
        Tag         = 0,
        BufTag      = 1,
        Function    = 1,
        Line        = 1,
        Colorscheme = 0,
        Rg          = 1,
        Gtags       = 0,
    }-- 0:不自动预览; 1:自动预览
    vim.g.Lf_NeedCacheTime = 0.1  -- cache the files list,if time > 0.1s.
    vim.g.Lf_CacheDirectory = "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/cache/leaderf_mru_cache"
    vim.g.Lf_MruMaxFiles = 2048
    vim.g.Lf_MruEnableFrecency = 0
    vim.g.Lf_ShowRelativePath = 1
    vim.g.Lf_WildIgnore = {
      dir = { ".svn", ".git", ".hg" },
      file = { "*.sw?", "~$*", "*.bak", "*.exe", "*.o", "*.so", "*.py[co]" },
    }
    -- 使用:LeaderfRg 路径不全时, 默认搜索该文件目录下的文件
    vim.cmd([[command! -bar -nargs=? -complete=dir LeaderfRg Leaderf! rg "" <q-args>]])

    -- 修改预览窗口移动,默认为<C-Up>和<C-Down>,修改为<C-b>和<C-f>
    vim.g.Lf_CommandMap = { ['<C-Up>'] = { '<C-b>' }, ['<C-Down>'] = { '<C-f>' } }

    -- Bottom mode & Change statusline color (not popup mode)
    vim.g.Lf_WindowPosition = 'bottom'
    vim.api.nvim_set_hl(0, "Lf_hl_stlName",         { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlMode",         { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlSeparator0",   { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlSeparator1",   { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlSeparator2",   { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlSeparator3",   { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlSeparator4",   { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlSeparator5",   { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlLineInfo",     { link = "Statusline" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlRegexMode",    { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlFullPathMode", { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlFuzzyMode",    { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlBlank",        { link = "Statusline" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlTotal",        { link = "Statusline" })

    if vim.fn.has('gui_running') == 1 then
        if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
            vim.api.nvim_set_hl(0, "Lf_hl_stlCategory",     { bg="#303446", fg="#429940", bold=true, italic=true } ) --2 domain
            vim.api.nvim_set_hl(0, "Lf_hl_stlNameOnlyMode", { bg="#303446", fg="#737994" } )                      --3 domain
            vim.api.nvim_set_hl(0, "Lf_hl_stlCwd",          { fg="#b09a6f" } )                                            --4 domain
        elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
            vim.api.nvim_set_hl(0, "Lf_hl_stlCategory",     { bg="#e1e2e7", fg="#8839ef", bold=true, italic=true } )  --2 domain
            vim.api.nvim_set_hl(0, "Lf_hl_stlNameOnlyMode", { bg="#e1e2e7", fg="#838ba7" } )                      --3 domain
            vim.api.nvim_set_hl(0, "Lf_hl_stlCwd",          { bg="#e1e2e7", fg="#de6d78" } )                              --4 domain
        end
    else
        if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
            vim.api.nvim_set_hl(0, "Lf_hl_stlCategory",     { bg=nil, fg="#429940", bold=true, italic=true } ) --2 domain
            vim.api.nvim_set_hl(0, "Lf_hl_stlNameOnlyMode", { bg=nil, fg="#737994" } )                      --3 domain
            vim.api.nvim_set_hl(0, "Lf_hl_stlCwd",          { bg=nil, fg="#b09a6f" } )                              --4 domain
        elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
            vim.api.nvim_set_hl(0, "Lf_hl_stlCategory",     { bg=nil, fg="#8839ef", bold=true, italic=true } ) --2 domain
            vim.api.nvim_set_hl(0, "Lf_hl_stlNameOnlyMode", { bg=nil, fg="#838ba7" } )                      --3 domain
            vim.api.nvim_set_hl(0, "Lf_hl_stlCwd",          { bg=nil, fg="#de6d78" } )                              --4 domain
        end
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
  },
-- }}}
-- {{{ voldikss/vim-floaterm
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermNew", "FloatermSend" },
    config = function()
        if vim.o.background == 'dark' then
            vim.api.nvim_set_hl(0, "FloatermBorder", { fg = "#89a0c3", bg = "#303446" })
        elseif vim.o.background == 'light' then
            vim.api.nvim_set_hl(0, "FloatermBorder", { fg = "#40a02b", bg = "#e1e2e7" })
        end
    end,
    init = function()
        vim.g.floaterm_wintype = 'float'
        vim.g.floaterm_title = '─────  Terminal [$1|$2] '
        vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
        vim.g.floaterm_autoclose = 0
        vim.g.floaterm_keymap_kill = '<C-q>'
        vim.g.floaterm_keymap_next = '<leader>tn'
        vim.g.floaterm_shell="C:/PROGRA~1/PowerShell/7/pwsh.exe"
        -- 从':terminal '中打开外部nvim中的文件的命令。
        vim.g.floaterm_opener = 'edit'  -- 'edit', 'split', 'vsplit', 'tabe', 'drop'
        neomap("n","<leader>to",":FloatermNew --position=center --width=0.9 --height=0.9<CR>", { desc = 'New Term' })
        -- neomap("n","<localleader>e",":FloatermNew! --position=center --width=0.9 --height=0.9 --autoclose=1 lfcd<CR>") --slower
        -- neomap("n","<localleader>e",":FloatermNew --position=center --width=0.9 --height=0.9 --autoclose=1 lfcd<CR>") --faster
        neomap("n","<localleader>e",":FloatermNew --position=center --width=0.99 --height=0.99 --autoclose=1 yazi<CR>", { desc = 'yazi' }) --faster
        neomap("n","<leader>tt",":FloatermToggle<CR>", { desc = '[T]oggle Term' })
        neomap("n","<leader>tr",":FloatermNew<CR>rg.exe<Space>" , { desc = '[R]g' })
        neomap('n', '<M-o>', ':FloatermNew SumatraPdf <C-r><C-l><CR>', {})
        -- Lazygit. 首先在系统安装'jesseduffield/lazygit'
        -- lazygit的配置文件'C:\Users\ThinkPad\AppData\Roaming\lazygit\config.yml'
        neomap("n","<leader>gg",":FloatermNew --position=center --width=0.99 --height=0.99 --autoclose=1 Lazygit<CR>", { desc = 'Lazy[G]it' }) --faster
        neomap("n","<leader>tj",":FloatermNext<CR>", { desc = 'Next Term' } )
        neomap("n","<leader>tk",":FloatermPrev<CR>", { desc = 'Prev Term' } )

        vim.cmd[[
        augroup Compiler_code
        au!
        au FileType floaterm nnoremap <buffer> <Esc> :q<CR>
        " -- Python --
        au FileType python nnoremap <silent><C-CR> :FloatermNew py "%:p"<CR>
        " au FileType python nnoremap <C-g> :FloatermNew py "%:p"<CR>
        au FileType python noremap! <C-CR>  <Esc>:FloatermToggle<CR>
        " au FileType python noremap! <C-g>  <Esc>:FloatermToggle<CR>
        " au FileType python tnoremap <C-CR>  <C-\><C-n>:FloatermToggle<CR>
        " -- Python REPL --
        nnoremap <leader>tp :FloatermNew --width=0.5 --wintype=vsplit --name=repl --position=rightbelow ipython<CR>
        au FileType python nnoremap <leader>w :FloatermSend<CR>
        au FileType python vnoremap <leader>w :FloatermSend<CR>
        " -- Matlab --
        au FileType matlab nnoremap <silent><C-CR> :! matlab -nosplash -nodesktop -r %:r<CR><CR>
        " au FileType matlab nnoremap <silent><C-g> :! matlab -nosplash -nodesktop -r %:r<CR><CR>
        " TERMINAL运行matlab代码,以'test.m'代码为例 'matlab -nosplash -nodesktop -r test'
        " -- Fortran --
        au FileType fortran nnoremap <silent><C-CR> :FloatermNew<CR>compilervars.bat intel64<CR>ifort<Space>
        " au FileType fortran nnoremap <C-g> :FloatermNew<CR>compilervars.bat intel64<CR>ifort<Space>
        " -- Typst --
        " highligth file 'D:\Program Files\Neovim\share\nvim\runtime\syntax\typst.vim'
        au BufRead,BufNewFile *.typ setlocal filetype=typst
        au FileType typst nnoremap <silent><C-CR> :FloatermNew --height=1.0 typst watch %:p<CR>
        " au FileType typst nnoremap <C-g> :FloatermNew --height=1.0 typst watch %:p<CR>
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
-- {{{ iamcco/markdown-preview.nvim
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function() vim.fn["mkdp#util#install"]() end,
    init = function()
    vim.g.mkdp_auto_close = 0
    --设置预览代码高亮(绝对路径)
    vim.g.mkdp_markdown_css = "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/github-markdown.css"
    vim.g.mkdp_highlight_css = "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/markdown.css"
    --vim.g.mkdp_highlight_css = "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/markdown_highlight_solarized_dark.css"
    vim.g.mkdp_theme = 'light'  --'dark', 若不设置则和系统一致
    vim.cmd[[
    augroup markdown_preview
        au!
        au FileType markdown nnoremap <silent><C-CR> <Plug>MarkdownPreview
        " au FileType markdown nnoremap <C-g> <Plug>MarkdownPreview
    augroup END
    ]]
    end,
  },
-- }}}
-- {{{ plasticboy/vim-markdown
  {
    "preservim/vim-markdown",
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
    keys = {
        { "<localleader>li", "<plug>(vimtex-info)", mode = "n" },
        { "<localleader>lt", "<plug>(vimtex-toc-open)", mode = "n" },
        { "<localleader>lT", "<plug>(vimtex-toc-toggle)", mode = "n" },
        { "<localleader>lv", "<plug>(vimtex-view)", mode = "n" },
        { "<localleader>ll", "<plug>(vimtex-compile)", mode = "n", desc = 'Compile' },
        { "<localleader>lo", "<plug>(vimtex-compile-output)", mode = "n" },
        { "<localleader>lg", "<plug>(vimtex-status)", mode = "n" },
        { "<localleader>lG", "<plug>(vimtex-status-all)", mode = "n" },
        { "<localleader>lc", "<plug>(vimtex-clean)", mode = "n" },
        { "<localleader>lC", "<plug>(vimtex-clean-full)", mode = "n" },
    },
    config = function()
    vim.g.tex_flavor = "latex"
    vim.g.vimtex_quickfix_mode = 1
    vim.g.vimtex_compiler_progname = "nvr"
    vim.g.vimtex_view_reverse_search_edit_cmd = "nvr --remote-silent %f -c %l"
    vim.g.vimtex_compiler_latexmk = {
      continuous = 0, -- 1: save file auto compile and preview
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
    function Open_sumatra_pdf()
        local pdf_file = vim.fn.expand('%:r') .. '.pdf'
        if vim.fn.filereadable(pdf_file) == 0 then
          pdf_file = ""
        end
        local cmd = 'cmd /c start /b "" SumatraPDF -reuse-instance ' .. pdf_file
        os.execute(cmd)
    end
    vim.api.nvim_create_autocmd({"BufReadPost"}, {
      pattern = {"*.tex", "*.latex"},
      callback = Open_sumatra_pdf,
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
    }
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
	keys = { { "<leader>si", mode = { "n" }, ":StripWhitespace<CR>", desc = "WhiteSpace" } },
    config = function()
    vim.g.better_whitespace_guicolor='red'
    vim.g.strip_whitespace_on_save=0
    vim.g.better_whitespace_filetypes_blacklist = {
                'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown',
                'startify', 'dashboard'
    }
    end,
  },
-- }}}
-- {{{ lfv89/vim-interestingwords
  {
    "lfv89/vim-interestingwords",
    keys = {
        { "<leader>k", ":call InterestingWords('n')<cr>", mode = { "n" }, desc = 'Toggle Color Word(n)' },
        { "<leader>k", ":call InterestingWords('v')<cr>", mode = { "v" }, desc = 'Toggle Color Word(v)' },
        { "<leader>K", ":call UncolorAllWords()<cr>", mode = { "n" }, desc = 'Uncolor all Word' },
    },
    config = function()
    vim.g.interestingWordsGUIColors = {
                '#78d3cc', '#f0c53f', '#ff8784', '#c5c7f1',
                '#c2d735', '#72b5e4', '#ea8336', '#e43542',
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
    event = { "BufReadPre", "BufNewFile", "InsertEnter", "CmdlineEnter" },
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
            return vim.fn.getbufvar(bufnr, '&modified') == 1 and '[+] ' or ''  -- '[+] ', '● ', '🈚 ', ' '
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
            exclude_filetypes = {
                aerial = true,
                dashboard = true,
                startify = true,
            },
            support_filetypes = {
                "*.lua",
                "*.js",
                "*.m",
                "*.py",
            },
        },
        indent = {
            enable = true,
            chars = { "│", "¦", "┆", "┊", },
        },
        line_num = { enable = false },
        blank = { enable = false },
    })
    end,
  },
-- }}}
-- {{{ windwp/nvim-autopairs
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
-- }}}
-- {{{ karb94/neoscroll.nvim
  {
    "karb94/neoscroll.nvim",
    event = "BufReadPre",
    config = function()
    require('neoscroll').setup()
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
-- {{{ dstein64/nvim-scrollview
  {
    "dstein64/nvim-scrollview",
    event = "BufReadPre",
    keys = {
        { "]]", "<Cmd>ScrollViewNext<cr>",  mode = { "n" }, desc = "Next sign" },
        { "[[", "<Cmd>ScrollViewPrev<cr>",  mode = { "n" }, desc = "Prev sign" },
        { "[\\", "<Cmd>ScrollViewFirst<cr>", mode = { "n" }, desc = "First sign" },
        { "]\\", "<Cmd>ScrollViewLast<cr>",  mode = { "n" }, desc = "Last sign" },
    },
    config = function()
    require("scrollview").setup {
      excluded_filetypes = { 'dashboard', 'neo-tree','mason','floaterm' },
      winblend = 50,
      -- signs_on_startup = {'all'},
      signs_on_startup = {
          "conflicts",
          "cursor",
          "diagnostics",
          "folds",
          "loclist",
          "marks",
          "quickfix",
          "search",
          "spell",
          -- "textwidth",
          -- "trail",
      },

      -- cursor_symbol = "•",

      diagnostics_error_symbol = '',  --󰨓
      diagnostics_warn_symbol  = '',  --󰨓
      diagnostics_hint_symbol  = '',  --󰨓
      diagnostics_info_symbol  = '',  --󰨓
    }

    -- 自定义显示的diagnostics icon
    vim.g.scrollview_diagnostics_severities = {
      vim.diagnostic.severity.ERROR,
      -- vim.diagnostic.severity.WARN,
      -- vim.diagnostic.severity.INFO,
      -- vim.diagnostic.severity.HINT,
    }

    require("scrollview.contrib.gitsigns").setup {
      add_priority = 100,
      change_priority = 100,
      delete_priority = 100,
      -- add_symbol = '│',
      -- change_symbol = '│',
      -- delete_symbol = '_',
    }
    vim.api.nvim_set_hl(0, "ScrollViewHover", { link = "Search" })
    end,
  },
-- }}}
-- {{{ kevinhwang91/nvim-hlslens
  {
    "kevinhwang91/nvim-hlslens",
    event = { "InsertEnter", "CmdlineEnter" },
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
    })
    --mapping
    -- vim.cmd[[nnoremap <leader>/ /\<<C-R>=expand("<cword>")<CR>\><left><left>]]
    neomap('n', "<leader>/", [[:/\<<C-R>=expand("<cword>")<CR>\><left><left>]], { desc = 'Search <Pattern>' })
    --color
    if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
        vim.api.nvim_set_hl(0, "IncSearch", { fg = "#000000", bg = "#d73a4a", bold = true })
    elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
        vim.api.nvim_set_hl(0, "IncSearch", { fg = "#000000", bg = "#e78284", bold = true })
    end
    end,
  },
-- }}}
-- {{{ b3nj5m1n/kommentary
  {
    "b3nj5m1n/kommentary",
    keys = {
        { "<leader>cc", "<Plug>kommentary_line_increase",   mode = { "n" }, desc = '[C]omment' },
        { "<leader>cc", "<Plug>kommentary_visual_increase", mode = { "x" }, desc = '[C]omment' },
        { "<leader>ci", "<Plug>kommentary_line_decrease",   mode = { "n" }, desc = 'Uncomment' },
        { "<leader>ci", "<Plug>kommentary_visual_decrease", mode = { "x" }, desc = 'Uncomment' },
    },
    config = function()
    require('kommentary.config').configure_language({"lua"}, {
      prefer_single_line_comments = true,
    })
    vim.g.kommentary_create_default_mappings = false
    end,
  },
-- }}}
-- {{{ kyazdani42/nvim-web-devicons
  {
    "kyazdani42/nvim-web-devicons",
    branch = "master",
    commit = "9697285",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
    -- 设置icon (lualine, neo-tree)
    require('nvim_web_devicons_edit_icons')
    end,
  },
-- }}}
-- {{{ nvim-neo-tree/neo-tree.nvim
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = { "Neotree" },
    keys = {
        { '<Leader>e', '<cmd>Neotree filesystem left toggle dir=./<CR>', desc = 'NeoTre[e]' },
        { '<F7>', '<cmd>Neotree filesystem left toggle dir=c:/Users/ThinkPad/Desktop/<CR>', desc = 'Desktop' },
    },
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "MunifTanjim/nui.nvim" },
        { "kyazdani42/nvim-web-devicons" },
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    config = function()
    require("neo-tree").setup({
        use_default_mappings = false,
        close_if_last_window = true,
        popup_border_style = "rounded",
        window = {
            auto_expand_width = true,
        },
        filesystem = {
            follow_current_file = {
                enabled = true,
                leave_dirs_open = false,
            },
            use_libuv_file_watcher = true,
            hijack_netrw_behavior = "open_current",
            window = {
              mappings = {
                ["h"] = "navigate_up",
                ["l"] = "toggle_node",

                ["<2-leftmouse>"] = "open",
                ["<cr>"] = "open",

                ["s"] = "open_vsplit",
                ["t"] = "open_tabnew",

                ["a"] = "add",
                ["A"] = "add_directory",
                ["yy"] = "copy_to_clipboard",
                ["dd"] = "cut_to_clipboard",
                ["p"] = "paste_from_clipboard",
                ["X"] = "delete",
                ["r"] = "rename",

                ["P"] = "toggle_preview",
                ["<esc>"] = "revert_preview",

                ["."] = "toggle_hidden",
                ["R"] = "refresh",
                ["q"] = "close_window",
                ["?"] = "show_help",
              },
            },
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
                ignored   = "",
                unstaged  = "", -- U 
                staged    = "",
                conflict  = "",
              },
            },
        },
    })
    -- change color for NeoTreeIndent to light blue
    vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = "#3FC5FF" })
    end,
  },
-- }}}
-- {{{ ellisonleao/weather.nvim
  {
    "ellisonleao/weather.nvim",
    keys = { { "<localleader>we", ":Weather<CR>",   mode = { "n" }, desc = '1 day' } },
    config = function()
    require("weather").setup({
        city = "Xi'an",
        win_height = 10,
        win_width = 50,
    })
    end,
  },
-- }}}
-- {{{ echasnovski/mini.align
  {
    "echasnovski/mini.align",
    version = false,
    keys = {
        { mode = { 'x' }, '<leader>a', desc = '[A]lign' },
        { mode = { 'x' }, '<leader>A', desc = 'Interactive [A]lign' },
    },
    config = function()
        require('mini.align').setup({
            mappings = {
                start = '<leader>a',
                start_with_preview = '<leader>A',
            },
        })
    end,
  },
-- }}}
-- {{{ kylechui/nvim-surround
  { "kylechui/nvim-surround",
    keys = {
        { mode = "n", "ys" },
        { mode = "n", "cs" },
        { mode = "n", "ds" },
        { mode = "x", "<C-s>" },
    },
    config = function()
    require("nvim-surround").setup({
        keymaps = {
            normal = "ys",
            change = "cs",
            delete = "ds",
            visual = "<C-s>",
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
-- {{{ catppuccin/nvim
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    config = function()
    local transparent_TREM
    if vim.fn.has('gui_running') == 1 then
        transparent_TREM = false
    else
        transparent_TREM = true
    end
    require("catppuccin").setup({
        transparent_background = transparent_TREM,
        term_colors = true,
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
            -- telescope = true,
            dashboard = true,
            flash = true,
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
-- {{{ norcalli/nvim-colorizer.lua
  {
    "norcalli/nvim-colorizer.lua",
	keys = { { "<leader>co", mode = { "n" }, "<cmd>ColorizerToggle<cr>", desc = "Toggle Colorizer" } },
    config = function() require'colorizer'.setup() end,
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
                  headlines = { "⦿", "●", "◈", "◆", "◇", "▶", "○", "⤷" },  -- neorg level1: ◉⦿
                  --  { "◉", "○", "✸", "✺", "♦", "▶", "◇", "⤷" }, {"🌸","🌱","💧","✨","💗" }, ♠, ♣, ♦, ❀, ▼
                  checkboxes = {
                      cancelled = { '', 'OrgCancelled' },
                      half = { '', 'OrgTSCheckboxHalfChecked' },  --   
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
    -- orgmode.setup_ts_grammar()
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
       },
       mappings = {
           org = {
               org_change_date = 'cid',
               org_todo = 'cit',
               org_agenda_show_help = 'g?',  -- show help
               org_toggle_checkbox = '<cr>',
           },
       },
    })
    vim.api.nvim_set_hl(0, "@org.checkbox",             { fg = "#f23f42" })
    vim.api.nvim_set_hl(0, "@org.checkbox.halfchecked", { fg = "#0AC40A" })
    vim.api.nvim_set_hl(0, "@org.checkbox.checked",     { fg = "#0AC40A" })
    -- org-colors-doom-molokai
    vim.api.nvim_set_hl(0, "@org.headline.level1", { fg = "#fb2874" })
    vim.api.nvim_set_hl(0, "@org.headline.level2", { fg = "#fd971f" })
    vim.api.nvim_set_hl(0, "@org.headline.level3", { fg = "#9c91e4" })
    vim.api.nvim_set_hl(0, "@org.headline.level4", { fg = "#268bd2" })
    vim.api.nvim_set_hl(0, "@org.headline.level5", { fg = "#e74c3c" })
    vim.api.nvim_set_hl(0, "@org.headline.level6", { fg = "#b6e63e" })
    vim.api.nvim_set_hl(0, "@org.headline.level7", { fg = "#66d9ef" })
    vim.api.nvim_set_hl(0, "@org.headline.level8", { fg = "#e2c770" })
    end,
    init = function()
    vim.cmd([[au FileType org setlocal nofoldenable]]) -- 关闭打开org默认folding
    neomap("n", "<leader>od", ":Neotree C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/Org/<CR>", { desc = 'Org [D]irectories' })
    end,
  },
-- }}}
-- {{{ backdround/global-note.nvim
  {
    "backdround/global-note.nvim",
    cmd = { "GlobalNote" },
	keys = { { "<leader>n", mode = { "n" }, "<cmd>GlobalNote<cr>", desc = "Todo list" } },
    config = function()
        local global_note = require("global-note")
        global_note.setup({
            filename = "Todo-list.org",
            directory = vim.fn.stdpath("data") .. "/Maxl/Org/",
            title = "Todo list",
            command_name = "GlobalNote",
            window_config = function()
                local window_height = vim.api.nvim_list_uis()[1].height
                local window_width = vim.api.nvim_list_uis()[1].width
                return {
                    relative = "editor",
                    border = "rounded",  -- single
                    title = "Note",
                    title_pos = "center",
                    width = math.floor(0.7 * window_width),
                    height = math.floor(0.85 * window_height),
                    row = math.floor(0.55 * window_height),
                    col = math.floor(0.15 * window_width),
                }
            end,
            autosave = true,
            additional_presets = {},
        })
    end,
  },
-- }}}
-- {{{ nvim-treesitter/nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile', 'BufReadPre' },
    dependencies = {
        "hiphish/rainbow-delimiters.nvim",
        config = function()
            require("rainbow-delimiters.setup").setup({})
        end,
    },
    opts = {
      ensure_installed = { "bash", "python", "fortran", "c", "vim", "vimdoc", "query", "lua", "bibtex", "markdown", "org", "matlab", "json", "toml", "yaml", "typst", "ini"  },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
-- }}}
-- {{{ hrsh7th/nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            { "L3MON4D3/LuaSnip",
              config = function()
              require("luasnip/loaders/from_vscode").lazy_load({ paths = {"C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/friendly-snippets"}})
              end,
              init = function()
              neomap("n", "<leader>rsm", ":<C-U>e C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/friendly-snippets/snippets/add_snippets/matlab.json<CR>", { desc = 'Snippets: [M]atlab' })
              neomap("n", "<leader>rsp", ":<C-U>e C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/friendly-snippets/snippets/python/Maxl_python.json<CR>", { desc = 'Snippets: [P]ython' })
              neomap("n", "<leader>rso", ":<C-U>e C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/friendly-snippets/snippets/org.json<CR>", { desc = 'Snippets: [O]rg' })
              end,
            },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-emoji" },
            { "hrsh7th/cmp-calc" },
            { "mstanciu552/cmp-matlab" },
            { "lukas-reineke/cmp-under-comparator" },
            { "ray-x/cmp-treesitter" },
            { "saadparwaiz1/cmp_luasnip" },
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
                    -- treesitter
                    lspkind_icons['String']          = '  ' -- 
                    lspkind_icons['KeywordOperator'] = '  '
                    lspkind_icons['Error']           = '  '
                    lspkind_icons['Comment']         = ' 󰆉 ' -- 
                    lspkind_icons['Boolean']         = '  ' -- 
                    lspkind_icons['Conditional']     = '  '
                    lspkind_icons['KeywordReturn']   = ' 󰌑 '
                    lspkind_icons['Repeat']          = ' 󰑖 '
                    lspkind_icons['ConstantBuiltin'] = '  ' -- 
                    lspkind_icons['Number']          = '  '
                    lspkind_icons['Float']           = '  '
                    lspkind_icons['FunctionCall']    = '  '
                    lspkind_icons['KeywordFunction'] = '  '
                    lspkind_icons['StringEscape']    = ' 󱔁 '
                    lspkind_icons['Spell']           = ' 暈'
                    lspkind_icons["KeywordConditional"]  = '  '
                    lspkind_icons["KeywordRepeat"]       = ' 凌' -- 北
                    lspkind_icons['Orgtsblock']          = ' ⬛'
                    lspkind_icons['Orgtsheadlinelevel1'] = ' ◉ '
                    lspkind_icons['Orgtsheadlinelevel2'] = ' ◉ '
                    lspkind_icons['Orgtsheadlinelevel3'] = ' ◉ '
                    lspkind_icons['Orgtsheadlinelevel4'] = ' ◉ '
                    lspkind_icons['Orgtsheadlinelevel5'] = ' ◉ '
                    lspkind_icons['Orgtsheadlinelevel6'] = ' ◉ '
                    lspkind_icons['Orgtsheadlinelevel7'] = ' ◉ '
                    lspkind_icons['Orgtsheadlinelevel8'] = ' ◉ '
                    lspkind_icons['Orgtscheckbox']        = '  '
                    lspkind_icons['Orgtscheckboxchecked'] = '  '
                end,
            },
            { "dmitmel/cmp-cmdline-history" },
            {
                "hrsh7th/cmp-cmdline",
                config = function()
                    local cmp = require'cmp'
                    require("cmp").setup.cmdline({ "/", "?" }, {
                        mapping = require("cmp").mapping.preset.cmdline({
                            ['<Tab>'] = cmp.mapping(cmp.mapping.confirm({ select = true }), { 'i', 'c' }),
                        }),
                        sources = require("cmp").config.sources({
                            { name = "buffer", keyword_length = 1 },
                            { name = 'cmdline_history' },
                        }),
                    })
                    require("cmp").setup.cmdline(":", {
                        mapping = require("cmp").mapping.preset.cmdline({
                            ['<Tab>'] = cmp.mapping(cmp.mapping.confirm({ select = true }), { 'i', 'c' }),
                        }),
                        sources = require("cmp").config.sources({
                            { name = "path", keyword_length = 1 },
                            { name = "cmdline", keyword_length = 1 },
                            { name = 'cmdline_history' },
                        }),
                    })
                end,
            },
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
        },
        config = function()
            require 'luasnip'.config.setup {}
            local cmp = require('cmp')
            local lspkind = require('lspkind')
            local source_mapping = {
                nvim_lsp        = ' ﲳ ', --[LSP]
                path            = '  ', --[PATH] 🖫
                luasnip         = '  ',
                buffer          = ' ﬘ ', --[BUF]
                calc            = '  ', --[CALC] 
                emoji           = ' ﭂ ', --[EMOJI] 😄
                cmp_matlab      = '[]', --[MAT] [M]
                dictionary      = '  ', --[Dict] 
                treesitter      = '  ', --[TS] 
                orgmode         = '  ', --[Org]
                cmdline         = ' ﰩ ', -- ﯦ    ﰩ ﳺ
                cmdline_history = '  ',
                -- latex_symbols = '[TEX]',
                -- nuspell       = '[SPELL]',
                -- spell         = '暈[SPELL]',
            }
            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                window = {
                    completion = {
                        side_padding = 0,
                        col_offset = -4,
                        -- border = "rounded",
                        -- border = { "╭", " ", "╮", "│", "╯", "─", "╰", "│" },
                        border = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" },
                        scrollbar = true,
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
                        -- winhighlight = "FloatBorder:FloatBorder,CursorLine:CursorLine",
                    },
                    documentation = {
                        max_width = 50,
                        -- border = "rounded",
                        border = { "┌", " ", "┐", "│", "┘", " ", "└", "│" },
                        scrollbar = true,
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
                        -- winhighlight = "Normal:CmpPmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                    },
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
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
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),  -- ["<C-u>"]
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),  -- ["<C-d>"]
                    ["<C-c>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close(), },
                    ['<CR>'] = cmp.mapping.confirm { select = true },

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
                        else
                            fallback()
                        end
                    end, { "i", "s" }
                    ),

                    -- move in snippet (expansion locations)
                    ['<C-l>'] = cmp.mapping(function()
                      if require 'luasnip'.expand_or_locally_jumpable() then
                        require 'luasnip'.expand_or_jump()
                      end
                    end, { 'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function()
                      if require 'luasnip'.locally_jumpable(-1) then
                        require 'luasnip'.jump(-1)
                      end
                    end, { 'i', 's' }),

                }),
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    -- fields = { "abbr", "kind", "menu" },
                    maxwidth = 60,
                    maxheight = 10,
                    format = function(entry, vim_item)
                        vim_item.kind = lspkind.symbolic(vim_item.kind, {mode = "symbol"})
                        vim_item.menu = source_mapping[entry.source.name]
                        -- vim_item.kind = string.format('%s %s', lspkind.symbolic(vim_item.kind, {mode = "symbol"}), vim_item.kind)
                        -- vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
                        function Trim(text)
                            local max = 40
                            if text and text:len() > max then
                                text = text:sub(1,max) .. "..."
                            end
                            return text
                        end
                        vim_item.abbr = Trim(vim_item.abbr)
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
                }),
                experimental = {
                    ghost_text = {
                        hl_group = 'Comment',
                    },
                    -- ghost_text = false,
                    native_menu = false,
                },
            })
        end,
    },
    -- }}}
-- {{{ neovim/nvim-lspconfig
-- from "nvim-lua/kickstart.nvim"
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
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
      vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),

          callback = function(event)
              local map = function(mode, keys, func, desc)
                  vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
              end

              map('n', 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
              -- map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
              map('n', 'gD', vim.lsp.buf.type_definition, '[G]oto [D]eclaration')
              map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
              map('n', 'gh', vim.lsp.buf.signature_help, '[G]oto signature [H]elp')
              map('n', 'gr', vim.lsp.buf.references, '[G]oto [R]eferences')
              map('n', 'gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
              map('n', '<leader>lr', vim.lsp.buf.rename, '[R]ename')
              map('n', '<leader>la', vim.lsp.buf.code_action, 'Code [A]ction')
              map('n', '<leader>lf', vim.lsp.buf.format, '[F]ormat')
              -- Diagnostic keymaps
              map('n', '[d', vim.diagnostic.goto_prev, 'Previous [D]iagnostic')
              map('n', ']d', vim.diagnostic.goto_next, 'Next [D]iagnostic ')
              map('n', '<leader>lq', vim.diagnostic.setqflist, 'Diagnostic [Q]uickfix')
          end,
      })

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
          border = "single",
      })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
          border = "single",
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- { "pylsp", "vimls", "lua_ls", "matlab_ls" }
      local servers = {
          -- clangd = {},
          -- gopls = {},
          -- pylsp: 补全第三方库
          -- 修改 C:\Users\ThinkPad\AppData\Local\nvim-data\mason\packages\python-lsp-server\venv\pyvenv.cfg
          -- 设置 'include-system-site-packages = true'
          -- pylsp = {
          --     settings = {
          --         pylsp = {
          --             plugins = {
          --                 jedi_completion = {
          --                     enabled = true,
          --                     fuzzy = true,
          --                     include_params = true, -- this line enables snippets
          --                     cache_for = { 'numpy','matplotlib' },
          --                 },
          --                 pycodestyle = {
          --                     maxLineLength = 150,
          --                 },
          --             },
          --         },
          --     },
          -- },
          pyright = {},
          lua_ls = {
              -- cmd = {...},
              -- filetypes { ...},
              -- capabilities = {},
              settings = {
                  Lua = {
                      runtime = { version = 'LuaJIT' },
                      workspace = {
                          checkThirdParty = false,
                          -- Tells lua_ls where to find all the Lua files that you have loaded
                          -- for your neovim configuration.
                          -- library = {
                          -- '${3rd}/luv/library',
                          -- unpack(vim.api.nvim_get_runtime_file('', true)),
                          -- },
                          -- If lua_ls is really slow on your computer, you can try this instead:
                          library = { vim.env.VIMRUNTIME },
                      },
                      completion = {
                          callSnippet = 'Replace',
                      },
                      -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                      diagnostics = { disable = { 'missing-fields' } },
                  },
              },
          },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      require("mason-lspconfig").setup({
          ensure_installed = ensure_installed
      })

      require('mason-lspconfig').setup {
          handlers = {
              function(server_name)
                  local server = servers[server_name] or {}
                  -- This handles overriding only values explicitly passed
                  -- by the server configuration above. Useful when disabling
                  -- certain features of an LSP (for example, turning off formatting for tsserver)
                  server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                  require('lspconfig')[server_name].setup(server)
              end,
          },
      }

      -- diagnostic config
      local signs = { Error = '', Warn  = '', Hint  = '', Info  = '' }
      for type, icon in pairs(signs) do
          local hl = 'DiagnosticSign' .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
      vim.diagnostic.config({
          virtual_text = {
              prefix = '●', -- , , , ●
          },
          underline = false,
          signs = true,
          update_in_insert = false, -- default is false
          severity_sort = true, -- default is false
          float = {
              focusable = true,
              style = 'minimal',
              border = 'rounded',
              show_header = true,
              source = 'always',
              -- source = 'if_many',
              header = "",
              prefix = "",
          },
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

      neomap('n', '<F6>', toggle_diagnostics, { desc = 'Toggle diagnostics' })
      neomap('n', '<F5>', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
      -- neomap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

      -- vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end -- 取消代码诊断信息显示
    end,
  },
-- }}}
-- {{{ ray-x/lsp_signature.nvim
  {
    "ray-x/lsp_signature.nvim",
    event = 'LspAttach',
    config = function()
        local cfg = {
            hint_prefix = "📌 ",--🐼,🧐🤔
        }
        -- require'lsp_signature'.setup(cfg)
        -- require'lsp_signature'.on_attach(cfg, bufnr)
        require'lsp_signature'.on_attach(cfg)
    end,
  },
-- }}}
-- {{{ Eandrju/cellular-automaton.nvim
  {
    "Eandrju/cellular-automaton.nvim",
    keys = { { "<localleader>,", "<cmd>CellularAutomaton make_it_rain<CR>", mode = "n", desc = "make it rain" } }
  },
-- }}}
-- {{{ HaoHao-Ting/vim-matlab-formatter
  { "HaoHao-Ting/vim-matlab-formatter",
    ft = "matlab",
    cmd = "MatlabFormatter",
    config = function()
    if vim.bo.filetype == 'matlab' then
      neomap('n', '<leader>lf', ':MatlabFormatter<CR>', { desc = "Matlab [F]ormat" })
    end
    end,
  },
-- }}}
-- {{{ lewis6991/gitsigns.nvim
  {
	"lewis6991/gitsigns.nvim",
    event = "BufRead",
    keys = {
        { "<leader>gp", mode = { "n" }, "<cmd>Gitsigns preview_hunk<cr>", desc = "[P]review Hunk" },
        { "<leader>gd", mode = { "n" }, "<cmd>Gitsigns diffthis<cr>", desc = "[D]iff" },

        { "<leader>gl", mode = { "n" }, "<cmd>Gitsigns blame_line<cr>", desc = "B[l]ame" },

        { "<leader>gj", mode = { "n" }, "<cmd>Gitsigns next_hunk<cr>", desc = "Next Hunk" },
        { "<leader>gk", mode = { "n" }, "<cmd>Gitsigns prev_hunk<cr>", desc = "Prev Hunk" },

        { "<leader>gr", mode = { "n" }, "<cmd>Gitsigns reset_hunk<cr>", desc = "[r]eset Hunk" },
        { "<leader>gR", mode = { "n" }, "<cmd>Gitsigns reset_buffer<cr>", desc = "[R]eset Buffer" },

        { "<leader>gt", mode = { "n" }, "<cmd>Gitsigns toggle_word_diff<cr>", desc = "[T]oggle word_diff" },

        -- { "<leader>gs", mode = { "n", "v" }, "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Hunk" },
        -- { "<leader>gu", mode = { "n", "v" }, "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo Stage Hunk" },
    },
	config = function()
		local gitsigns = require("gitsigns")
		gitsigns.setup({
			signs = {
				add          = { text = ' ' },-- 
				change       = { text = ' ' },-- 
				delete       = { text = ' ' },-- 
				topdelete    = { text = ' ' },-- 
				changedelete = { text = ' ' },-- ▐
				untracked    = { text = ' ' },-- ★  
			},
			signcolumn     = true,  -- Toggle with `:Gitsigns toggle_signs`
			linehl         = false, -- Toggle with `:Gitsigns toggle_linehl`
			numhl          = false, -- Toggle with `:Gitsigns toggle_nunhl`
			word_diff      = true,  -- Toggle with `:Gitsigns toggle_word_diff`
			sign_priority  = 9,
			watch_gitdir   = {
				interval     = 1000,
			},
			attach_to_untracked = false,
		})
    -- signs color
    vim.api.nvim_set_hl(0, "GitSignsAdd",    { fg = "#a6d189", bg = "None" })
    vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#e78284", bg = "None" })
    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#26deff", bg = "None" })
    -- word_diff color
    vim.api.nvim_set_hl(0, "GitSignsAddInline",    { fg = "#00cc00", bg = "#005500" })
    vim.api.nvim_set_hl(0, "GitSignsDeleteInline", { fg = "#cc0000", bg = "#550000" })
    vim.api.nvim_set_hl(0, "GitSignsChangeInline", { fg = "#00cc00", bg = "#005500" })
	end,
  },
-- }}}
-- {{{ nguyenvukhang/nvim-toggler
  {
    "nguyenvukhang/nvim-toggler",
    keys = { { "<leader>i", function() require('nvim-toggler').toggle() end, mode = { "n", "v" }, desc = "Toggle word" } },
	config = function()
    require('nvim-toggler').setup({
      inverses = {
        ['true'] = 'false',
        ['yes'] = 'no',
        ['on'] = 'off',
        ['left'] = 'right',
        ['up'] = 'down',
        -- ['!='] = '==',
      },
      remove_default_keybinds = true, -- removes the default <leader>i keymap
      remove_default_inverses = true, -- removes the default set of inverses
    })
	end,
  },
-- }}}
-- {{{ folke/which-key.nvim
  {
    "folke/which-key.nvim",
    event = { "VeryLazy" },
    config = function()
    require("which-key").setup({
        plugins = {
            spelling = {
                enabled = false,
            },
        },
        icons = {
            breadcrumb = "»",
            separator = "",-- ➜
            group = "+",
        },
        popup_mappings = {
            scroll_down = '<c-f>',
            scroll_up = '<c-b>',
        },
        layout = {
            align = "center",  --left, center, right
        },
    })

    require('which-key').register {
        ['<leader>c']  = { name = '[C]omment' },
        ['<leader>d']  = { name = '[D]iff' },
        ['<leader>f']  = { name = 'Leader[F]' },
        ['<leader>g']  = { name = '[G]it' },
        ['<leader>s']  = { name = '[S]pell' },
        ['<leader>o']  = { name = '[O]rg' },
        ['<leader>w']  = { name = 'Python Send' },
        ['<leader>l']  = { name = '[L]SP', _ = 'which_key_ignore' },

        ['<leader>r']  = { name = 'VIM[R]C & [S]nippets' },
        ['<leader>rs'] = { name = '[S]nippets' },

        ['<leader>t']  = { name = '[T]erminal' },
        ['<leader>tn'] = { name = 'Term [N]ext' },
        ['<leader>tp'] = { name = 'I[P]yhon' },
        ['<leader>ta'] = { name = 'Term([A]dmin)' },

        ['<localleader>l'] = { name = '[L]atex' },
        ['<localleader>w'] = { name = '[W]eather Forecast' },
    }
    end,
  },
-- }}}
})
-- }}}

-- {{{ autocmds
vim.cmd[[
" 中/英输入法切换
" augroup input_switching
"     au!
"     au VimEnter * :silent :!C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/im-select.exe 1033
"     au InsertLeave * :silent :!C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/im-select.exe 1033
"     au VimLeave * :silent :!C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/im-select.exe 1033
"     " au InsertEnter * :silent :!C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/im-select.exe 2052
" augroup END

" 解决matlab中文乱码的问题
augroup matlab_filetype
    au!
    au FileType matlab set fileencoding=cp936
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

highlight HighlightedyankRegion ctermbg=237 guibg=#c34043
augroup highlight_yank
    au!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="HighlightedyankRegion", timeout=120}
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

-- nvim_create_augroups(autocmds)
local function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command("augroup " .. group_name)
        vim.api.nvim_command "autocmd!"
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command "augroup END"
    end
end

nvim_create_augroups({
    custom_filetypes = {
        { "BufNewFile,BufRead", "*.rpy", "set syntax=python" },
        { "BufNewFile,BufRead", "*.py", "set fileformat=unix" },

        { "BufRead", "*.md", "set conceallevel=2" },
    },
    save_shada = {
        { "VimLeave", "*", "wshada!" },
    },  -- save marks
})
-- }}}

-- {{{ colorscheme
if vim.fn.has('gui_running') == 1 then
-- random colorscheme
    local colorscheme_list = {
-- light
        -- 'catppuccin-latte',
-- dark
        'catppuccin-frappe',
        -- 'catppuccin-macchiato',
        -- 'catppuccin-mocha',
    }
    local randomIndex_CS = math.random(1,#colorscheme_list)
    vim.cmd('colorscheme ' .. colorscheme_list[randomIndex_CS])
else
    local colorscheme_list = {
-- light
        -- 'catppuccin-latte',
-- dark
        'catppuccin-frappe',
    }
    local randomIndex_CS = math.random(1,#colorscheme_list)
    vim.cmd('colorscheme ' .. colorscheme_list[randomIndex_CS])
end
-- vim.cmd('colorscheme catppuccin-frappe')
-- vim.cmd('colorscheme catppuccin-latte')
-- }}}

-- {{{ highlihgt (origin neovim & plugins)
-- cmp color
local fgdark = "#2E3440"
vim.api.nvim_set_hl(0, "PmenuSel", { fg = nil,       bg = "#3c4452"}) -- cmp 选中行背景颜色
vim.api.nvim_set_hl(0, "Pmenu",    { fg = "#949cbb", bg = nil}) -- cmp documentation font color

if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch",      { fg = "#82AAFF", bg = nil, bold = true })  -- #9CDCFE
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#b5585f", bg = nil, bold = true })
elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch",      { fg = "#2E3440", bg = nil, bold = true })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#d73a4a", bg = nil, bold = true })
end

vim.api.nvim_set_hl(0, "CmpItemAbbr",           { fg = "#949cbb", bg = nil })  -- #abb2bf
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = nil, strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemMenu",           { fg = "#C792EA", bg = nil, italic = true })  -- #ef9f76

vim.api.nvim_set_hl(0, "CmpItemKindField",    { fg = fgdark, bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = fgdark, bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindEvent",    { fg = fgdark, bg = "#B5585F" })

vim.api.nvim_set_hl(0, "CmpItemKindText",    { fg = fgdark, bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindEnum",    { fg = fgdark, bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = fgdark, bg = "#9FBD73" })

vim.api.nvim_set_hl(0, "CmpItemKindConstant",    { fg = fgdark, bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = fgdark, bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindReference",   { fg = fgdark, bg = "#D4BB6C" })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = fgdark, bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct",   { fg = fgdark, bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindClass",    { fg = fgdark, bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindModule",   { fg = fgdark, bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = fgdark, bg = "#A377BF" })

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = fgdark, bg = "#7E8294" }) -- #9CDCFE
vim.api.nvim_set_hl(0, "CmpItemKindFile",     { fg = fgdark, bg = "#7E8294" })  -- #9CDCFE

vim.api.nvim_set_hl(0, "CmpItemKindUnit",    { fg = fgdark, bg = "#D4A959" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = fgdark, bg = "#D4A959" })
vim.api.nvim_set_hl(0, "CmpItemKindFolder",  { fg = fgdark, bg = "#D4A959" })

vim.api.nvim_set_hl(0, "CmpItemKindMethod",     { fg = fgdark, bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindValue",      { fg = fgdark, bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = fgdark, bg = "#6C8ED4" })

vim.api.nvim_set_hl(0, "CmpItemKindInterface",     { fg = fgdark, bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindColor",         { fg = fgdark, bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = fgdark, bg = "#58B5A8" })

-- Diagnostics Highlights
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ff3939" })
vim.api.nvim_set_hl(0, "DiagnosticWarn",  { fg = "#ffa500" })
vim.api.nvim_set_hl(0, "DiagnosticHint",  { fg = "#1d6a70" })
vim.api.nvim_set_hl(0, "DiagnosticInfo",  { fg = "#FFCC66" })

vim.api.nvim_set_hl(0, "DiagnosticsDefaultError",    { bg = nil })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff3939", bg = nil, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  { fg = "#ffa500", bg = nil, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",  { fg = "#1d6a70", bg = nil, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",  { fg = "#FFCC66", bg = nil, italic = true })

vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { fg = "#ff3939", bg = nil, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn",  { fg = "#ffa500", bg = nil, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticFloatingHint",  { fg = "#1d6a70", bg = nil, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo",  { fg = "#FFCC66", bg = nil, italic = true })

vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#ff3939" })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn",  { fg = "#ffa500" })
vim.api.nvim_set_hl(0, "DiagnosticSignHint",  { fg = "#1d6a70" })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo",  { fg = "#FFCC66" })

-- dark & light colorscheme
if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
    -- search color
    vim.api.nvim_set_hl(0, "Search", { fg = "#ccd0da", bg = "#228b22" })
    -- cuc cul color
    vim.api.nvim_set_hl(0, "CursorLine",   { bg = "#3C4452" })
    vim.api.nvim_set_hl(0, "Cursorcolumn", { bg = "#3C4452" })
elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
    -- search color
    vim.api.nvim_set_hl(0, "Search", { fg = "#e1e2e7", bg = "#40a02b" })
    -- cuc cul color
    vim.api.nvim_set_hl(0, "CursorLine",   { bg = "#c6cbd9" })
    vim.api.nvim_set_hl(0, "Cursorcolumn", { bg = "#c6cbd9" })
end
-- diff color (original neovim)
vim.api.nvim_set_hl(0, "DiffAdd",    { fg = "#00cc00", bg = "#005500" })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#cc0000", bg = "#550000" })
vim.api.nvim_set_hl(0, "DiffChange", { fg = "#000000", bg = "#7A7A7A" })
vim.api.nvim_set_hl(0, "DiffText",   { fg = "#00cc00", bg = "#005500" })
-- lsp_signature.nvim color
vim.api.nvim_set_hl(0, "lsp_signature_highlight", { fg = "#000000", bg = "#f68e26" })
-- mg979/vim-visual-multi theme
if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
    vim.g.VM_theme = 'iceblue'
elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
    vim.g.VM_theme = 'lightblue2'
end
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
    neomap('n', '<C-_>', ':let g:neovide_transparency -= 0.25<CR>:let g:neovide_transparency<CR>', {})
    neomap('n', '<C-+>', ':let g:neovide_transparency += 0.25<CR>:let g:neovide_transparency<CR>', {})
    neomap('i', '<C-_>', '<C-o>:let g:neovide_transparency -= 0.25<CR><C-o>:let g:neovide_transparency<CR>', {})
    neomap('i', '<C-+>', '<C-o>:let g:neovide_transparency += 0.25<CR><C-o>:let g:neovide_transparency<CR>', {})
    -- Toggle fullscreen
    neomap("n", "<m-CR>", function()
        vim.g.neovide_fullscreen = vim.g.neovide_fullscreen == 1 and 0 or 1
    end, { desc = "Toggle fullscreen" })
elseif vim.g.goneovim then-- gonevim
    --不完美解决goneovim透明后,窗口不透明的问题,下面设置窗口不遮挡文本,如果值为100,纯透明会和文本重叠影响操作
    vim.opt.pumblend = 10
    vim.opt.winblend = 10
    neomap("n", "<m-CR>", ":GonvimMaximize<CR>", key_opts_ns)
    neomap("n", "<leader>rg", ":<C-U>e C:/Users/ThinkPad/AppData/Roaming/.goneovim/settings.toml<CR>", { desc = '[G]oneovim Config' })
elseif vim.g.nvy then-- nvy
else-- terminal
    -- vim.api.nvim_command("hi Normal guibg=NONE")
    -- vim.api.nvim_command("hi NonText guibg=NONE")
    -- vim.api.nvim_command("hi SignColumn guibg=NONE")
end
-- }}}







