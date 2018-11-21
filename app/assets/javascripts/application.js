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
// require turbolinks
//= require select2
//= require jquery-ui
//= require cocoon
//= require google_analytics
//= require_tree .

// turbolinks対応文
// $(document).on('turbolinks:load', function() {
//   ...your javascript goes here...
// });


  // グロバールナビゲーション選択ページの判定
  var url = window.location.pathname;
  $('.nav li a[href="'+url+'"]').parents('.collapse-down').addClass('active');

  if ( url.match(/chart/)) {
            $('.nav li a[ href *= "chart" ]').parents('.collapse-down').addClass('active');
  //strにhogeを含む場合の処理
  }

$(document).ready(function(){
  $('.js-tags-input').each(function() {
    $(this).select2({
      language: {"noResults": function(){ return "";}},
      escapeMarkup: function (markup) { return markup; },
      tags: true,
      tokenSeparators: [','],
      theme: 'bootstrap',
      width: '100%',
      placeholder: 'Separated by comma'
    });
  });

  //select2 setting
  $(".js-search").select2({
      language: {"noResults": function(){ return "";}},
      escapeMarkup: function (markup) { return markup; },
      width: 200
  });
  $(".js-hide-search").select2({
      language: {"noResults": function(){ return "";}},
      escapeMarkup: function (markup) { return markup; },
      minimumResultsForSearch: Infinity,
      width: 100
  });

  $(".js-search").val($(".js-search").val()).trigger("change");//genre set value

  $('.select-main').on('change', param_change);

  $('.js-search').on('change', param_change);

  //select tag parameter send
  function param_change () {
      var genre = ""
      if (!$(".js-search").val()){
        genre = "All"
      }else{
        genre = $(".js-search").val();
      }
      var url = 'sort=' + $('.select-main').val();
      url = url + '&genre=' + genre
      window.location.search = url
  }
  
  // プレイリスト売上画面の年を設定
  $('.select-year').on('change', param_year_change);
  //パラメーターに年月を渡す
  function param_year_change () {
      var url = 'year=' + $('.select-year').val();
      window.location.search = url
  }
  
});

$(document).ready(function(){
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
      $('.stripe-button-el').trigger('click');
    }
    console.log(gon.current_user);
    e.preventDefault();
  });
});

// モーダル表示　複数対応
$(document).ready(function(){

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
