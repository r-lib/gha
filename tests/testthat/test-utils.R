test_that("log_glue() uses correct frame", {

  x <- 1
  out <- local({
    x <- 2
    capture.output(log_glue("{x}"))
  })

  expect_equal(out, "2")
})
