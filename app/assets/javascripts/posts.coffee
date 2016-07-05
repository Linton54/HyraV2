$ ->
  $('.btn-settings').click ->
    id = $(this).attr("id")
    $('#modal'  + (id)).click ->
      $('#post-options' + (id)).foundation('close')