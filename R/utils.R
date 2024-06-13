is_testing <- function() {
  identical(Sys.getenv("TESTTHAT"), "true")
}

defer <- function(expr, env = caller_env(), after = FALSE) {
  thunk <- as.call(list(function() expr))
  do.call(on.exit, list(thunk, TRUE, after), envir = env)
}

log_glue <- function(x, frame = caller_env()) {
  log_line(glue(x, .env = frame))
}

log_line <- function(...) {
  cat(paste0(..., "\n", collapse = ""), file = log_stream())
}

log_stream <- function() {
  # Since expect_snapshot() can't capture stderr()
  if (is_testing()) stdout() else stderr()
}
