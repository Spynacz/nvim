local wk = require("which-key")

wk.register({
    f = {
        name = "File search",
        g = "Git files",
        s = "Grep search",
        l = "Live grep",
        b = "File browser",
    },
    o = "Find files",
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
    h = "Signature help",
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
    },
    ["<space>"] = {
        name = "Swap split",
        h = "Swap split left",
        j = "Swap split down",
        k = "Swap split up",
        l = "Swap split right",
    }
}, { prefix = "<leader>", mode = "n" })


wk.register({
    p = "Paste over and keep clipboard"
}, { prefix = "<leader>", mode = "x" })

wk.register({
    y = "Yank selection to system clipboard",
    d = "Delete to void register"
}, { prefix = "<leader>", mode = {"n", "v"} })
