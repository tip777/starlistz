$(document).on 'turbolinks:load', ->
  fixHelper = (e, ui) ->
    ui.children().each ->
      $(this).width $(this).width()
      return
    ui
  $('.table-sortable').sortable
    helper: fixHelper
    axis: 'y'
    items: '.track_item'
    update: (e, ui) ->
      item = undefined
      item = ui.item
      $('.sort_order').each (i, elem) ->
        $(elem).val $(elem).closest('tr').index()
        return
    # start: (e, ui) ->
    #   ui.placeholder.height ui.helper.outerHeight()
    #   return
    # helper: fixPlaceHolderWidth
    stop: (e, ui) ->
      ui.item.children('td').effect 'highlight'

  $('.table-sortable').on 'cocoon:after-insert', (e, insertedItem) ->
    $(insertedItem).find('.sort_order').val $(insertedItem).index()
    return
