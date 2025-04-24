---@module "neo-tree"
---@type neotree.Config?
require("neo-tree").setup({
	open_files_using_relative_paths = true,
	name = {
		trailing_slash = true,
	},
	commands = {
		-- If item is a file it will close neotree after opening it.
		open_and_close_neotree = function(state)
			require("neo-tree.sources.filesystem.commands").open(state)

			local tree = state.tree
			local success, node = pcall(tree.get_node, tree)

			if not success then
				return
			end

			if node.type == "file" then
				require("neo-tree.command").execute({ action = "close" })
			end
		end,
	},
	window = {
		mappings = {
			["o"] = {
				"open_and_close_neotree",
				nowait = true,
			},
			["oc"] = "noop",
			["od"] = "noop",
			["og"] = "noop",
			["om"] = "noop",
			["on"] = "noop",
			["os"] = "noop",
			["ot"] = "noop",
			["O"] = {
				"show_help",
				config = { title = "Order by", prefix_key = "O" },
			},
			["Oc"] = { "order_by_created" },
			["Od"] = { "order_by_diagnostics" },
			["Og"] = { "order_by_git_status" },
			["Om"] = { "order_by_modified" },
			["On"] = { "order_by_name" },
			["Os"] = { "order_by_size" },
			["Ot"] = { "order_by_type" },
		},
	},
	filesystem = {
		hijack_netrw_behavior = "open_default",
	},
})
