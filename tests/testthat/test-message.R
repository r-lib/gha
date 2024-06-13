test_that("simple messages produce expected output", {
  expect_snapshot({
    gha_debug("message")
    gha_notice("title", "message")
    gha_warning("title", "message")
    gha_error("title", "message")
  })
})
