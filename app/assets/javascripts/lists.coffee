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