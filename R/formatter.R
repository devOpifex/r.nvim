CONFIG <- ".rnvim" # nolint

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
    styler::style_file(temp)
  } else {
    grkstyle::grk_style_file(temp)
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

get_style_from_config <- \(path){
  conf <- readLines(path)

  style <- conf[grepl("style", conf)] |>
    (\(.) gsub("^style\\s?=", "", .))() |>
    trimws()
}

get_config <- \(){
  # found in project
  # TODO use here::here?
  if(file.exists(CONFIG))
    return(CONFIG)

  core <- file.path(path.expand("~"), CONFIG)

  if(file.exists(core))
    return(core)

  return(NULL)
}
