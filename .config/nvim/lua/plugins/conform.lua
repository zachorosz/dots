vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofmt", stop_after_first = true },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
    format_on_save = function(bufn)
        local ignore_fts = { "sql" }
        if vim.tbl_contains(ignore_fts, vim.bo[bufn].filetype) then
            return
        end
        if vim.g.disable_autoformat or vim.b[bufn].disable_autoformat then
            return
        end
        local bufname = vim.api.nvim_buf_get_name(bufn)
        if bufname:match("/node_modules/") then
            return
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
    end,
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	require("conform").format({ async = true }, function(err, did_edit)
		if not err and did_edit then
			vim.notify("Code formatted", vim.log.levels.INFO, { title = "Conform" })
		end
	end)
end, { desc = "Format buffer" })
