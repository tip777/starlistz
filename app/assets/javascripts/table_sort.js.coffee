# プレイリストの曲を並び替える系ののコード

#曲の番号を振りなおす
rerollNumber = ->
  n = 0
  h = 0
  $('.track_no').each (i, elem) ->
    n = n + 1
    elem.innerHTML = n
  $('.sort_order').each (i, elem) ->
    $(elem).val  h
    h = h + 1
    return
      
$(document).ready ->
  rerollNumber()
  # $('.table-sortable').sortable
  #   start: (event, ui) ->
  #     $(ui.item).addClass 'draggedDiv'
  #     return
  #   stop: (event, ui) ->
  #     $(ui.item).removeClass 'draggedDiv'
  #     rerollNumber()
  #     console.log '止まった'
  #     return
  
  #曲を新規で追加時
  $('.table-sortable').on 'cocoon:after-insert', (e, insertedItem) ->
    rerollNumber()
    #曲のrecommendのid
    $(insertedItem).find('.custom-check-box').attr('id', "custom-checkbox" + $(insertedItem).index())
    $(insertedItem).find('.track_recommend').attr('for', "custom-checkbox" + $(insertedItem).index())
    return
  
  #曲を削除時
  $('.table-sortable').on 'cocoon:after-remove', (e, insertedItem) ->
    rerollNumber()
    return
  
  $('.track_sorticon').mouseover(->
    elem_sort = $(this).parents("#track_section")
    elem_sort.addClass 'table-sortable'
    $('.table-sortable').sortable
      start: (event, ui) ->
        $(ui.item).addClass 'draggedDiv'
        return
      stop: (event, ui) ->
        $(ui.item).removeClass 'draggedDiv'
        rerollNumber()
        console.log '止まった'
        return
    console.log 'マウスオーバー'
    return
  ).mouseout ->
    elem_sort = $(this).parents("#track_section")
    elem_sort.removeClass 'table-sortable'
    console.log 'マウスあうと'
    return



  