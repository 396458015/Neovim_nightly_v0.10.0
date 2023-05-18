" Last Modified Date: 2023.04.24
" Desc              : NEOVIM 0.10.0(support Python, Lua)
"                          __
"  __  ____   __   __  __ /\_\    ___ ___     ____   ____
" |  \/  \ \ / /  /\ \/\ \\/\ \ /'' __` _`\  |  _ \ / ___|
" | |\/| |\ V /   \ \ \_/ |\ \ \/\ \/\ \/\ \ | |_) | |
" | |  | | | |     \ \___/  \ \_\ \_\ \_\ \_\|  _ <| |___
" |_|  |_| |_|      \/__/    \/_/\/_/\/_/\/_/|_| \_\\____|
" ========================================================

" {{{ Mapping
map ; :

noremap s <nop>
xmap s <nop>

nnoremap <Space> <nop>
nnoremap , <nop>
let g:mapleader = "\<Space>"
let g:maplocalleader = ","

" 显示list 用.表示空格
nnoremap <F3> :set list!<CR>
inoremap <F3> <C-o>:set list!<CR>
cnoremap <F3> <C-c>:set list!<CR>

" 高亮光标行列
nnoremap <silent> <F4> :set cuc! cul!<CR>

" x,c仅复制,不更改寄存器.(ps: d为剪切)
nnoremap          x          "_x
vnoremap          x          "_x
nnoremap          c          "_c
vnoremap          c          "_c
nnoremap          Y           y$
vnoremap          p          pgvy
vnoremap          P          Pgvy

" 单词的 选/改/删
nnoremap <silent> vi viw
nnoremap <silent> ci ciw
nnoremap <silent> di diw

" IDE like delete
inoremap <C-BS> <Esc>b"_dei

" 取消高亮
nnoremap <silent> <BS> :nohl<CR>

" Open Startify
nnoremap <silent> <leader>st :Startify<CR>

" 比较line
nnoremap <leader>dt :Linediff<CR>

" 插入时间
iab xtime <c-r>=strftime("20%y-%m-%d %a %H:%M")<CR>
iab xdate <c-r>=strftime("20%y-%m-%d (%a)")<CR>

" 代码折叠
nnoremap <silent> <Tab> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" zf                        --创建折叠,仅在manual/marker中有效(eg:v{motion}zf v{motion}指Shift+v)
" zd                        --删除折叠,仅在manual/marker中有效
" zD                        --删除嵌套折叠,仅在manual/marker中有效
" za                        --打开/关闭当前折叠
" zM                        --关闭所有折叠
" zR                        --打开所有折叠

" vimrc
nnoremap <silent> <leader>rc :edit $MYVIMRC<cr>
nnoremap <silent> <leader>rr :source $MYVIMRC<CR>

" spell checking
nnoremap <Leader>sc :set spell!<CR>

nnoremap <leader>sn ]s
nnoremap <leader>sp [s
nnoremap <leader>sa zg

" 显示单词拼写建议
nnoremap <leader>s? z=

" 光标移动
inoremap <m-h> <Left>
inoremap <m-j> <Down>
inoremap <m-k> <Up>
inoremap <m-l> <Right>

" INSERT Mode下使用光标移动一个单词
inoremap <C-h> <C-Left>
inoremap <C-l> <C-Right>

" ----------------- find and replace --------------
nnoremap <leader>z :%s/\<<C-R>=expand("<cword>")<CR>\>/<C-R>=expand("<cword>")<CR>/g<left><left>
vnoremap <leader>z :s///g<left><left><left>

" ----------------- make a list --------------
nnoremap <leader>b :put =range(,,1)<left><left><left><left>

" ----------------- Indentation -------------------
nnoremap < <<
nnoremap > >>

"---------------- 分屏快捷键设置 ----------------
nnoremap <silent> sh :set splitright<CR>:vsplit<CR>
nnoremap <silent> sj :set splitbelow<CR>:split<CR>
nnoremap <silent> st :set splitright<CR>:vsplit<CR>:Startify<CR>

" 互换分割窗口.Rotate screens
nnoremap <S-h> <C-w>b<C-w>H
" nnoremap srh <C-w>b<C-w>K

" 光标移动
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>
"nnoremap <C-j> <C-W><C-J>
"nnoremap <C-k> <C-W><C-K>

" terminal 分屏窗口移动,split navigations,smart way to move between windows
tnoremap <C-h> <C-w><C-h>
tnoremap <C-j> <C-w><C-j>
tnoremap <C-k> <C-w><C-k>
tnoremap <C-l> <C-w><C-l>

"---------------- 调整分屏尺寸 ----------------
nnoremap <silent>   <C-up>  :resize -3<CR>
nnoremap <silent>   <C-down>  :resize +3<CR>
nnoremap <silent>   <C-left>  :vertical resize +3<CR>
nnoremap <silent>   <C-right>  :vertical resize -3<CR>

" ----------- 支持Alt+n切换标签页 -----------
:nn <M-1> 1gt
:nn <M-2> 2gt
:nn <M-3> 3gt
:nn <M-4> 4gt
:nn <M-5> 5gt
:nn <M-6> 6gt
:nn <M-7> 7gt
:nn <M-8> 8gt
:nn <M-9> 9gt
:nn <M-0> :tablast<CR>

" Alt+左右键来移动标签顺序
nn <silent> <M-left> :if tabpagenr() == 1\|exe "tabm ".tabpagenr("$")\|el\|exe "tabm ".(tabpagenr()-2)\|en<CR>
nn <silent> <M-right> :if tabpagenr() == tabpagenr("$")\|tabm 0\|el\|exe "tabm ".tabpagenr()\|en<CR>

" 修改标签页的标题
set guitablabel=%{GuiTabLabel()}
function! GuiTabLabel()
    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)
    for bufnr in bufnrlist
        if getbufvar(bufnr, "&modified")
            let label = '+'
            break
        endif
    endfor
    let label .= v:lnum.': '
    let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
    if name == ''
        if &buftype=='quickfix'
            let name = '[Quickfix List]'
        else
            let name = '[No Name]'
        endif
    else
        let name = fnamemodify(name,":t")
    endif
    let label .= name
    let wincount = tabpagewinnr(v:lnum, '$')
    return label
endfunction

" -------------------- Buffer ---------------------
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"------------- Command Mode related ---------------
" Bash like keys for the command line
cnoremap <C-a>      <Home>
cnoremap <C-e>      <End>
" cnoremap <C-K>      <C-U>
cnoremap <C-h>      <C-Left>
cnoremap <C-l>      <C-Right>

cnoremap <m-h>      <left>
cnoremap <m-l>      <right>
cnoremap <m-j>      <down>
cnoremap <m-k>      <up>

cnoremap <C-j>      <down>
cnoremap <C-k>      <up>

" 在命令行粘贴的快捷键
cnoremap <C-V> <C-R>+

" $q is super useful when browsing on the command line
" it deletes everything until the last slash
" NORMAL Mode, Q                             --进入到Ex命令行模式
cno $q <C-\>eDeleteTillSlash()<CR>

function! DeleteTillSlash()
    let g:cmd = getcmdline()
    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif
    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif
    return g:cmd_edited
endfunc
" }}}

" {{{ Lazy.nvim
lua << EOF
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
--vim
  {
    "mg979/vim-visual-multi",
    keys = {
        {"<C-j>"},
        {"<C-k>"},
        {"<C-z>"},
        { "<C-n>", mode = { "n", "x" }, desc = "visual multi" },
    },
  },
  { "mbbill/undotree", cmd = "UndotreeToggle" },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
    vim.g.startuptime_tries = 10
    vim.keymap.set("n", "<F12>", ":StartupTime<CR>", { silent = true })
    end,
  },
  {
    "arecarn/vim-crunch",
    keys = {  "<Plug>(crunch-operator-line)","<Plug>(visual-crunch-operator)" },
  },
  {
    "terryma/vim-expand-region",
    keys = { "v", "<C-v>" },
    config = function()
    vim.keymap.set("v", "v", "<Plug>(expand_region_expand)", { silent = true })
    vim.keymap.set("v", "<C-v>", "<Plug>(expand_region_shrink)", { silent = true })
    end,
  },
  { "AndrewRadev/linediff.vim", cmd = {"Linediff", "LinediffAdd"} },
  {
    "alpertuna/vim-header",
    cmd = "AddHeader",
    config = function()
    vim.cmd[[
    let g:header_field_author = 'Max'
    let g:header_field_author_email = 'ismaxiaolong@gmail.com'
    let g:header_field_timestamp_format = '%Y.%m.%d'
    let g:header_field_modified_by = 0
    let g:header_field_license_id = ' '
    ]]
    end,
  },
  { "iqxd/vim-mine-sweeping", cmd = "MineSweep" },
  {
    "Yggdroot/LeaderF",
    cmd = { "LeaderfFile", "Leaderf", "LeaderfLine", "LeaderfMru" },
    config = function()
    vim.cmd[[
    let g:Lf_Ctags = "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/ctags.exe"
    let g:Lf_Rg = 'C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/rg.exe'

    let g:Lf_ShowDevIcons = 1
    let g:Lf_DevIconsFont = "Delugia Mono"

    let g:Lf_ReverseOrder = 1

    " don't show the help in normal mode
    let g:Lf_HideHelp = 1
    let g:Lf_UseCache = 0
    let g:Lf_UseVersionControlTool = 0
    let g:Lf_IgnoreCurrentBufferName = 1

    " popup mode
    let g:Lf_WindowPosition = 'popup'
    let g:Lf_PopupColorscheme = "leaderf_colorscheme_nightfox"
    " let g:Lf_PopupColorscheme = "Consistent with the current color scheme"

    " change color
    let g:Lf_PopupPalette = {
        \  'dark': {
        \      'Lf_hl_cursorline': {
        \                'guibg': '#364a82',
        \              },
        \      },
        \  }

    let g:Lf_WindowHeight = 0.9
    let g:Lf_PopupHeight = 0.7
    let g:Lf_PopupWidth = 0.4
    let g:Lf_PopupPosition = [7, 84]
    let g:Lf_PopupPreviewPosition = 'left'
    let g:Lf_PreviewCode = 1
    let g:Lf_PreviewInPopup = 1
    let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "Delugia Mono" }

    " BufTag和Function不自动预览,通过<C-p>预览.BufTag和Function默认是1.
    let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

    let g:Lf_ShowRelativePath = 0
    " 使用:LeaderfRg 路径不全, 搜索该录下经的文件.
    command! -bar -nargs=? -complete=dir LeaderfRg Leaderf! rg "" <q-args>

    let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
            \}
    ]]
    end,
   },
  { "voldikss/vim-floaterm", cmd = { "FloatermNew", "FloatermSend" } },
  { "iamcco/markdown-preview.nvim", ft = "markdown" },
  { "plasticboy/vim-markdown", ft = "markdown" },
  { "dhruvasagar/vim-table-mode", ft = {"markdown", "org"} },
  {
    "mhinz/vim-startify",
    cmd = "Startify",
  },
  {
    dir = "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/Local_Plugins/dashboard-nvim",
    event = 'BufWinEnter',
    config = function()
      require('dashboard').setup({
      theme = 'hyper',
      shortcut_type = 'number',
      config = {
        disable_move = false,
        week_header = { enable = true },
        packages = { enable = true },
        project = {
          enable = false,
        },
        shortcut = {
            {
              icon = ' ',
              desc = 'Recently files',
              group = 'Label',
              key= 'f',
              action = 'LeaderfMru'
            },
            {
              icon = ' ',
              desc = 'dotfiles',
              group = 'Number',
              action = "tabnew $MYVIMRC | tcd %:p:h",--tabnew;edit
              key = 'd',
            },
            {
              icon = ' ',
              desc = 'New File',
              group = 'Number',
              action = 'enew',
              key = 'i',
            },
            {
              icon = " ",
              desc = "Quit",
              group = 'Number',
              action = "qa",
              key = "q",
            },
        },
        mru = { limit = 15, icon = '📑 ', label = 'Recently Files' },
        --header ={
        --},
        --footer = {
        --  '',
        --  string.format('💘 %s', os.date('%H:%M %A %d %B %Y', relationship_start_time)),
        --  string.format('💞 %d days ago', os.difftime(os.time(), relationship_start_time) / (3600 * 24)),
        --  '',
        --},
        footer = {
            '',
            '',
            '',
        	  [[. ,-"-.   ,-"-. ,-"-.   ,-"-. ,-"-.   ,]],
        	  [[ X | | \ / | | X | | \ / | | X | | \ / ]],
        	  [[/ \| | |X| | |/ \| | |X| | |/ \| | |X| ]],
        	  [[   `-!-' `-!-"   `-!-' `-!-'   `-!-' `-]],
        },
      },
  	hide = {
  		statusline = true,
  		tabline = true,
  		winbar = true,
  	},
      })
    end,
  },
  { "wellle/targets.vim", keys = { "c", "d", "y", "v"} },
  { "chrisbra/csv.vim", ft = "csv" },
  {
    "ntpeters/vim-better-whitespace",
    event = "InsertEnter",
    config = function()
    vim.cmd[[
    let g:better_whitespace_guicolor='red'
    let g:strip_whitespace_on_save=0
    let g:better_whitespace_filetypes_blacklist=['startify', 'diff', 'gitcommit', 'unite', 'qf', 'help', 'dashboard']
    nnoremap <leader>si :StripWhitespace<CR>
    ]]
    end,
  },
  { "lfv89/vim-interestingwords", event = "BufReadPre" },
  {
    "markonm/traces.vim",
    event = "BufReadPre",
    config = function()
    vim.cmd[[
    let g:traces_normal_preview = 1
    let g:traces_num_range_preview = 1
    ]]
    end,
  },
  {
    "triglav/vim-visual-increment",
    event = "BufReadPre",
    config = function()
    vim.cmd[[
    set nrformats=alpha,octal,hex
    ]]
    end,
  },
  { "itchyny/vim-cursorword", event = "BufReadPre" },
  { "bronson/vim-visual-star-search", event = "BufReadPre" },
  --lua
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
            --return vim.fn.getbufvar(bufnr, '&modified') == 1 and '[+] ' or ''
            --return vim.fn.getbufvar(bufnr, '&modified') == 1 and '● ' or ''
            return vim.fn.getbufvar(bufnr, '&modified') == 1 and ' ' or ''
            --return vim.fn.getbufvar(bufnr, '&modified') == 1 and '🈚 ' or ''
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
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
    require("indent_blankline").setup {
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
    }
    end,
    opts = function()
    vim.g.indent_blankline_buftype_exclude = {
        "terminal",
        "nofile",
        "quickfix",
        "prompt",
    }
    vim.g.indent_blankline_filetype_exclude = {
        "help",
        "startify",
        "lspinfo",
        "dashboard",
        --"packer",
        --"neogitstatus",
        "NvimTree",
        "checkhealth",
    }
    end,
  },
  {
    "chentoast/marks.nvim",
    keys = "m" ,
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
        mappings = {
            delete_buf = "mc",
            toggle = "mm",
            prev = false -- pass false to disable only this default mapping
        }
    }
    end,
  },
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
          end,
        },
    },
    config = function()
    require("scrollbar").setup({
        handle = {
            color = '#abb2bf',
        },
        marks = {
            Cursor = {
                text = "•",
                color = 'black',
            },
        },
    })
    require("scrollbar.handlers.search").setup({})
    end,
  },
  {
    "b3nj5m1n/kommentary",
    event = "BufReadPre",
    config = function()
    require("kommentary")
    vim.g.kommentary_create_default_mappings = false
    vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>kommentary_line_increase", {})
    vim.api.nvim_set_keymap("x", "<leader>cc", "<Plug>kommentary_visual_increase", {})
    vim.api.nvim_set_keymap("n", "<leader>ci", "<Plug>kommentary_line_decrease", {})
    vim.api.nvim_set_keymap("x", "<leader>ci", "<Plug>kommentary_visual_decrease", {})
    end,
  },
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
    end,
    opts = function()
    require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style = "rounded",
        filesystem = {
            follow_current_file = true,
            use_libuv_file_watcher = true,
            hijack_netrw_behavior = "open_current",
        },
        default_component_configs = {
          indent = {
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
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
  },
  { "Vonr/align.nvim", event = "BufReadPre" },
  { "kylechui/nvim-surround",
    keys = {
           { mode = "n", "ys" },
           { mode = "n", "cs" },
           { mode = "n", "ds" },
           { mode = "i", "<C-g>" },
           { mode = "x", "S" },
    }, --S, dss, css
    config = function()
    require("nvim-surround").setup()
    end,
  },
  --motion
  {
    "ggandor/leap.nvim",
    keys = {"r", "R", "gr"},
    config = function()
    require('leap').opts.highlight_unlabeled_phase_one_targets = true
    vim.keymap.set({'x', 'o', 'n'}, 'r', '<Plug>(leap-forward-to)')
    vim.keymap.set({'x', 'o', 'n'}, 'R', '<Plug>(leap-backward-to)')
    vim.keymap.set({'x', 'o', 'n'}, 'gr', '<Plug>(leap-cross-window)')
    end,
  },
  {
    "ggandor/flit.nvim",
    keys = {"f", "F", "t", "T"},
    config = function()
    require('flit').setup {
        keys = { f = 'f', F = 'F', t = 't', T = 'T' },
        labeled_modes = "v",
        multiline = true,
        opts = {}
    }
    end,
  },
  --colorscheme
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
          visual = false,       --default is true
          search = false,
        },
        modules = {
          nvimtree = true,
          cmp = true,
          telescope = true,
          treesitter = true,
          whichkey = true,
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
        sel1    = "#228b22", --visual Selected
      },
      duskfox   = {
        white   = "#abb2bf",
        fg1     = "#b2b2b2",
        comment = "#5c6370",
        sel0    = "#364a82", --visual
        sel1    = "#228b22", --visual Selected
      },
      terafox   = {
        white   = "#abb2bf",
        fg1     = "#b2b2b2",
        comment = "#5c6370",
        sel0    = "#364a82", --visual
        sel1    = "#228b22", --visual Selected
      },
      nordfox   = {
        white   = "#abb2bf",
        fg1     = "#b2b2b2",
        comment = "#5c6370",
        sel0    = "#364a82", --visual
        sel1    = "#228b22", --visual Selected
      },
      carbonfox = {
        white   = "#abb2bf",
        fg1     = "#b2b2b2",
        comment = "#5c6370",
        sel0    = "#364a82", --visual
        sel1    = "#228b22", --visual Selected
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
  --Telescope
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
  },
  --notes
  {
    "nvim-orgmode/orgmode",
    ft = "org",
    dependencies = {
        {"nvim-treesitter/nvim-treesitter"},
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
                  headlines = {"◉", "◎", "○", "✺", "▶", "⤷" }, --neorg level1:◉⦿
                  --headlines = { "◉", "○", "✸", "✿" },        --orgmode
                  --headlines = {"🌸","🌱","💧","✨","💗" },   --others
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
       org_agenda_files = {'C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/Org/**'},
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
  },
  --treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { 'BufReadPost', 'BufNewFile' },
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
      --yati = { enable = true },  -- treesitter indent plugin
      rainbow = {
          enable = true,
          query = {
             'rainbow-parens',
          },
          extended_mode = true,
          strategy = rainbow.strategy.global,
      },
    }
    --matlab syntax highlighting
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.matlab = {
        install_info = {
            url = "https://github.com/mstanciu552/tree-sitter-matlab.git",
            files = { "src/parser.c" },
            branch = "main",
        },
        filetype = "matlab",
    }
    end,
  },
  --cmp
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
            require('lspkind').presets['default']['Constructor']   =''
            require('lspkind').presets['default']['Field']         ='⌘'
            require('lspkind').presets['default']['Interface']     ='ﰮ'
            require('lspkind').presets['default']['Unit']          =''
            require('lspkind').presets['default']['Snippet']       ='✂️'
            require('lspkind').presets['default']['Reference']     =''
            require('lspkind').presets['default']['Struct']        =''
            require('lspkind').presets['default']['Event']         =''
            require('lspkind').presets['default']['TypeParameter'] =''
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
        nvim_lsp = '[LSP]',
        path = '[PATH]',
        luasnip = '[SNIP]',
        buffer = '◉[BUF]',
        calc = '[CALC]',
        emoji = '[EMOJI]',
        cmp_matlab = '[MAT]',
        dictionary = '📑[Dict]',
        treesitter = '🌲[TS]',
        cmp_tabnine = '[T9]',
        orgmode = '[Org]',
        --latex_symbols = '[TEX]',
        --nuspell = '[SPELL]',
        --spell = '[SPELL]',
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
            completion = cmp.config.window.bordered(),
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
                require('cmp_tabnine.compare'),
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.score,
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
            fields = { "abbr", "kind", "menu" },
              --fields = { "kind", "abbr", "menu" },
          	format = function(entry, vim_item)
           		--vim_item.kind = lspkind.symbolic(vim_item.kind, {mode = "symbol"})
                vim_item.kind = string.format('%s %s', lspkind.symbolic(vim_item.kind, {mode = "symbol"}), vim_item.kind)
           		vim_item.menu = source_mapping[entry.source.name]
           		if entry.source.name == "cmp_tabnine" then
                    local detail = (entry.completion_item.labelDetails or {}).detail
           			vim_item.kind = ""
           			if detail and detail:find('.*%%.*') then
           				vim_item.kind = vim_item.kind .. ' ' .. detail
           			end
           			if (entry.completion_item.data or {}).multiline then
           				vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
           			end
           		end
           		local maxwidth = 80
           		vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
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
            { name = "cmp_tabnine" },
            { name = "orgmode" },
            --{ name = "latex_symbols" },
        })
    }
    end,
  },
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
  { "saadparwaiz1/cmp_luasnip", event = "InsertEnter", dependencies = { "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip" } },
  {
    "tzachar/cmp-tabnine",
    build = "powershell ./install.ps1",
    lazy = true,
    dependencies = "hrsh7th/nvim-cmp",
    config = function()
    local tabnine = require('cmp_tabnine.config')
    tabnine:setup({
      	max_lines = 1000,
      	max_num_results = 20,
      	sort = true,
      	run_on_every_keystroke = true,
      	snippet_placeholder = '..',
      	ignored_file_types = {
      		org = true,
      		markdown = true,
      	},
      	show_prediction_strength = false
    })
    end,
  },
  --lsp,
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
    local lsp_list = { "pylsp", "vimls" }
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
    vim.keymap.set('n', '<F6>', toggle_diagnostics)
    vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
    --vim.api.nvim_set_keymap('n', '<leader>d[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
    --vim.api.nvim_set_keymap('n', '<leader>d]', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
    --vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end -- 取消代码诊断信息显示
    end,
  },
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
     --hint_prefix = "🐼 ",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
     --hint_prefix = " ",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
     hint_prefix = "🤔 ",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
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
  --Snippets,
  { "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    config = function()
    require("luasnip/loaders/from_vscode").lazy_load({ paths = {"C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/friendly-snippets"}})
    end,
  },
  --Local plugins
  { dir = "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/Local_Plugins/vim-speeddating-master", ft = {"markdown", "org"} }, --modified
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
            disabled_filetypes = {'NvimTree'},
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
                    --dashboard = 'Dashboard',
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
    end
    end,
  }, --modified
  {
    dir = "C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/Local_Plugins/weather3day.nvim-main", --modified
    cmd = "Weather3day",
    init = function()
    vim.g.weather_city = "Xi'an"--weather3day plug
    end,
  },
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
    f = {
        name = "Telescope",
        s = {"Search History" },
        c = {"Command History" },
        b = {"CWD File" },
        p = {"Fuzze Word" },
        l = {"Word Line" },
        f = {"File Browser" },
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
    ['r'] = {
        name = 'VIMRC & Snippets',
        ['c'] = {'Edit VIMRC' },
        ['r'] = {'Reload VIMRC' },
        ['m'] = {'Matlab-Snippets' },
        ['o'] = {'Org-Snippets' },
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

    local s_all = require('which-key')
    s_all.register({
    ['h'] = {'Vsplit'},
    ['j'] = {'Split'},
    ['t'] = {'Vsplit-Startify'},
    }, { prefix = 's' })

    local m_all = require('which-key')
    m_all.register({
    ['m'] = {'Toggle Sig'},
    ['c'] = {'Clear Sig'},
    }, { prefix = 'm' })

    local LL_others = require('which-key')
    LL_others.register({
    f = {
        name = "LeaderF",
        b = {"Open File" },
        c = {"Colorscheme" },
        f = {"Function" },
        l = {"Word Line" },
        p = {"Fuzze Word" },
        },
    ['t'] = {'Tag'},
    w = {
        name = "Weather Forecast",
        d = {"3 day" },
        e = {"1 day" },
        },
    }, { prefix = ',' })
    end,

  },
})
EOF
" }}}

" {{{ 编码格式
if has('multi_byte')
    set encoding=utf-8
    set termencoding=utf-8
    set fileencoding=utf-8
    set fileencodings=utf-8,gbk,gb18030,big5,ucs-bom,euc-jp,latin1
endif

" 解决vim编辑matlab文件保存后, matlab中文为乱码的问题
augroup matlab_filetype
    autocmd!
    autocmd FileType matlab set fileencoding=cp936
augroup END
" }}}

" {{{ 字体/字号
if exists('g:neovide') || exists('g:nvy')
    " set guifont=Delugia\ Mono:h15.5                   " Nerd Font (Cascadia Code)
    set guifont=Delugia\ Mono:h11.6                   " Nerd Font (Cascadia Code)
    " set guifont=CodeNewRoman\ NFM:h12                " Nerd Font
    " set guifont=OperatorMono\ NF:h12                 " Nerd Font
    " set guifont=ComicMono\ NF:h12                    " Nerd Font
    set guifontwide=inconsolatago\ qihei\ nf:h12.5      " 中文 Nerd Font
else
    set guifont=Delugia\ Mono:h12.1                    " Nerd Font (Cascadia Code)
    " set guifont=CodeNewRoman\ NFM:h12                " Nerd Font
    " set guifont=OperatorMono\ NF:h12                 " Nerd Font
    " set guifont=ComicMono\ NF:h12                    " Nerd Font
    set guifontwide=inconsolatago\ qihei\ nf:h12.5      " 中文 Nerd Font
endif
" }}}

" {{{ 常规设置
" 高亮
syntax enable                        " 打开语法高亮
syntax on                            " 开启文件类型侦测
syntax sync minlines=64
if &bg == 'dark'
    hi CursorLine gui=NONE guibg=#3C4452
elseif &bg == 'light'
    hi CursorLine gui=NONE guibg=#c6cbd9
endif

language en
language messages zh_CN.utf-8        " 解决consle提示信息输出乱码
filetype on                          " 侦测文件类型
filetype indent on                   " 针对不同的文件类型采用不同的缩进格式
filetype plugin on                   " 针对不同的文件类型加载对应的插件
filetype plugin indent on

set autoindent                       " 自动对齐
set tabstop=4                        " 设置tab键的宽度
set softtabstop=4                    " 退格键的长度
set expandtab                        " 在输入tab后,vim用个空格来填充这个tab
set lazyredraw                       " 延时绘制(提升性能)
set shortmess-=S

" set wildmode=list:longest,full       " Command <Tab> completion, list matches
set wildmode=longest,full            " Command <Tab> completion, list matches
set wildmenu                         " enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~          " stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

set laststatus=2                     " 开启状态栏信息
set cmdheight=1                      " 命令行的高度,默认为1,这里设为2
set linebreak                        " 整词换行
set backspace=2                      " 设置退格键可用
set backspace=indent,eol,start
set shiftwidth=4                     " 换行时行间交错使用4个空格
set cindent shiftwidth=4             " 自动缩进4空格
set smartindent                      " 智能自动缩进
set ai!                              " 设置自动缩进
set nu!                              " 显示行号
set showmatch                        " 显示括号配对情况
set mouse=a                          " 启用鼠标
set ruler                            " 右下角显示光标位置的状态行
set hlsearch                         " 开启高亮显示结果
set incsearch                        " 开启实时搜索功能
set ignorecase                       " 忽略大小写
set smartcase
" set nowrapscan                     " 搜索到文件两端时不重新搜索
set vb t_vb=                         " 关闭提示音
set guicursor+=a:blinkon0            " 设置光标不闪烁
set hidden                           " 允许在有未保存的修改时切换缓冲区
set winaltkeys=no                    " 设置 alt 键不映射到菜单栏
set scrolloff=5                      " 设置目标行与顶部底部的距离(5行)
set writebackup                      " 设置无备份文件
set nobackup
set autochdir                        " 设定文件浏览器目录为当前目录
set wrap                             " 设置一行太长,自动换行
" set norelativenumber                 " 不显示相对行号
set relativenumber                   " 显示相对行号
set showcmd
set formatoptions+=m                 " 如遇Unicode值大于255的文本,不必等到空格再折行
set formatoptions+=B                 " 合并两行中文时,不在中间加空格
set whichwrap+=<,>,h,l               " 允许backspace和光标键跨越行边界
set magic                            " For regular expressions turn magic on

" Fold
set foldmethod=marker                " 折叠类型---对文中标志折叠
" set foldmethod=manual              " 折叠类型---手工
" set foldmethod=syntax              " 折叠类型---语法高亮
" set foldmethod=indent              " 折叠类型---缩进
set foldcolumn=2                     " 显示折叠标志
set foldlevel=33
" set foldcolumn&                    " 去掉折叠标志

" 分屏设置
set splitright                       " 新的窗口在右边打开
set splitbelow                       " 新的窗口在下边打开

" set listchars=tab:\|\ ,                                          " 显示Tab符,使用一高亮竖线代替
set listchars=trail:.,extends:>,precedes:<,space:.               " 将空格用.表示
" set listchars=eol:¬,tab:>·,trail:.,extends:>,precedes:<,space:␣  " <F3>为显示空格的开关

" IOS:Windows  设置 clipboard 提高Nvim启动速率
set clipboard+=unnamed               " 公用剪切板
let g:clipboard = {
            \ 'name': 'win32yank',
            \ 'copy': {
                \ '+': 'win32yank.exe -i --crlf',
                \ '*': 'win32yank.exe -i --crlf',
                \ },
                \ 'paste': {
                    \ '+': 'win32yank.exe -o --lf',
                    \ '*': 'win32yank.exe -o --lf',
                    \ },
                    \ 'cache_enabled': 0,
                    \ }

" ENV-Python
let g:python_host_prog  = "C:/Python/Python311/python.exe"
let g:python3_host_prog = "C:/Python/Python311/python.exe"
let $PYTHONUNBUFFERED=1              " 禁用python stdout缓冲

augroup python_related
    autocmd!
    autocmd BufNewFile,BufRead *.py set fileformat=unix     " 以unix格式存储文件,避免在推送到GITHUB或分享给其他用户时出现文件转换问题.
    autocmd BufNewFile,BufRead *.rpy set syntax=python
augroup END

" 禁止屏闪和铃声
augroup genconfiggroup
    autocmd!
    autocmd GUIEnter * set vb t_vb=
    autocmd VimEnter * set vb t_vb=
augroup END

augroup tex_md_width
    autocmd!
    autocmd FileType tex set textwidth=72         " 文本超过一定长度时自动换行
    autocmd FileType markdown set textwidth=80    " 文本超过一定长度时自动换行
augroup END

augroup line_font
    autocmd!
    " 高亮加下划线显示每行第80个字符
    au BufRead,BufNewFile *.asm,*.c,*.cpp,*.java,*.cs,*.sh,*.lua,*.pl,*.pm,*.py,*.rb,*.hs,*.vim,*.md 2match Underlined /.\%81v/
    " Fortran语言,高亮加下划线显示每行第72个字符(遵循Fortran77固定格式)
    au BufRead,BufNewFile *.for 2match Underlined /.\%73v/
augroup END

" Return to last edit position when opening files (You want this!)
lua << EOF
vim.cmd([[ autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]])
EOF

" 当剩余的窗口都不是文件编辑窗口时,自动退出vim
augroup Buffer_quit
    autocmd!
    autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif
augroup END

" Highlihgt yank
set background=light " 放到这里的目的,为了tokyonight-day显示复制颜色(HighlightedyankRegion)
highlight HighlightedyankRegion ctermbg=237 guibg=#c34043
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="HighlightedyankRegion", timeout=120}
augroup END
" }}}

" {{{ 中/英输入法切换
augroup input_switching
    autocmd!
    autocmd VimEnter * :silent :!C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/im-select.exe 1033
    autocmd InsertLeave * :silent :!C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/im-select.exe 1033
    autocmd VimLeave * :silent :!C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/im-select.exe 1033
    " autocmd InsertEnter * :silent :!C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/im-select.exe 2052
augroup END
" }}}

" {{{ Random colorscheme
lua << EOF
random_color = {
--    'tokyonight-day',
--    'dayfox',
    'duskfox',
    'terafox',
    'nordfox',
    'nightfox',
    'nightfox',
    'nightfox',
    'nightfox',
    'nightfox',
}
math.randomseed(os.time())
local mycolor = random_color[math.random(table.getn(random_color))]
vim.cmd('colorscheme ' .. mycolor)
EOF
" }}}

" {{{ Highlihgt Diff
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=bold guifg=bg guibg=#87af87 " 新增的行
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=bold guifg=bg guibg=#86abdc " 删除的行
highlight DiffChange cterm=none ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=#8787af " 变化的行
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=bold guifg=bg guibg=#f7768e " 变化的文字
" }}}

" ----------------------- Plugins Config -----------------------
" {{{ << Plugin - Undotree >>
let g:undotree_DiffAutoOpen = 1
nnoremap <silent> <leader>u :UndotreeToggle<cr>
set undodir=C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/undodir
set undofile
" }}}

" {{{ << vim-visual-multi >>
augroup visual_multi_yank
    autocmd!
    autocmd User visual_multi_mappings nmap <buffer> <leader>y "+y
augroup END

let g:VM_theme                      = 'iceblue'
let g:VM_highlight_matches          = 'underline'
let g:VM_maps                       = {}
let g:VM_maps['Find Under']         = '<C-n>'
let g:VM_maps['Find Subword Under'] = '<C-n>'
let g:VM_maps['Select All']         = '<C-z>'
" let g:VM_maps['Select h']           = '<C-Left>'
" let g:VM_maps['Select l']           = '<C-Right>'

let g:VM_maps['Add Cursor Up']      = '<C-k>'
let g:VM_maps['Add Cursor Down']    = '<C-j>'

" let g:VM_maps['Add Cursor At Pos']  = '<C-x>'
" let g:VM_maps['Add Cursor At Word'] = '<C-w>'
" let g:VM_maps['Remove Region']      = 'q'
" }}}

" {{{ text objects  << targets.vim >>
" add '<>' in block
autocmd User targets#mappings#user call targets#mappings#extend({
    \ 'b': {
        \'pair': [
            \{'o':'(', 'c':')'},
            \{'o':'[', 'c':']'},
            \{'o':'{', 'c':'}'},
            \{'o':'<', 'c':'>'},
        \ ]
    \},
\})
" d/c/y  +  i/I/a/A  +  b               (默认为n向右搜索)
" d/c/y  +  i/I/a/A  +  a               (默认为n向右搜索)
" d/c/y  +  i/I/a/A  +  q               (默认为n向右搜索)
" d/c/y  +  2/3/4/...(可省略)  +  i/I/a/A  +  n/l(可省略)  +  b
" d/c/y  +  2/3/4/...(可省略)  +  i/I/a/A  +  n/l(可省略)  +  a
" d/c/y  +  2/3/4/...(可省略)  +  i/I/a/A  +  n/l(可省略)  +  q
" d/c/y  +  i/I/a/A  +  (/[/,/...
" d/c/y  +  i/I/a/A  +  "/'/`/...
" --b:block   q:quote    a:argument
" }}}

" {{{ Compiler code & Python & REPL & Matlab & Fortran << floaterm && REPL >>
hi FloatermBorder guibg=#3e4452 guifg=#5c6370
let g:floaterm_autoclose=0
let g:floaterm_keymap_kill = '<C-q>'
let g:floaterm_keymap_next = '<leader>tn'

nnoremap  <leader>to  :FloatermNew<CR>
nnoremap  <leader>tt  :FloatermToggle<CR>
tnoremap <Esc> <C-\><C-n>
" tnoremap  <leader>tt  <C-\><C-n>:FloatermToggle<CR>

" SumatraPdf open pdf
nnoremap <A-o> :FloatermNew SumatraPdf <C-r><C-l><CR>

" TOOl rg
nnoremap <leader>tr :FloatermNew<CR>rg.exe<Space>

augroup Compiler_code
    autocmd!
    autocmd FileType floaterm nnoremap <buffer> <Esc> :q<CR>
    " -- Python --
    autocmd FileType python nnoremap <C-CR> :FloatermNew py "%:p"<CR>
    autocmd FileType python noremap! <C-CR>  <Esc>:FloatermToggle<CR>
    " autocmd FileType python tnoremap <C-CR>  <C-\><C-n>:FloatermToggle<CR>
    " -- Python REPL --
    nnoremap <leader>tp :FloatermNew --width=0.5 --wintype=vsplit --name=repl --position=rightbelow ipython<CR>
    autocmd FileType python nnoremap <leader>w :FloatermSend<CR>
    autocmd FileType python vnoremap <leader>w :FloatermSend<CR>
    " -- Matlab --
    autocmd FileType matlab nnoremap <silent><C-CR> :! matlab -nosplash -nodesktop -r %:r<CR><CR>
    " TERMINAL运行matlab代码,以'test.m'代码为例 'matlab -nosplash -nodesktop -r test'
    " -- Fortran --
    autocmd FileType fortran nnoremap <C-CR> :FloatermNew<CR>compilervars.bat intel64<CR>ifort<Space>
    " -- Typst --
    " highligth file 'D:\Program Files\Neovim\share\nvim\runtime\syntax\typst.vim'
    autocmd BufRead,BufNewFile *.typ setlocal filetype=typst
    autocmd FileType typst nnoremap <C-CR> :FloatermNew --height=1.0 typst watch %:p<CR>
    autocmd FileType typst command! TypstPDF execute "FloatermNew! sumatrapdf %:p<C-h><C-h><C-h>pdf<CR>"
augroup END

" Git
command! Push execute "FloatermNew!git add init.vim<CR>git commit --allow-empty-message -m \"\"<CR>git push<CR>"
command! Pull execute "FloatermNew!git fetch --all<CR>git reset --hard origin/main<CR>"
command! Gitlog execute "FloatermNew!git log --all --oneline --graph<CR>"

" Administrator CMD mode
nnoremap  <leader>ta  :FloatermNew<CR>runas /user:ThinkPad\Administrator cmd<CR>1234<CR>
" nnoremap  <leader>ta  :FloatermNew<CR>runas /user:administrator cmd<CR>1234<CR>
" 'runas /user:administrator cmd' 进入管理员CMD的前提是开启管理员账号
" 开启管理员账号: net user administrator /active:yes
" 关闭管理员账号: net user administrator /active:no
" 设置管理员密码(1234): net user administrator 1234
" }}}

" {{{ << Plugin - startify >>
let g:startify_files_number = 16  " 起始页显示的列表长度

let g:startify_bookmarks            = [
            \ '~/bookmarks',
            \]
let g:startify_custom_footer = [
            \ '                                                                   ',
            \ '                                                                   ',
            \ '                                                                   ',
            \ '                                                                   ',
            \ '                                                                   ',
            \ '                                                                   ',
            \ '                                                                   ',
            \ '                                                                   ',
            \ '                                                                   ',
            \ '                                                                   ',
            \ '                                                                   ',
            \ '                                                                   ',
            \ '                                                                   ',
            \ '                                                                   ',
            \ '                                                                   ',
            \ '                                                                   ',
            \ '                                                                   ',
            \ '                                                                   ',
            \ '                                                                   ',
            \ '            ,                                                      ',
            \ '           / \,,_  ."|                                             ',
            \ '         [[| /]]]]/_."                                             ',
            \ '       ]]]]` "[["  ".                                              ',
            \ '     [[[[[    _   ;, \                                             ',
            \ '  ,]]]]]]    /o`\  ` ;)                                            ',
            \ ' [[[[[[   /           (                                            ',
            \ ' ]]]]]]   |            \         _____________________________     ',
            \ '[[[[[[[[   \            \       /                             \    ',
            \ ']]]]]]]]]   ".__      _  |     /                               \   ',
            \ '[[[[[[[[       /`._  (_\ /     |     Still waters run deep!     |  ',
            \ ' ]]]]]]"      |    //___/   --=:                                |  ',
            \ ' `[[[[`       |     `--`       |                                |  ',
            \ '  ]]]`                          \______________________________/   ',
            \ '                                                                   ',
            \ '                                                                   ',
            \ '                                                                   ',
            \]

highlight StartifyBracket ctermfg=10 guifg=#444B6A
highlight StartifyNumber ctermfg=10 guifg=#FF9E64

if &background ==# 'dark'
    highlight StartifyFile ctermfg=10 guifg=#9ECE6A
elseif &background ==# 'light'
    highlight StartifyFile ctermfg=10 guifg=#12970e
endif

highlight StartifyPath ctermfg=10 guifg=#786591
highlight StartifySlash ctermfg=10 guifg=#786591
highlight StartifySection ctermfg=10 guifg=#7AA2F7
highlight StartifyHeader ctermfg=10 guifg=#8687b0
highlight StartifyFooter ctermfg=10 guifg=#F7768E
highlight StartifySpecial ctermfg=10 guifg=#444B6A

" show startify icon
lua << EOF
function _G.webDevIcons(path)
  local filename = vim.fn.fnamemodify(path, ':t')
  local extension = vim.fn.fnamemodify(path, ':e')
  return require'nvim-web-devicons'.get_icon(filename, extension, { default = true })
end
EOF
function! StartifyEntryFormat() abort
  return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
endfunction
" }}}

" {{{ MarkDown Preview - << Plugin - iamcco/markdown-preview.nvim >> (需安装:nodejs 和 yarn)
" 安装nodejs 和 yarn. 若不能预览markdown(通过:mess查看,有vim-node-rpc error)
" 解决途径:通过系统 CMD 到该插件 app 目录下(\Vim\vimfiles\bundle\iamcco markdown-preview.nvim\app)执行 yarn install 即可使用.
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
            \ 'mkit': {},
            \ 'katex': {},
            \ 'uml': {},
            \ 'maid': {},
            \ 'disable_sync_scroll': 0,
            \ 'sync_scroll_type': 'middle',
            \ 'hide_yaml_meta': 1,
            \ 'sequence_diagrams': {}
            \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'

augroup markdown_preview
    autocmd!
    autocmd FileType markdown nnoremap <C-CR> <Plug>MarkdownPreview
augroup END

" 设置预览代码高亮(绝对路径)
" let g:mkdp_highlight_css = 'C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/markdown_highlight_solarized_dark.css'
let g:mkdp_highlight_css = 'C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/markdown.css'
let g:mkdp_markdown_css = 'C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/github-markdown.css'
" }}}

" {{{ MarkDown Plugins - << plasticboyvim-markdown >> << markdown-toc >> << table-mode >> << Plugin - icebreaker gustav >> << Pangu >>
" << Plugin - plasticboyvim - markdown >>
augroup markdown_type
    autocmd!
    " autocmd FileType markdown nnoremap <leader>to :Toc<CR>
    autocmd FileType markdown setl conceallevel=2
augroup END
let g:vim_markdown_toc_autofit = 1                 " Enable TOC window auto-fit,调节合适的窗口尺寸

let g:vim_markdown_conceal = 0                     " 取消隐藏 Markdown          语法符号
let g:vim_markdown_conceal_code_blocks = 0         " 取消隐藏 代码块            符号 ```
let g:tex_conceal = ""                             " 取消隐藏 LaTeX math syntax 符号

let g:vim_markdown_math = 1                        " 高亮显示 LaTeX math
let g:vim_markdown_strikethrough = 1               " 划线文本显示,由 ~~xx~~ 变为 划线~~xx~~划线

let g:vim_markdown_new_list_item_indent = 2        " *item1 *item2 缩进距离为2(默认是4).
let g:vim_markdown_auto_insert_bullets = 0

let g:vim_markdown_folding_disabled = 1            " 取消 markdown 折叠
"let g:vim_markdown_no_default_key_mappings = 1    " 取消默认按键映射

let g:vim_markdown_fenced_languages = [
            \ 'c++=cpp',
            \ 'viml=vim',
            \ 'bash=sh',
            \ 'ini=dosini',
            \ 'js=javascript',
            \ 'json=javascript',
            \ 'jsx=javascriptreact',
            \ 'tsx=typescriptreact',
            \ 'docker=Dockerfile',
            \ 'makefile=make',
            \ 'py=python'
            \ ]
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_edit_url_in = 'vsplit'       " tab  vsplit  hsplit  current

let g:vim_markdown_folding_disabled = 0         " 开启折叠功能
let g:vim_markdown_folding_style_pythonic = 1   " 折叠样式
let g:vim_markdown_folding_level = 1            " n级不自动折叠
" let g:vim_markdown_override_foldtext = 0

" << Plugin - table-mode >>
augroup markdown_table
    autocmd!
    au FileType markdown let g:table_mode_corner = '|'
    au FileType markdown let g:table_mode_delimiter = ' '
    au FileType markdown let g:table_mode_verbose = 0
    au FileType markdown let g:table_mode_auto_align = 0
    autocmd FileType markdown TableModeEnable
augroup END
" }}}

" {{{ 计算器 << Plugin - arecarn/crunch >>
nmap <leader>, <Plug>(crunch-operator-line)
xmap <leader>, <Plug>(visual-crunch-operator)
" }}}

" {{{ 作者信息 << Plugin - header >>
nnoremap <F2> :AddHeader<CR>
" }}}

" {{{ lfv89/vim-interestingwords
nnoremap <silent> <leader>k :call InterestingWords('n')<cr>
vnoremap <silent> <leader>k :call InterestingWords('v')<cr>
nnoremap <silent> <leader>K :call UncolorAllWords()<cr>
" }}}

" ------------- require Python support vim Plugins -------------
" {{{ << Plugin - LeaderF >>
" 安装 C extension, 速度提高10倍
" :LeaderfInstallCExtension

" 文件搜索
nnoremap <silent> <localleader>fb :LeaderfFile :/<left><left>
" 模糊搜索,很强大的功能,迅速秒搜
nnoremap <silent> <localleader>fp :Leaderf rg<CR>
" 关键字搜索(仅当前文件里)
nnoremap <silent> <localleader>fl :LeaderfLine<CR>
" 变量搜索(仅当前文件里)
nnoremap <silent> <localleader>t :Leaderf bufTag<CR>
" 函数搜索(仅当前文件里)
nnoremap <silent> <localleader>ff :Leaderf function<CR>
" 配色搜索
nnoremap <silent> <localleader>fc :Leaderf colorscheme<CR>
" }}}

" ===================== NEOVIM lua Plugins =====================

" {{{ lua-Plugins mapping & color
lua << EOF
-- mapping
--{{{ hlslens
vim.cmd[[nnoremap <leader>/ /\<<C-R>=expand("<cword>")<CR>\><left><left>]]
-- }}}

--{{{ screach << Telescope >>
--vim.keymap.set("n", "<leader>fp", ":Telescope file_browser<cr>", { silent = true })
vim.keymap.set("n", "<leader>ff", ":Telescope file_browser path=:/<left><left>", { silent = true })
vim.cmd[[nnoremap <silent> <leader>fb :lua require("telescope.builtin").find_files({layout_strategy="vertical"})<cr>]]
vim.keymap.set("n", "<leader>fp", ":Telescope current_buffer_fuzzy_find<cr>", { silent = true })
vim.keymap.set("n", "<leader>fl", ":Telescope live_grep<cr>", { silent = true })
vim.keymap.set("n", "<leader>fc", ":Telescope command_history<cr>", { silent = true })
vim.keymap.set("n", "<leader>fs", ":Telescope search_history<cr>", { silent = true })
--}}}

--{{{ tree << neo-tree >>
vim.keymap.set("n", "<leader>.", ":Neotree dir=:/<left><left>", { silent = true })
--}}}

--{{{ marks << nvim-marks >>
vim.keymap.set("n", "<C-m>", "<Plug>(Marks-next)", { silent = true })
vim.keymap.set("n", "<S-m>", "<Plug>(Marks-prev)", { silent = true })
--}}}

--{{{ luasnip & snippets
vim.keymap.set("n", "<leader>rm", ":<C-U>e C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/friendly-snippets/snippets/add_snippets/matlab.json<CR>", { silent = true })
--}}}

--{{{ weather << nvim-weather >> << nvim-weather3day >>
vim.keymap.set("n", "<localleader>we", ":Weather<CR>", { silent = true })
vim.keymap.set("n", "<localleader>wd", ":Weather3day<CR>", { silent = true })
--}}}

--{{{ << Org >>
vim.keymap.set("n", "<leader>ss", ":NvimTreeOpen C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/Org/<CR>", { silent = true })
vim.keymap.set("n", "<leader>ro", ":<C-U>e C:/Users/ThinkPad/AppData/Local/nvim-data/Maxl/friendly-snippets/snippets/org.json<CR>", { silent = true })
--}}}

--{{{ << Plugin - Vonr/align.nvim >>
local NS = { noremap = true, silent = true }
--vim.keymap.set('x','<leader>aa',function()require'align'.align_to_char(1,true)end,NS)--Alignsto1character,lookingleft
--vim.keymap.set('x','<leader>as',function()require'align'.align_to_char(2,true,true)end,NS)--Alignsto2characters,lookingleftandwithpreviews
vim.keymap.set('x','<leader>a',function()require'align'.align_to_string(false,true,true)end,NS)--Alignstoastring,lookingleftandwithpreviews
--vim.keymap.set('x','<leader>ar',function()require'align'.align_to_string(true,true,true)end,NS)--AlignstoaLuapattern,lookingleftandwithpreviews
--}}}

-- color
--{{{  hlslens clolr
vim.cmd[[
hi default link HlSearchNear IncSearch
hi default link HlSearchLens WildMenu
hi default link HlSearchLensNear IncSearch
hi default link HlSearchFloat IncSearch
hi IncSearch guibg=#d73a4a
hi IncSearch guifg=black
]]
--}}}

--{{{ cmp color
vim.api.nvim_command("highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080")
vim.api.nvim_command("highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6") --Abbr
vim.api.nvim_command("highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch")
vim.api.nvim_command("highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE") --Variable
vim.api.nvim_command("highlight! link CmpItemKindInterface CmpItemKindVariable")
vim.api.nvim_command("highlight! link CmpItemKindText CmpItemKindVariable")
vim.api.nvim_command("highlight! CmpItemKindFunction guibg=NONE guifg=#9d79d6") --Function
vim.api.nvim_command("highlight! link CmpItemKindMethod CmpItemKindFunction")
vim.api.nvim_command("highlight! CmpItemKindKeyword guibg=NONE guifg=#63cdcf") --Keyword
vim.api.nvim_command("highlight! link CmpItemKindProperty CmpItemKindKeyword")
vim.api.nvim_command("highlight! link CmpItemKindUnit CmpItemKindKeyword")
vim.api.nvim_command("highlight! CmpItemKindSnippet guibg=NONE guifg=#d64f44") --Snippet
--}}}

--{{{ lsp_signature.nvim color
vim.api.nvim_command("hi lsp_signature_highlight guifg=black guibg=#f68e26")
--}}}

--{{{ which-key background color (transparency)
vim.api.nvim_set_hl(0, "WhichKeyFloat", { ctermbg = 'black', ctermfg = 'black' })
vim.api.nvim_set_hl(0, "WhichKeyBorder", { ctermbg = 'black', ctermfg = 'black' })
--}}}
EOF
" }}}

" ------- GUI -------
" {{{ GUI << neovide >>
if exists('g:neovide') || exists('g:nvy')
    " {{{ neovide-config
    let g:neovide_cursor_vfx_mode = "railgun"
    " let g:neovide_cursor_vfx_mode = "torpedo"
    " let g:neovide_cursor_vfx_mode = "pixiedust"
    " let g:neovide_cursor_vfx_mode = "ripple"
    let g:neovide_cursor_vfx_particle_density=7.0
    let g:neovide_cursor_trail_length=0.05

    let g:neovide_refresh_rate=60

    let g:neovide_cursor_antialiasing=v:true
    let g:neovide_cursor_animation_length=0.02

    let g:neovide_transparency=0.97
    let g:neovide_fullscreen=v:false
    let g:neovide_remember_window_size=v:true
    let g:neovide_remember_window_position=v:true

    let g:neovide_confirm_quit=v:true              " 修改文件后退出提示
    let g:neovide_hide_mouse_when_typing=v:true    " 输入时隐藏鼠标
    " let g:neovide_profiler = v:true                " 左上角显示帧数

    let g:neovide_scroll_animation_length = 0.3

" Adjust transparency
    nnoremap <m-,> :let g:neovide_transparency-=0.02<CR>:let g:neovide_transparency<CR>
    nnoremap <m-.> :let g:neovide_transparency+=0.02<CR>:let g:neovide_transparency<CR>
    inoremap <m-,> <C-o>:let g:neovide_transparency-=0.02<CR><C-o>:let g:neovide_transparency<CR>
    inoremap <m-.> <C-o>:let g:neovide_transparency+=0.02<CR><C-o>:let g:neovide_transparency<CR>

" Toggle fullscreen
    function Neovide_fullscreen()
        if g:neovide_fullscreen == v:true
            let g:neovide_fullscreen=v:false
        else
            let g:neovide_fullscreen=v:true
        endif
    endfunction
    nnoremap <m-CR> :call Neovide_fullscreen()<cr>

" Adjust fontsize
    let s:guifontsize=12
    let s:guifont="Delugia\\ Mono"
    function! AdjustFontSize(amount)
        let s:guifontsize = s:guifontsize + a:amount
        execute "set guifont=" .. s:guifont .. ":h" .. s:guifontsize
    endfunction
    " keyboard
    nnoremap <m--> :call AdjustFontSize(-1)<CR>
    nnoremap <m-=> :call AdjustFontSize(1)<CR>
    nnoremap <m-BS> :set guifont=Delugia\ Mono:h12.01<CR>
    inoremap <m--> <C-o>:call AdjustFontSize(-1)<CR>
    inoremap <m-=> <C-o>:call AdjustFontSize(1)<CR>
    inoremap <m-BS> <C-o>:set guifont=Delugia_Mono:h12.01<CR>
    " mouse
    noremap <m-ScrollWheelUp> :call AdjustFontSize(1)<CR>
    noremap <m-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
    inoremap <m-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
    inoremap <m-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a
    " }}}
endif
" }}}

" {{{ GUI << goneovim >>
if exists('g:goneovim')
lua << EOF
function guifontscale(n)
    if type(n) ~= "number" then
        return
    end

    local gfa = {}
    for c in vim.gsplit(vim.o.guifont, ":") do
        table.insert(gfa, c)
    end
    local gfa_wide = {}
    for c in vim.gsplit(vim.o.guifontwide, ":") do
        table.insert(gfa_wide, c)
    end
    local buildnewgf = ""
    local buildnewgf_wide = ""
    for k, v in ipairs(gfa) do
        if v:find("h", 1, true) == 1 then
            local fweight = ""
            for w in vim.gsplit(v, "h") do
                if tonumber(w) == nil then
                    goto continue
                end
                local wn = tonumber(w)
                wn = wn + n
                fweight = fweight .. tostring(wn)
                ::continue::
            end
            buildnewgf = buildnewgf .. "h" .. fweight .. ":"
        else
            v = string.gsub(v, " ", "_")
            buildnewgf = buildnewgf ..  v .. ":"
        end
    end
    for k, v in ipairs(gfa_wide) do
        if v:find("h", 1, true) == 1 then
            local fweight = ""
            for w in vim.gsplit(v, "h") do
                if tonumber(w) == nil then
                    goto continue
                end
                local wn = tonumber(w)
                wn = wn + n
                fweight = fweight .. tostring(wn)
                ::continue::
            end
            buildnewgf_wide = buildnewgf_wide .. "h" .. fweight .. ":"
        else
            v = string.gsub(v, " ", "_")
            buildnewgf_wide = buildnewgf_wide ..  v .. ":"
        end
    end

    local setcmd = "set guifont=" .. buildnewgf
    vim.cmd(setcmd)
    setcmd = "set guifontwide=" .. buildnewgf_wide
    vim.cmd(setcmd)
end
vim.keymap.set("n", "<m-->", ":lua guifontscale(-1)<CR>", { silent = true  })
vim.keymap.set("n", "<m-=>", ":lua guifontscale(1)<CR>", { silent = true  })

--other mapping
vim.keymap.set("n", "<m-CR>", ":GonvimMaximize<CR>", { silent = true  })
vim.keymap.set("n", "<leader>rg", ":<C-U>e C:/Users/ThinkPad/AppData/Roaming/.goneovim/settings.toml<CR>", { silent = true  })
EOF
endif
" }}}







