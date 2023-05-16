config = {
    ["/me"] = true,
    ["/do"] = true,
    ["/gme"] = true,
    ["/twt"] = true,
    ["/ooc"] = true,
    ["/darkweb"] = {
        enabled = true,
        canNotSee = {
            "LSPD",
            "BCSO",
            "SAHP",
            "LSFD"
        }
    },
    ["/radiochat"] = {
        enabled = true,
        canNotSee = {
            "CIV"
        }
    },
    ["/911"] = {
        enabled = true,
        callTo = {
            "LSPD",
            "BCSO",
            "SAHP",
            "LSFD"
        }
    },
    ["/311"] = {
        enabled = true,
        callTo = {
            "DOT", -- or SADOT
        }
    }
}
