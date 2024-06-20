library(gha)
library(rlang)

gha_group_start("Debugging message")
gha_debug("Debugging")
gha_notice("Notice me!%0AThis is the second line%0AThis is the third line.")
gha_warning("This is a warning!")
gha_error("DANGER WILL ROBINSON!")
gha_group_end()

gha_summary("# Heading")
gha_summary(c(" ", "* A", "* B"))

f <- function() g()
g <- function() h(x = 1, y = 2)
h <- function(...) {
  warning("This is a warning!")
}
f()

gha_group_start("A loop")
for (i in 1:10) {
  gha_group_start("Iteration {i}")
  gha_notice("Reticulating splines...")
  Sys.sleep(0.1)
  gha_notice("Done reticulating splines.")
  gha_group_end()
}
gha_group_end()
