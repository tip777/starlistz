// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require jquery_ujs
//= require turbolinks
//= require select2
//= require cocoon
//= require_tree .

// turbolinks対応文
// $(document).on('turbolinks:load', function() {
//   ...your javascript goes here...
// });

$(document).on('turbolinks:load', function() {
  var h = $('nav').outerHeight();
    console.log(h);
    $('body').css('padding-top',h);
    
    //select2 option
    $(".js-multiple").select2({
        width:      200
    });

    $(".js-hide-search").select2({
        minimumResultsForSearch: Infinity,
        width:      150
    });

    $('.genre-search').change(function() {
        console.log("yeah man");
    });
});

// $(function() {

  //セレクトボックスが切り替わったら発動
  // $('#user_name').change(function() {
  //   var check;
  //   var result = $.ajax({
  //       type: 'GET',
  //       url: '/users/sign_in',
  //       async: false
  //   }).responseText;
  //   return check;
  //
  //   console.log(check);
  // });

//   $('#user_name').change(function test(){
//       return $.ajax({
//         type: 'GET',
//         url: '/name_check',
//         data: {content : $("#user_name ").text()},
//         datatype: "html"
//       }).done(function(result) {
//           console.log(result);
//       }).fail(function(result) {
//           console.log("失敗");
//       });
//   });
//
// });

//var result = test() //ちゃんと返り値が入ってる;

$(document).on('turbolinks:load', function() {
  $('.menu-button').on('click', function(){
    $('body').toggleClass("sp-menu-open");
  });
});


//user edit ジャンルselectbox用
// $(document).ready(function() {
//   $('.js-tags-input').each(function() {
//     $(this).select2({
//       tags: true,
//       tokenSeparators: [','],
//       theme: 'bootstrap',
//       width: '100%',
//       placeholder: 'Separated by comma'
//       });
//     });
// });

$(document).on('turbolinks:load', function() {
  $('.js-tags-input').each(function() {
    $(this).select2({
      tags: true,
      tokenSeparators: [','],
      theme: 'bootstrap',
      width: '100%',
      placeholder: 'Separated by comma'
      });
    });
});

$(window).on('scroll',function(){
s = $(window).scrollTop();
if(s < 10){
  $('.navbar-fixed-top').removeClass('is-fixed');
} else {
  $('.navbar-fixed-top').addClass('is-fixed');
}
});



