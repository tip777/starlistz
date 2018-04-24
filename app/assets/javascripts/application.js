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
//= require jquery-ui/widgets/sortable
//= require jquery-ui/effects/effect-highlight
//= require cocoon
//= require_tree .

// turbolinks対応文
// $(document).on('turbolinks:load', function() {
//   ...your javascript goes here...
// });

/*
$(document).on('turbolinks:load', function() {
  var h = $('nav').outerHeight();
    console.log(h);
    $('body').css('padding-top',h);
*/
$(document).on('turbolinks:load', function() {
  var windowWidth = window.innerWidth;
  if (windowWidth > 768) {
    var w = $('nav').outerWidth();
    $('body').css('padding-left',w);
  } else {
    var h = $('nav').outerHeight();
    $('body').css('padding-bottom',h);
  }
  
  $('.menu-button').on('click', function(){
    $('body').toggleClass("sp-menu-open");
  });
  
  // タブの切り替え処理
  $('.tabbox:first').show();
  $('.tab li').click(function() {
    $('.tab li').removeClass('active');
    $(this).addClass('active');
    $('.l-tabbox .tabbox').hide();
    $($(this).find('a').attr('href')).fadeIn();
    return false;
  });
  
  
  // グロバールナビゲーション選択ページの判定
  var url = window.location.pathname;
  $('.nav li a[href="'+url+'"]').parents('.collapse-down').addClass('active');

  if ( url.match(/chart/)) {
            $('.nav li a[ href *= "chart" ]').parents('.collapse-down').addClass('active');
  //strにhogeを含む場合の処理
  }
  



  var windowWidth = window.innerWidth;
  

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

// $(document).on('turbolinks:load', function() {
//   $('.js-tags-input').each(function() {
//     $(this).select2({
//       tags: true,
//       tokenSeparators: [','],
//       theme: 'bootstrap',
//       width: '100%',
//       placeholder: 'Separated by comma'
//     });
//   });
  
//   // $(".js-multiple").select2({
//   //     width:      200
//   // });

//   //select2 setting
//   $(".js-search").select2({
//       width: 200
//   });
//   $(".js-hide-search").select2({
//       minimumResultsForSearch: Infinity,
//       width: 150
//   });

//   $(".js-search").val($(".js-search").val()).trigger("change");//genre set value

//   $('.select-main').on('change', param_change);

//   $('.js-search').on('change', param_change);
  
//   //select tag parameter send
//   function param_change () {
//       var genre = ""
//       if (!$(".js-search").val()){
//         genre = "All"
//       }else{
//         genre = $(".js-search").val();
//       }
//       var url = 'sort=' + $('.select-main').val();
//       url = url + '&genre=' + genre
//       window.location.search = url
//   }
    
// });

$(window).on('scroll',function(){
  s = $(window).scrollTop();
  if(s < 10){
    $('.navbar-fixed-top').removeClass('is-fixed');
  } else {
    $('.navbar-fixed-top').addClass('is-fixed');
  }
});


$(document).on('turbolinks:load', function() {
  var windowWidth = window.innerWidth;
  if (windowWidth > 768) {
  
  $('.menu-trigger').click(function(e){
        $('+ .collapse-down-menu', this).slideToggle(300);
      })
   }else{
  $('.menu-trigger').click(function(e){
  
  var opened = $('+ .collapse-down-menu', this);
  
    if(opened.hasClass("open")){
  opened.removeClass("open");
  } else{
        $('.collapse-down-menu').removeClass("open");
        opened.toggleClass("open");
        return true;
      }
      })
  }

});

$(document).on('turbolinks:load', function() {
  // checkoutの本当のボタンは非表示
  $('.hide_checkout').hide();

  // 購入ボタンクリック時判定
  $('.buy_btn').on('click', function(e){
    if(gon.current_user == null){
      console.log("してない");
      window.location.href = "/users/sign_in"; // 通常の遷移
    }else{
      //$(this).attr("name")　これで番号がとれる
      // $('.stripe-button-el').trigger('click');
      $('#modal-content-' + $(this).attr("name") + ' .stripe-button-el').trigger('click');
    }
    console.log(gon.current_user);
    e.preventDefault();
  });
});

// モーダル表示　複数対応
$(document).on('turbolinks:load', function() {
  
  //グローバル変数
  var nowModalSyncer = null ;   //現在開かれているモーダルコンテンツ
  var modalClassSyncer = "modal-syncer" ;   //モーダルを開くリンクに付けるクラス名
  
  //モーダルのリンクを取得する
  var modals = document.getElementsByClassName( modalClassSyncer ) ;
  
  //モーダルウィンドウを出現させるクリックイベント
  for(var i=0,l=modals.length; l>i; i++){
  
    //全てのリンクにタッチイベントを設定する
    modals[i].onclick = function(){
  
      //ボタンからフォーカスを外す
      this.blur() ;
  
      //ターゲットとなるコンテンツを確認
      var target = this.getAttribute( "data-target" ) ;
  
      //ターゲットが存在しなければ終了
      if( typeof( target )=="undefined" || !target || target==null ){
        return false ;
      }
  
      //コンテンツとなる要素を取得
      nowModalSyncer = document.getElementById( target ) ;
  
      //ターゲットが存在しなければ終了
      if( nowModalSyncer == null ){
        return false ;
      }
  
      //キーボード操作などにより、オーバーレイが多重起動するのを防止する
      if( $( "#modal-overlay" )[0] ) return false ;   //新しくモーダルウィンドウを起動しない
      //if($("#modal-overlay")[0]) $("#modal-overlay").remove() ;   //現在のモーダルウィンドウを削除して新しく起動する
  
      //オーバーレイを出現させる
      $( "body" ).append( '<div id="modal-overlay"></div>' ) ;
      $( "#modal-overlay" ).fadeIn( "fast" ) ;
  
      //コンテンツをセンタリングする
      centeringModalSyncer() ;
  
      //コンテンツをフェードインする
      $( nowModalSyncer ).fadeIn( "slow" ) ;
  
      //[#modal-overlay]、または[#modal-close]をクリックしたら…
      $( "#modal-overlay,#modal-close" ).unbind().click( function() {
  
        //[#modal-content]と[#modal-overlay]をフェードアウトした後に…
        $( "#" + target + ",#modal-overlay" ).fadeOut( "fast" , function() {
  
          //[#modal-overlay]を削除する
          $( '#modal-overlay' ).remove() ;
  
        } ) ;
  
        //現在のコンテンツ情報を削除
        nowModalSyncer = null ;
  
      } ) ;
  
    }
  
  }

  //リサイズされたら、センタリングをする関数[centeringModalSyncer()]を実行する
  $( window ).resize( centeringModalSyncer ) ;

  //センタリングを実行する関数
  function centeringModalSyncer() {

    //モーダルウィンドウが開いてなければ終了
    if( nowModalSyncer == null ) return false ;

    //画面(ウィンドウ)の幅、高さを取得
    var w = $( window ).width() ;
    var h = $( window ).height() ;

    //コンテンツ(#modal-content)の幅、高さを取得
    // jQueryのバージョンによっては、引数[{margin:true}]を指定した時、不具合を起こします。
//    var cw = $( nowModalSyncer ).outerWidth( {margin:true} ) ;
//    var ch = $( nowModalSyncer ).outerHeight( {margin:true} ) ;
    var cw = $( nowModalSyncer ).outerWidth() ;
    var ch = $( nowModalSyncer ).outerHeight() ;

    //センタリングを実行する
    $( nowModalSyncer ).css( {"left": ((w - cw)/2) + "px","top": ((h - ch)/2) + "px"} ) ;

  }

} ) ;


  


