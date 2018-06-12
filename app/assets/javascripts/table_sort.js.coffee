trNumber = ->
  n = 0
  $('.track_no').each (i, elem) ->
    n = n + 1
    elem.innerHTML = n
    return

# $(document).on 'turbolinks:load', ->
$(document).ready ->
  trNumber()
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
      trNumber()
      item = undefined
      item = ui.item
      #すべての曲の並び順変更
      $('.sort_order').each (i, elem) ->
        $(elem).val $(elem).closest('tr').index()
      
    # start: (e, ui) ->
    #   ui.placeholder.height ui.helper.outerHeight()
    #   return
    # helper: fixPlaceHolderWidth
    stop: (e, ui) ->
      ui.item.children('td').effect 'highlight'

  $('.table-sortable').on 'cocoon:after-insert', (e, insertedItem) ->
    trNumber()
    $(insertedItem).find('.sort_order').val $(insertedItem).index()
    #曲のrecommendのid
    $(insertedItem).find('.custom-check-box').attr('id', "custom-checkbox" + $(insertedItem).index())
    $(insertedItem).find('.track_recommend').attr('for', "custom-checkbox" + $(insertedItem).index())
    return
  
  