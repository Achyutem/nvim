local M = {
    filetype = {
        javascript = {
            require("formatter.filetypes.javascript").prettier
        },
        typescript = {
            require("formatter.filetypes.typescript").prettier
        },
        ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespaces
        }
    }
}

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    -- command = "FormatWritLock"
-- })

return M
