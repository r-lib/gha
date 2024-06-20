library(gha)
library(rlang)

gha_debug("Debugging")
gha_notice("Notice me!%0AThis is the second line%0AThis is the third line.")
gha_warning("This is a warning!")
gha_error("DANGER WILL ROBINSON!")

gha_summary("# Heading")
gha_summary(c(" ", "* A", "* B"))


globalCallingHandlers(warning = function(cnd) {
  call <- conditionCall(cnd)
  message <- conditionMessage(cnd)
  gha_warning("{call}: {message}")
})

f <- function() g()
g <- function() h()
h <- function() {
  warning("This is a warning!")
}
f()

event <- Sys.getenv("GITHUB_EVENT_NAME", "localhost")
ntfy_send("hKaZodPEhZVdcMHU", "Examples run by {event}")
