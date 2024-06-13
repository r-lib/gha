
#' Write markdown to job summary
#' 
#' This markdown will be displayed at the bottom of the job summary and is
#' a useful way to deliver rich content to the user.
#' 
#' @export
#' @param lines A character vector of markdown formatted text.
gha_summary <- function(lines) {
  check_character(lines)
  writeLines(lines, summary_stream())
}

summary_stream <- function(frame = caller_env()) {
  out <- Sys.getenv("GITHUB_STEP_SUMMARY")
  
  if (is_testing() || out == "") {
    out <- stdout()
  } 

  con <- file(out, "a")
  defer(close(con))

  con
}
