#' Create config
#' 
#' Create project config
#' 
#' @inheritParams format
#' 
#' @export
setup <- \(
  style = c("tidy", "grk")
) {
  style <- match.arg(style)

  writeLines(
    sprintf("style=%s", style),
    CONFIG
  )

  usethis::use_build_ignore(CONFIG)

  invisible()
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
