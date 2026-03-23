-- vim config 

-- OLED Black Universal Neovim 

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- --- 1. BOOTSTRAP LAZY.NVIM ---
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- --- 2. PLUGIN LIST & CONFIG ---
require("lazy").setup({
  "sainnhe/gruvbox-material",
  "airblade/vim-gitgutter",
  "tpope/vim-commentary",
  "jiangmiao/auto-pairs",
  "nvim-tree/nvim-web-devicons",
  "echasnovski/mini.icons",
  "HiPhish/rainbow-delimiters.nvim",
  "windwp/nvim-ts-autotag",

  -- WHICH-KEY
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = { preset = "modern", win = { border = "single", padding = { 1, 2 } } },
  },

  -- TELESCOPE: The Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- High-speed C sorter (Only loads if 'make' is installed to prevent Windows errors)
      { 
        "nvim-telescope/telescope-fzf-native.nvim", 
        build = "make",
        cond = function() return vim.fn.executable 'make' == 1 end 
      },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git", ".venv" },
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
          },
          sorting_strategy = "ascending", -- Puts best results at the top
        },
      })
      pcall(telescope.load_extension, "fzf")
    end,
  },

  -- TREE-SITTER
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { 
        "lua", "vim", "vimdoc", "query", 
        "go", "javascript", "typescript", 
        "dockerfile", "yaml", "json", "markdown", "html" 
      },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
      autotag = { enable = true },
    },
    config = function(_, opts)
      local status_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
      if status_ok then ts_configs.setup(opts) end
    end,
  },
}, { rocks = { enabled = false, hererocks = false } })

-- --- 3. CORE SETTINGS ---
local opt = vim.opt
opt.clipboard = "unnamedplus"
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.updatetime = 100
opt.signcolumn = "yes"
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.cursorline = true
opt.splitbelow = true
opt.splitright = true
opt.mouse = 'a'

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- --- 4. OLED BLACK LOGIC ---
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        local hl = vim.api.nvim_set_hl
        -- Editor
        hl(0, "Normal", { bg = "#000000" })
        hl(0, "SignColumn", { bg = "#000000" })
        hl(0, "NormalFloat", { bg = "#000000" })
        hl(0, "FloatBorder", { bg = "#000000", fg = "#504945" })
        -- GitGutter
        hl(0, "GitGutterAdd", { fg = "#b8bb26", bg = "#000000" })
        hl(0, "GitGutterChange", { fg = "#fabd2f", bg = "#000000" })
        hl(0, "GitGutterDelete", { fg = "#fb4934", bg = "#000000" })
        -- Telescope specific OLED overrides
        hl(0, "TelescopeNormal", { bg = "#000000" })
        hl(0, "TelescopeBorder", { bg = "#000000", fg = "#504945" })
        hl(0, "TelescopePromptNormal", { bg = "#000000" })
        hl(0, "TelescopePromptBorder", { bg = "#000000", fg = "#504945" })
    end,
})

-- --- 5. SAFE THEME LOADING ---
vim.g.gruvbox_material_background = 'hard'
local theme_ok, _ = pcall(vim.cmd, 'colorscheme gruvbox-material')
if not theme_ok then vim.cmd('colorscheme default') end

-- --- 6. COMPONENT SETTINGS ---
vim.g.gitgutter_sign_added = '▎'
vim.g.gitgutter_sign_modified = '▎'
vim.g.gitgutter_sign_removed = ''
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25

-- --- 7. KEYBINDINGS ---
local keymap = vim.keymap.set

-- Standard operations
keymap("n", "<leader>w", ":w<CR>", { desc = "Save File" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>h", ":noh<CR>", { desc = "Clear Highlight" })
keymap("n", "<leader>e", ":Lexplore<CR>", { desc = "File Explorer" }) -- Changed to 'e' to free up 'f' for Find
keymap("n", "<leader>v", ":vsplit<CR>", { desc = "V-Split" }) 

-- Window Nav
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- TELESCOPE BINDINGS
local builtin_ok, builtin = pcall(require, "telescope.builtin")
if builtin_ok then
  keymap('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
  keymap('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep (Search Code)' })
  keymap('n', '<leader>fb', builtin.buffers, { desc = 'Find Open Buffers' })
  keymap('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help' })
end
