<!-- badges: start -->
<!-- badges: end -->

# r.nvim

Formatter for R.

## Installation

``` r
# install.packages("remotes")
remotes::install_github("devOpifex/r.nvim")
```

## Formatter

With [conform.nvim](https://github.com/stevearc/conform.nvim).
Second command line argument is the style to apply:

- `tidy`: [tidyverse](https://github.com/r-lib/styler)
- `grk`: [grkstyle](https://github.com/gadenbuie/grkstyle)

These can be defined with the `.rnvim` config file like so:

```
style=tidy
```

If this file is fount at the root of your project it is used,
otherwise it looks for the file in your home directory (`~/.rnvim`),
if that is not found it takes the function argument default (`tidy`).

Define the new formatter

```lua
local util = require("conform.util")
require("conform").formatters.styler = {
  meta = {
    url = "https://github.com/devOpifex/r.nvim",
    description = "R formatter and linter.",
  },
  command = util.find_executable({"usr/bin/"}, "R"),
  args = {"-s", "-e", "r.nvim::format()", "--args", "$FILENAME", "grk"},
  stdin = false,
}
```

Use it

```lua
local formatters = {
  typescript = {"eslint_d", "prettier",  },
  go = { "gofmt", },
  r = { "styler", },
}

require("conform").setup({
  formatters_by_ft = formatters,
})
```

> {styler} is slow, increase the timeout.

