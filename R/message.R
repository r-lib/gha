#' Add message to the GitHub Actions log
#' 
#' @description
#' These messages are highlighted in the log and are displayed on the summary
#' page.
#' 
#' * `gha_debug()` are only shown when `ACTIONS_STEP_DEBUG` is set to `true`,
#'   which typically happens when you re-run a job and select 
#'   "Enable debug logging".
#' * `gha_notice()` plays a similar role to `message()`/`cli_inform()`; i.e.
#'   use it for informative notices about things that are working correctly.
#' * `gha_warning()` plays a similar role to `warning()`/`cli_warn()`; i.e.
#'   use it to report problems that are being overcome automatically, but 
#'   should really be fixed.
#' * `gha_error()` plays a similar role to `stop()`/`cli_error()`; i.e. use it
#'   to report problems that require manual intervention.
#' 
#' @export
#' @param message Interpolated glue string giving message to record. 
#'   Must be a single line.
#' @param frame Frame in which glue will look for variables. Typically only
#'   needed if you are wrapping this in another function.
gha_debug <- function(message, frame = caller_env()) {
  check_string(message)

  message <- glue(message, .envir = frame)
  message <- paste0("::debug::", message, "\n")
  cat(message, file = gha_stream())
}

#' @export
#' @rdname gha_debug
#' @param title Interpolated glue string giving a custom title for the message.
#' @param file,line,col,endLine,endCol Optionally, associate a message with
#'   a specific file, and location within that file.
gha_notice <- function(title,
                       message,
                       file = NULL,
                       line = NULL,
                       col = NULL,
                       endLine = NULL,
                       endCol = NULL,
                       frame = caller_env()) { 
                         
  gha_message(
    "notice",
    title = title,
    message = message,
    file = file, 
    line = line,
    col = col,
    endLine = endLine,
    endCol = endCol,
    frame = frame
  )
}

#' @export
#' @rdname gha_debug
gha_warning <- function(title,
                        message,
                        file = NULL,
                        line = NULL,
                        col = NULL,
                        endLine = NULL,
                        endCol = NULL,
                        frame = caller_env()) { 
  gha_message(
    "warning",
    title = title,
    message = message,
    file = file, 
    line = line,
    col = col,
    endLine = endLine,
    endCol = endCol,
    frame = frame
  )
}

#' @export
#' @rdname gha_debug
gha_error <- function(title,
                      message,
                      file = NULL,
                      line = NULL,
                      col = NULL,
                      endLine = NULL,
                      endCol = NULL,
                      frame = caller_env()) { 
  message <- glue(message, .envir = frame)
  title <- glue(title, .envir = frame)

  gha_message(
    "error",
    title = title,
    message = message,
    file = file, 
    line = line,
    col = col,
    endLine = endLine,
    endCol = endCol,
    frame = frame
  )
}

gha_message <- function(type,
                        title,
                        message,
                        file = NULL,
                        line = NULL,
                        col = NULL,
                        endLine = NULL,
                        endCol = NULL,
                        call = caller_env(),
                        frame = caller_env()) {

  check_string(title, call = call)
  check_string(message, call = call)
  check_string(file, allow_null = TRUE, call = call)
  check_number_whole(line, min = 1, allow_null = TRUE, call = call)
  check_number_whole(col, min = 1, allow_null = TRUE, call = call)
  check_number_whole(endLine, min = 1, allow_null = TRUE, call = call)
  check_number_whole(endCol, min = 1, allow_null = TRUE, call = call)
                         
  message <- glue(message, .envir = frame)
  title <- glue(title, .envir = frame)

  arguments <- list(
    title = title,
    file = file,
    line = line,
    col = col,
    endLine = endLine,
    endCol = endCol
  )
  arguments <- compact(arguments)
  arg_str <- paste0(names(arguments), "=", arguments, collapse = ",")
  message <- paste0("::", type, " ", arg_str, "::", message, "\n")
  
  cat(message, file = gha_stream())
}

gha_stream <- function() {
  # Since expect_snapshot() can't capture stderr()
  if (is_testing()) stdout() else stderr()
}
