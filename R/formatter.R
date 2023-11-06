#' Formatter
#'
#' Formatter for conform.nvim
#'
#' @param file File to style.
#' @param style Style to apply.
#'
#' @export
format <- \(
  file,
  style = c("grk", "tidy")
){
  args <- commandArgs(TRUE)

  style <- match.arg(style)
  if (missing(file)) {
    file <- args[1]
  }

  if (length(args) > 1L) {
    style <- args[2]
  }

  ext <- tools::file_ext(file)
  temp <- tempfile("styler", fileext = sprintf(".%s", ext))
  writeLines(readLines(file), temp)

  options(styler.quiet = TRUE)

  if (style == "tidy") {
    styler::style_file(temp)
  } else {
    grkstyle::grk_style_file(temp)
  }

  cat(paste0(readLines(temp), collapse = "\n"))
}
