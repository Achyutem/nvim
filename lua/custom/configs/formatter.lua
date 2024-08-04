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

return M
