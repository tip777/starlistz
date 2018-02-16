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
      #すべての曲の並び順変更
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
    #曲のrecommendのid
    $(insertedItem).find('.custom-check-box').attr('id', "custom-checkbox" + $(insertedItem).index())
    $(insertedItem).find('.track_recommend').attr('for', "custom-checkbox" + $(insertedItem).index())
    return
