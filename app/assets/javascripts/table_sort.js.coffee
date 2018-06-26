# プレイリストの曲を並び替える系ののコード

#曲の番号を振る
rerollNumber = ->
  n = 0
  h = 0
  $('.track_no').each (i, elem) ->
    n = n + 1
    elem.innerHTML = n
    return
  $('.sort_order').each (i, elem) ->
    elem.innerHTML = h
    h = h + 1
    return

$(document).ready ->
  rerollNumber()
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
      rerollNumber()
      item = undefined
      item = ui.item
      #すべての曲の並び順変更
      # $('.sort_order').each (i, elem) ->
      #   $(elem).val $(elem).closest('tr').index()
      $('.track_item').each (i, elem) ->
        $(elem).find(".track_no").innerHTML = i+1 #曲の番号を変更
        $(elem).find(".sort_order").val i #並び順用の値を変更

    stop: (e, ui) ->
      ui.item.children('td').effect 'highlight'
  
  #曲を新規で追加時
  $('.table-sortable').on 'cocoon:after-insert', (e, insertedItem) ->
    rerollNumber()
    #曲のrecommendのid
    $(insertedItem).find('.custom-check-box').attr('id', "custom-checkbox" + $(insertedItem).index())
    $(insertedItem).find('.track_recommend').attr('for', "custom-checkbox" + $(insertedItem).index())
    return
  
  #曲を新規で追加時
  $('.table-sortable').on 'cocoon:after-remove', (e, insertedItem) ->
    rerollNumber()
    return

  