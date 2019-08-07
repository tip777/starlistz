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

    if $('div').hasClass('track_item')
      if $('.l__iconDesc').css('display') == 'none'
        $('.l__iconDesc').show()

  #曲を削除時
  $('#track_section').on 'cocoon:after-remove', (e, insertedItem) ->
    rerollNumber()
    return
  
  
  