# simple messages produce expected output

    Code
      gha_debug("message")
    Output
      ::debug::message
    Code
      gha_notice("title", "message")
    Output
      ::notice title=title::message
    Code
      gha_warning("title", "message")
    Output
      ::warning title=title::message
    Code
      gha_error("title", "message")
    Output
      ::error title=title::message

