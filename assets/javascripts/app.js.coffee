$ ->
  $("#main").click ->
    console.log "clicked!"
    if $("#answer").is ':visible'
      $("#answer").hide()
    else
      $("#answer").show()

$(document).ready ->
  $("#answer").hide()


