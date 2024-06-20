#' Send push notification with ntfy.sh
#' 
#' This is a very lightweight wrapper to for <https://ntfy.sh> using the curl
#' package. We suggest using ntfy.sh because it's free and doesn't require any
#' setup. 
#' 
#' @seealso <https://github.com/jonocarroll/ntfy> for a more feature-rich
#'   wrapper.
#' @param id ID of your notification page.
#' @param message,title Message body and title. Interpolated with glue.
#' @param link Optional link to open when notification is clicked.
#' @export
#' @examples
#' ntfy_send("hKaZodPEhZVdcMHU", "Hi you! Today is {format(Sys.Date(), '%A')}.")
#' browseURL("https://ntfy.sh/hKaZodPEhZVdcMHU")
ntfy_send <- function(id,
                      message,
                      title = "Notification from gh",
                      link = NULL) {
  check_string(id)
  check_string(message)
  check_string(title)
  check_string(link, allow_null = TRUE)

  message <- glue(message, frame = caller_env())
  title <- glue(title, frame = caller_env())

  h <- curl::new_handle()
  curl::handle_setheaders(h, Title = title)
  if (!is.null(link)) {
    curl::handle_setheaders(h, Click = link)
  }
  curl::handle_setopt(h,
    post = TRUE,
    postfieldsize = nchar(message),
    postfields = message
  )
  path <- file.path("https://ntfy.sh", id)
  curl::curl_fetch_memory(path, handle = h)
  invisible()
}
