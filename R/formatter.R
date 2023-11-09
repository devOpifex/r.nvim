CONFIG <- ".rnvim" # nolint

#' Formatter
#'
#' Formatter for conform.nvim
#'
#' @param file File to style.
#' @param style Style to apply.
#'
#' @importFrom styler style_file
#' @importFrom grkstyle grk_style_file
#'
#' @export
format <- \(
  file,
  style = c("tidy", "grk")
){
  args <- commandArgs(TRUE)

  if (missing(file)) {
    file <- args[1]
  }

  style <- match.arg(style)
  style <- get_style(style)

  ext <- tools::file_ext(file)
  temp <- tempfile("styler", fileext = sprintf(".%s", ext))
  writeLines(readLines(file), temp)

  options(styler.quiet = TRUE)

  if (style == "tidy") {
    style_file(temp)
  } else {
    grk_style_file(temp)
  }

  cat(paste0(readLines(temp), collapse = "\n"))
}

get_style <- \(style = c("grk", "tidy")){
  style <- match.arg(style)

  # see if config exists
  conf <- get_config()

  # no config use arg
  if(is.null(conf))
    return(style)

  get_style_from_config(conf)
}
