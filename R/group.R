#' Group log lines, optionally adding time taken
#' 
#' GHA allows you to group log lines together, which can be useful for
#' organizing output. `gha_group_start()` starts a groups, and `gha_group_end()`
#' ends it, optionally showing the time taken.
#' 
#' @param title The title of the group
#' @export
gha_group_start <- function(title) {
  check_string(title)
  title <- glue(title, frame = caller_env())

  the$stack[[length(the$stack) + 1]] <- list(
    title = title,
    time = proc.time()
  )

  log_glue("::group::{title}")
}

#' @export
#' @rdname gha_group_start
#' @param time_threshold Show time taken if it's greater than this threshold.
gha_group_end <- function(time_threshold = 1) {
  check_number_decimal(time_threshold, min = 0)

  group <- the$stack[[length(the$stack)]]
  the$stack <- the$stack[-length(the$stack)]

  time <- proc.time()[[3]] - group$time[[3]]
  if (time > time_threshold) {
    log_glue("Time taken: {round(time, 1)}s")
  }
  log_glue("::endgroup::")
}
