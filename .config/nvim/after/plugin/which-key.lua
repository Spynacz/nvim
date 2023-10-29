local wk = require("which-key")

wk.register({
    f = {
        name = "File search",
        f = "Find files",
        g = "Git files",
        s = "Grep search",
    },
    g = {
        name = "Git",
        s = "Git status",
        l = "Git log",
    },
    a = "Harpoon add file",
    l = {
        name = "LSP actions",
        w = "List workspace symbols",
        d = "Show diagnostics",
        c = "Code action",
        r = {
            name = "References, rename",
            r = "References",
            n = "Rename",
        },
        f = "Format file"
    },
    u = "Show undotree",
    p = {
        name = "File explorer",
        v = "File explorer",
    },
    Y = "Yank line to system clipboard",
    s = "Replace word under cursor",
    x = {
        name = "Trouble",
        x = "Trouble",
        q = "Trouble quickfix"
    }
}, { prefix = "<leader>", mode = "n" })


wk.register({
    p = "Paste over and keep clipboard"
}, { prefix = "<leader>", mode = "x" })

wk.register({
    y = "Yank selection to system clipboard",
    d = "Delete to void register"
}, { prefix = "<leader>", mode = {"n", "v"} })
