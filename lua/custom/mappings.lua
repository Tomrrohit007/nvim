local M = {}
local opts = { noremap = true, silent = true }
local noremapFalse = { noremap = false, silent = false }

vim.g.mapleader = " "

M.general = {
  n = {
    ["<Leader>w"] = { ":w<CR>", "Write", opts },
    ["<Leader>q"] = { ":q<CR>", "Quit", opts },
    ["<Leader>a"] = { "viw", "Select inner word", opts },
    ["<Leader>A"] = { "viW", "Select inner word", opts },
    ["<Leader>y"] = { "yiw", "yarn inner word", opts },
    ["-"] = { "$", "Go to end of the line", opts },
    ["+"] = { "%", noremapFalse },
    ["cN"] = { "*``cgn", "replace multiple occurance of word", opts },
  },
  v = {
    ["J"] = { ":m '>+1<CR>gv=gv", "Move codeblock up", opts },
    ["K"] = { ":m '<-2<CR>gv=gv", "Move codeblock down", opts },
    ["-"] = { "$", "Go to end of the line", opts },
    ["+"] = { "%", noremapFalse },
  },
}

return M
