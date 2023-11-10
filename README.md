<!-- badges: start -->
<!-- badges: end -->

# r.nvim

Formatter for R.

## Installation

``` r
# install.packages("remotes")
remotes::install_github("devOpifex/r.nvim")
```

## Styles 

Two styles available:

- `tidy`: [tidyverse](https://github.com/r-lib/styler)
- `grk`: [grkstyle](https://github.com/gadenbuie/grkstyle)

These can be defined with the `.rnvim` config file like so:

```
style=tidy
```

If this file is fount at the root of your project it is used,
otherwise it looks for the file in your home directory (`~/.rnvim`),
if that is not found it takes the function argument default (`tidy`).

## Setup

You can setup for a project with `setup("tidy")` or `setup("grk")`.
See the previous section to create a system-wide config.

## Formatter

To use with [conform.nvim](https://github.com/stevearc/conform.nvim).

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

> {styler} is slow, increase the timeout of your format on save, e.g.:

```lua
require("conform").setup({
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 2000,
    lsp_fallback = true,
  },
})
```

