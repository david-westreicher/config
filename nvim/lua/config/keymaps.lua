-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-q>", vim.cmd.quitall)
vim.keymap.set("n", "<C-w>", function()
  local find_buffer_by_type = function(type)
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      local ft = vim.api.nvim_buf_get_option(buf, "filetype")
      if ft == type then
        return buf
      end
    end
    return -1
  end
  local is_neotree_open = find_buffer_by_type("neo-tree") > 0
  if is_neotree_open then
    require("neo-tree.command").execute({ action = "close" })
    vim.cmd.bdelete()
    require("neo-tree.command").execute({ action = "show" })
  else
    vim.cmd.bdelete()
  end
end)

vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")
vim.keymap.set("n", "<S-j>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
-- vim.keymap.set("n", "<S-k>", "<cmd>bnext<cr>", { desc = "Next buffer" })
--
vim.keymap.set("n", "<S-Tab>", "<cmd>e #<cr>", { desc = "Switch to other buffer" })
