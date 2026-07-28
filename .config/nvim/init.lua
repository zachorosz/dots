vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.guicursor = "" -- block cursor
vim.opt.number = true
--vim.opt.relativenumber = true
vim.opt.scrolloff = 8 -- number of lines above/below cursor
vim.opt.wrap = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true  -- use spaces instead of tab
vim.opt.smartindent = true
vim.opt.autoindent = true -- copy indent from current line

vim.opt.ignorecase = true
vim.opt.smartcase = true -- Case sensitive if uppercase in search
vim.opt.hlsearch = false -- highlight results
vim.opt.incsearch = true -- show matches as you type

vim.opt.termguicolors = true
--vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.opt.completeopt = "menu,menuone,noselect"

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.undodir = vim.fn.expand("~/.local/state/nvim/undo")
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "screen"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

map("n", "<leader>pv", vim.cmd.Ex)
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
-- half page jumping; centering cursor
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
-- keep cursor centered when going through search matches
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

require("plugins")

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        vim.keymap.set("n", "grr", require("telescope.builtin").lsp_references)
        vim.keymap.set("n", "grd", vim.lsp.buf.definition)

        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end

        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})

vim.lsp.enable({ 'gopls', 'lua_ls', 'rust-analyzer', 'ts_ls' })
vim.diagnostic.config({ virtual_text = true })
