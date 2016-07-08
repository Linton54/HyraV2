$ ->
  #Auto-complete for window
  $('.nav-search').each ->
    $(this).autocomplete(
      source: '/search_suggestions',
      delay: 100,
      minLength: 1).data('ui-autocomplete')._renderItem = (ul, item) ->
        $('<li>')
        .data('ui-autocomplete-item', item)
        .append("<a href='/users/#{item.label}'>" + item.label + "</a>")
        .appendTo(ul)