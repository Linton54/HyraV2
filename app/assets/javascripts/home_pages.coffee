$ ->
  #Will paginate
  $(window).scroll ->
    url = $('.pagination .next_page').attr('href')
    if url && ($(window).scrollTop() > $(document).height() - $(window).height() - 500)
      $('.pagination').text("...")
      $.getScript(url)

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
