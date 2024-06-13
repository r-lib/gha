#' Compute duration of each knitr chunk
#' 
#' Call this function in a setup chunk to automatically record the amount of
#' time every subsequent chunk takes. This useful for identifying slow chunks,
#' and is generally good practice when rendering an Rmd or qmd in a 
#' non-interactive environment.
#' 
#' @source Inspired by <https://bookdown.org/yihui/rmarkdown-cookbook/time-chunk.html>.
#' 
#' @export
knitr_time_chunks <- function() {
  check_required("knitr")
  if (!isTRUE(getOption("knitr.in.progress"))) {
    return(invisible())
  }
  
  now <- NULL
  knitr::knit_hooks$set(time_it = function(before, options) { 
    if (before) {
      now <<- Sys.time()
    } else {
      res <- difftime(Sys.time(), now, units = "secs")
      log_glue("Chunk [{options$label}] took {round(res, 1)}s")
    }
  })
  knitr::opts_chunk$set(time_it = TRUE)

  invisible()
}
