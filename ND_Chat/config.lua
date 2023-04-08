config = {
    ["/me"] = true,
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
    ["/911"] = {
        enabled = true,
        callTo = {
            "LSPD",
            "BCSO",
            "SAHP",
            "LSFD"
        }
    }
}