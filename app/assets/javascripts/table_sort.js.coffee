# プレイリストの曲を並び替える系ののコード

$(document).ready ->
  rerollNumber()
  listSort()
  autocomplete_setup()
  
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

    autocomplete_setup()

  #曲を削除時
  $('#track_section').on 'cocoon:after-remove', (e, insertedItem) ->
    rerollNumber()
    autocomplete_setup()
    return


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

#autocomplete部分を曲の追加、削除時に読み込み直せるように
autocomplete_setup = ->
  $('.auto_word').autocomplete source: (request, response) ->
    $.ajax
      url: window.location.protocol + '//' + window.location.host + '/auto_complete_word.json'
      dataType: 'json'
      cache: false
      data: term: request.term
      success: (data) ->
        response data
        return
      error: (XMLHttpRequest, textStatus, errorThrown) ->
        response [ '' ]
        return
    delay: 1000
    minLength: 2

  # $('.song_auto').autocomplete
  #   source: window.location.protocol + '//' + window.location.host + '/auto_complete_song.json'
  #   minLength: 2
  #   delay: 1000
  # $('.artist_auto').autocomplete
  #   source: window.location.protocol + '//' + window.location.host + '/auto_complete_artist.json'
  #   minLength: 2
  #   delay: 1000

  # try
  #   $('.song_auto').autocomplete
  #     source: window.location.protocol + '//' + window.location.host + '/auto_complete_song.json'
  #     minLength: 2
  #     delay: 1000
    # $('.artist_auto').autocomplete
    #   source: (req, res) ->
    #     $.ajax
    #       url: window.location.protocol + '//' + window.location.host + '/auto_complete_artist.json'
    #       dataType: 'json'
    #       success: (data) ->
    #         res data
    #         return
    #     return
    #   delay: 1000
    #   minLength: 2
  #   $('.artist_auto').autocomplete
  #     source: window.location.protocol + '//' + window.location.host + '/auto_complete_artist.json'
  #     minLength: 2
  #     delay: 1000
  # catch error
  #   consle.log 'エラー内容 : ' + error