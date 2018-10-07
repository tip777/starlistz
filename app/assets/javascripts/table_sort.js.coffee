# プレイリストの曲を並び替える系ののコード

#曲の番号を振りなおす
rerollNumber = ->
  n = 0
  h = 0
  $('.track_no').each (i, elem) ->
    if $(elem).parent().parent().parent().parent().is(':visible')
      n = n + 1
      elem.innerHTML = n
  $('.sort_order').each (i, elem) ->
    if $(elem).parent().parent().parent().parent().is(':visible')
      $(elem).val  h
      h = h + 1
      return
      
listSort = ->
  agent = navigator.userAgent
  #スマホやタブレットの場合
  if agent.search(/iPhone/) != -1 or agent.search(/iPad/) != -1 or agent.search(/iPod/) != -1 or agent.search(/Android/) != -1
    $('.track_sorticon').on 'touchstart', ->
      $('.table-sortable').sortable 
        disabled: false
        stop: (event, ui) ->
          rerollNumber()
          # console.log 'そーとストップ'
          return
      console.log 'タッチスタート'
      event.preventDefault()
      return
    $('.track_sorticon').on 'click touchend', ->
      $('.table-sortable').sortable disabled: true
      # console.log 'たっちエンド'
      return
  #PCの場合
  else
    $(document).on 'mouseover', '.track_sorticon', (e) ->
      $('.table-sortable').sortable 
        disabled: false
        stop: (event, ui) ->
          rerollNumber()
          # console.log 'そーとストップ'
          return
      # console.log 'タッチスタート'
      return
    $(document).on 'mouseout', '.track_sorticon', (e) ->
      $('.table-sortable').sortable disabled: true
      # console.log 'マウスあうと'
      return
  return
      
$(document).ready ->
  rerollNumber()
  listSort()
  
  #曲を新規で追加時
  $('#track_section').on 'cocoon:after-insert', (e, insertedItem) ->
    rerollNumber()
    listSort()
    #曲のrecommendのid
    $(insertedItem).find('.custom-check-box').attr('id', "custom-checkbox" + $(insertedItem).index())
    $(insertedItem).find('.track_recommend').attr('for', "custom-checkbox" + $(insertedItem).index())

  #曲を削除時
  $('#track_section').on 'cocoon:after-remove', (e, insertedItem) ->
    rerollNumber()
    return
  
  # #スマホやタブレットの場合
  # if agent.search(/iPhone/) != -1 or agent.search(/iPad/) != -1 or agent.search(/iPod/) != -1 or agent.search(/Android/) != -1
  #   $('.track_sorticon').on 'touchstart', ->
  #     $('.table-sortable').sortable disabled: false
  #     console.log 'タッチスタート'
  #     event.preventDefault()
  #     return
  #   $('.track_sorticon').on 'click touchend', ->
  #     $('.table-sortable').sortable disabled: true
  #     rerollNumber()
  #     console.log 'たっちエンド'
  #     return
  # #PCの場合
  # else
  #   $(document).on 'mouseover', '.track_sorticon', (e) ->
  #     $('.table-sortable').sortable disabled: false
  #     # console.log 'タッチスタート'
  #     return
  #   # ).mouseout ->
  #   $(document).on 'mouseout', '.track_sorticon', (e) ->
  #     $('.table-sortable').sortable disabled: true
  #     rerollNumber()
  #     console.log 'マウスあうと'
  #     return
  
  # $('.track_sorticon').mouseover(->
  #   elem_sort = $(this).parents("#track_section")
  #   elem_sort.addClass 'table-sortable'
  #   $('.table-sortable').sortable
  #     start: (event, ui) ->
  #       $(ui.item).addClass 'draggedDiv'
  #       return
  #     stop: (event, ui) ->
  #       $(ui.item).removeClass 'draggedDiv'
  #       rerollNumber()
  #       console.log '止まった'
  #       return
  #   console.log 'マウスオーバー'
  #   return
  # ).mouseout ->
  #   elem_sort = $(this).parents("#track_section")
  #   elem_sort.removeClass 'table-sortable'
  #   console.log 'マウスあうと'
  #   return
  
  # agent = navigator.userAgent
  # #スマホやタブレットの場合
  # if agent.search(/iPhone/) != -1 or agent.search(/iPad/) != -1 or agent.search(/iPod/) != -1 or agent.search(/Android/) != -1
  #   $('.track_sorticon').on 'click touchstart', ->
  #     elem_sort = $(this).children()
  #     elem_sort.text("android")
  #     console.log 'マウスオーバー'
  #     return
  #   $('.track_sorticon').on 'click touchend', ->
  #     elem_sort = $(this).children()
  #     elem_sort.text("dehaze")
  #     console.log 'マウスオーバー'
  #     return
  # #PCの場合
  # else
  #   $('.track_sorticon').mouseover(->
  #     elem_sort = $(this).children()
  #     elem_sort.text("check_circle")
  #     console.log 'マウスオーバー'
  #     return
  #   ).mouseout ->
  #     elem_sort = $(this).children()
  #     elem_sort.text("dehaze")
  #     console.log 'マウスあうと'
  
  
  
  
  
  
  
  # agent = navigator.userAgent
  # #スマホやタブレットの場合
  # if agent.search(/iPhone/) != -1 or agent.search(/iPad/) != -1 or agent.search(/iPod/) != -1 or agent.search(/Android/) != -1
  #   # jQuery('.track_sorticon').on 'touchstart', ->
  #   $(document).on 'touchstart', '.track_sorticon', (e) ->
  #     # elem_sort = $(this).parents("#track_section")
  #     # elem_sort.addClass 'table-sortable'
  #     $('.table-sortable').sortable
  #     # $('.table-sortable').bind 'touchstart.sortable', (ev) ->
  #     #   ev.target.focus()
  #     #   return
  #     # $('.table-sortable').sortable()
  #     # $('.table-sortable input').bind 'touchstart.sortable touchmove.sortable', (ev) ->
  #     #   ev.target.focus()
  #     #   return
  #       # start: (event, ui) ->
  #       #   $(ui.item).addClass 'draggedDiv'
  #       #   return
  #       # stop: (event, ui) ->
  #       #   $(ui.item).removeClass 'draggedDiv'
  #       #   rerollNumber()
  #       #   # console.log '止まった'
  #       #   return
  #     console.log 'タッチスタート'
  #     event.preventDefault()
  #     return
  #   # jQuery('.track_sorticon').on 'touchend', ->
  #   $(document).on 'touchend', '.track_sorticon', (e) ->
  #     $('.table-sortable').sortable disabled: true
  #     # elem_sort = $(this).parents("#track_section")
  #     # elem_sort.removeClass 'table-sortable'
  #     rerollNumber()
  #     console.log 'たっちエンド'
  #     # event.preventDefault()
  #     return
  # #PCの場合
  # else
  #   # $('.track_sorticon').mouseover(->
  #   $(document).on 'mouseover', '.track_sorticon', (e) ->
  #     # elem_sort = $(this).parents("#track_section")
  #     # elem_sort.addClass 'table-sortable'
  #     $('.table-sortable').sortable disabled: false
  #     # $('.table-sortable').sortable
  #     #   start: (event, ui) ->
  #     #     $(ui.item).addClass 'draggedDiv'
  #     #     return
  #     #   stop: (event, ui) ->
  #     #     $(ui.item).removeClass 'draggedDiv'
  #     #     rerollNumber()
  #     #     # console.log '止まった'
  #     #     return
  #     # console.log 'タッチスタート'
  #     return
  #   # ).mouseout ->
  #   $(document).on 'mouseout', '.track_sorticon', (e) ->
  #     $('.table-sortable').sortable disabled: true
  #     # elem_sort = $(this).parents("#track_section")
  #     # elem_sort.removeClass 'table-sortable'
  #     rerollNumber()
  #     console.log 'マウスあうと'
  #     return
  
  