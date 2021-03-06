 /*
  *
  *
  *  オレ用js
  *
  *
  */

// $(document).on('turbolinks:load', function() {
$(document).ready(function(){

  var $window = $(window),
      $html = $('html'),
      $body = $('body'),
      $overlay = $('.settingMenu_back'),
      scrollbar_width = window.innerWidth - document.body.scrollWidth,
      touch_start_y;

  $window.on('touchstart', function(event) {
    touch_start_y = event.originalEvent.changedTouches[0].screenY;
  });

  $('.js__subMemu').on('click', function() {
    $window.on('touchmove.noscroll', function(event) {
      var overlay = $overlay[0],
          current_y = event.originalEvent.changedTouches[0].screenY,
          height = $overlay.outerHeight(),
          is_top = touch_start_y <= current_y && overlay.scrollTop === 0,
          is_bottom = touch_start_y >= current_y && overlay.scrollHeight - overlay.scrollTop === height;
      
      if (is_top || is_bottom) {
        event.preventDefault();
      }
    });
    
    $('html, body').css('overflow', 'hidden');
    
    if (scrollbar_width) {
      $html.css('padding-right', scrollbar_width);
    }
    
    $overlay.fadeIn(300);
  });

  var closeModal = function() {
    $body.removeAttr('style');
    $window.off('touchmove.noscroll');
    
    $overlay.animate({
      opacity: 0
    }, 300, function() {
      $overlay.scrollTop(0).hide().removeAttr('style');
      $html.removeAttr('style');
    });
  };

  $overlay.on('click', function(event) {
    if (!$(event.target).closest('.modal').length) {
      closeModal();
    }
  });

  $('.edit__settingButton__close').on('click', function() {
    closeModal();
  });

});


