vim.api.nvim_create_autocmd('PackChanged', {
	desc = 'telescope: build extensions and setup it up in order',
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
			vim.system({ 'make' }, { cwd = ev.data.path })
		end
	end,
})

vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
})

local has_telescope, telescope = pcall(require, "telescope")
if has_telescope then
    telescope.setup({
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
    })
    -- Only load the fzf extension if it's already compiled and available
    pcall(telescope.load_extension, "fzf")
end

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "Telescope: Search [b]uffers" })
vim.keymap.set("n", "<leader>ph", builtin.help_tags, { desc = "Telescope: Search [h]elp" })
vim.keymap.set("n", "<leader>pk", builtin.keymaps, { desc = "Telescope: Search [k]eymaps" })
vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope: Search [f]iles" })
vim.keymap.set("n", "<leader>pg", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Telescope: Search by [G]rep" })

