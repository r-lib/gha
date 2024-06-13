# simple messages produce expected output

    Code
      gha_debug("message")
    Output
      ::debug::message
    Code
      gha_notice("message")
    Output
      ::notice title=gha::message
      
    Code
      gha_warning("message")
    Output
      ::warning title=gha::message
      
    Code
      gha_error("message")
    Output
      ::error title=gha::message
      

