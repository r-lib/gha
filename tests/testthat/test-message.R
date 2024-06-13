test_that("simple messages produce expected output", {
  expect_snapshot({
    gha_debug("message")
    gha_notice("message")
    gha_warning("message")
    gha_error("message")
  })
})
