-- nvim editor options
-- use vim.g.{variable} = something to replicate the behaviour of let {variable} = something
-- use vim.opt.{variable} = something to replicate the behaviour of set {variable} = something
-- when using vim.opt, if the flag is a boolean, you must explicitly set it to true or false.

vim.o.title = true
vim.o.titlestring = '%{expand("%:p:~:.")} · nvim'
vim.o.errorbells = false
vim.o.mouse = "nv"
vim.o.shell = os.getenv("SHELL") or "/bin/sh"

-- files
vim.o.encoding = "utf-8"

-- disable swap & backup, and configure undo files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("state") .. "/undodir"
vim.opt.undofile = true

-- dont unload abandoned buffers
vim.opt.hidden = true

-- open help on the side
vim.o.keywordprg = ":vertical botright help"

-- show line numbers in a file
vim.o.number = true
vim.o.relativenumber = false
vim.o.numberwidth = 4

vim.o.cursorline = true
vim.o.cursorlineopt = "both"

-- scroll offsets
vim.o.scrolloff = 5
vim.o.sidescrolloff = 15

-- completion window
vim.o.pumheight = 15
vim.opt.wildoptions = { "fuzzy", "pum", "tagfile" }
vim.o.wildmode = "longest:full,full"
vim.opt.completeopt = { "fuzzy", "menu", "menuone", "noinsert", "preview" }

-- indentations settings
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.softtabstop = 0 -- dont insert spaces on <tab>
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.smarttab = true

-- fix wrapping
vim.o.wrap = false
vim.o.breakindent = true

-- always show 1 column of sign column (gitsigns, etc.)
vim.o.signcolumn = "yes:1"

-- hide search notices, intro
vim.opt.shortmess:append("sIF")

-- hide extra text
vim.o.conceallevel = 2
vim.o.concealcursor = "c"

-- decrease update time
vim.o.updatetime = 250

-- use rgb colors
vim.o.termguicolors = true

-- use rounded border for floating windows
vim.o.winborder = 'rounded'

-- decrease mapped sequence wait time
vim.o.timeout = false
vim.o.timeoutlen = 0

-- always show tabline at the top
vim.o.showtabline = 2
vim.o.cmdheight = 0

-- global statusline
vim.o.laststatus = 3

-- don't show the mode, since it's already in the status line
vim.o.showmode = false
vim.o.showcmd = false

-- split directions
vim.o.splitbelow = true
vim.o.splitright = true

-- search settings
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
-- substitution with preview window
vim.o.inccommand = "split"

-- allow cursor to move paste the end of the line in visual block mode
vim.o.virtualedit = "block"

-- use rg for grepping
vim.o.grepprg = vim.fn.executable("rg") == 1 and "rg --vimgrep" or "grep -n $* /dev/null"
vim.o.grepformat = "%f:%l:%c:%m"

-- let me have spelling checking for english
vim.opt.spelllang = { "en" }
vim.opt.spelloptions:append("noplainbuffer")

-- show listchars
vim.opt.list = true

