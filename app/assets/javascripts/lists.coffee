# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  if $('div').hasClass('track_item') and $('div').hasClass('l__iconDesc')
    $('.l__iconDesc').show()
  return

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
    