# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
#Mobile navigation
  $(".mobile-nav-icon a").each ->
    if this.href == window.location.href
      $(this).addClass("activeNav")
      names = $(this).children().attr('class').split(" ")
      theClass = names[1]
      $(".#{theClass}").css 'color', '#00CAFB'