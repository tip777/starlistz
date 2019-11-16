# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  if $('div').hasClass('track_item') and $('div').hasClass('l__iconDesc')
    $('.l__iconDesc').show()
  return

#list new edit 曲の追加時の動作
# $('.field_track_add')
#     .on 'cocoon:before-insert', (e, track_to_be_added) ->
#       # console.log('before insert')
#       track_to_be_added.fadeIn('slow')
#     .on 'cocoon:after-insert', (e, added_track) ->
#       # console.log('after insert')
#       added_track.css("background","red")
#     .on 'cocoon:before-remove', (e, track_to_be_removed) ->
#       # console.log('before remove')
#       track_to_be_removed.fadeOut('slow')
#     .on 'cocoon:after-remove', (e, removed_track) ->
#       # console.log('after remove')

# list edit ファイル選択
$(document).ready ->
  jQuery ($) ->
    jQuery('#inputFileSub').click ->
      input_file = document.getElementById('inputFileList')
      input_file.click()
      return
    return
    
  $("#inputFileList").change ->
    # ファイル名のみ取得して表示します
    input_file = document.getElementById('inputFileList').value
    regex = /\\|\\/
    array = input_file.split(regex)
    document.getElementById('subTxt').innerHTML = array[array.length - 1]
    return
    