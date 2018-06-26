# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$('.field_track_add')
    .on 'cocoon:before-insert', (e, track_to_be_added) ->
      console.log('before insert')
      track_to_be_added.fadeIn('slow')
    .on 'cocoon:after-insert', (e, added_track) ->
      console.log('after insert')
      added_track.css("background","red")
    .on 'cocoon:before-remove', (e, track_to_be_removed) ->
      console.log('before remove')
      track_to_be_removed.fadeOut('slow')
    .on 'cocoon:after-remove', (e, removed_track) ->
      console.log('after remove')
    
# プレイリスト　編集、新規作成時の「曲の説明」表示、非表示
$(document).on 'click', '.comment', (e) ->
  elem = e.target
  
  #コメントアイコンを切り替える
  if $(elem).parent().siblings(".description").children("input").val().length > 0
    $(elem).text("comment")
    $(elem).removeClass().addClass("material-icons already");
  else
    $(elem).text("add_comment")
    $(elem).removeClass().addClass("material-icons still");
    
  #曲の説明欄の表示、非表示
  if $(elem).parent().siblings(".description").is(':hidden')
    $(elem).parent().siblings(".description").show()
  else if $(elem).parent().siblings(".description").is(':visible')
    $(elem).parent().siblings(".description").hide()
  else
    alert 'not find'
  return
    