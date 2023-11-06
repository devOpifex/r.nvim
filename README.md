<!-- badges: start -->
<!-- badges: end -->

# r.nvim

Formatter and linter for R.

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

``` r
local util = require("conform.util")
require("conform").formatters.styler = {
  meta = {
    url = "https://github.com/devOpifex/r.nvim",
    description = "R formatter and linter.",
  },
  command = util.find_executable({"usr/bin/"}, "R"),
  args = {"-s", "-e", "r.nvim::format()", "--args", "$FILENAME", "grk"},
}
```

