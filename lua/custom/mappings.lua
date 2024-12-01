-- local M = {}
--
-- M.dap = {
--   plugin = true,
--   n = {
--     ["<leader>db"] = {"<cmd> DapToggleBreakpoint <CR>"}
--   }
-- }
--
-- M.dap_python = {
--   plugin = true,
--   n = {
--     ["<leader>dpr"] = {
--       function()
--         require('dap-python').test_method()
--       end,
--       "Start Debugger"
--     }
--   }
-- }
--
-- return M



local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      function()
        vim.cmd("DapToggleBreakpoint")
      end,
      "Toggle Breakpoint"
    }
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require('dap-python').test_method()
      end,
      "Start Debugger"
    }
  }
}

return M
