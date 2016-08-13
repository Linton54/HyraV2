$ ->
  #Mobile navigation
  $(".mobile-nav-icon a").each ->
    if this.href == window.location.href
      $(this).addClass("activeNav")
      names = $(this).children().attr('class').split(" ")
      theClass = names[1]
      $(".#{theClass}").css 'color', '#6ed3cf'

  $('.nav-category li a').each ->
    if this.href == window.location.href
      $(this).addClass("activeNav")
