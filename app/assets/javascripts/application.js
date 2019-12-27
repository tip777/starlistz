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
  
  //list new width200px
  $(".js-hide-search_listprice").select2({
      language: {"noResults": function(){ return "";}},
      escapeMarkup: function (markup) { return markup; },
      minimumResultsForSearch: Infinity,
      width: 200
  });

  $(".js-search").val($(".js-search").val()).trigger("change");//mood set value

  $('.select-main').on('change', param_change);

  $('.js-search').on('change', param_change);

  //select tag parameter send
  function param_change () {
      var mood = ""
      if (!$(".js-search").val()){
        mood = "All"
      }else{
        mood = $(".js-search").val();
      }
      var url = 'sort=' + $('.select-main').val();
      url = url + '&mood=' + mood
      window.location.search = url
  }
  
  // プレイリスト売上画面の年を設定
  $('.select-year').on('change', param_year_change);
  //パラメーターに年月を渡す
  function param_year_change () {
      var url = 'year=' + $('.select-year').val();
      window.location.search = url
  }
  
  // オンボーディング用
  var walkthrough;
  walkthrough = {
    index: 0,
    nextScreen: function() {
      if (this.index < this.indexMax()) {
        this.index++;
        return this.updateScreen();
      }
    },
    prevScreen: function() {
      if (this.index > 0) {
        this.index--;
        return this.updateScreen();
      }
    },
    updateScreen: function() {
      this.reset();
      this.goTo(this.index);
      return this.setBtns();
    },
    setBtns: function() {
      var $lastBtn, $nextBtn, $prevBtn;
      $nextBtn = $('.next-screen');
      $prevBtn = $('.prev-screen');
      $lastBtn = $('.finish');
      if (walkthrough.index === walkthrough.indexMax()) {
        $nextBtn.prop('disabled', true);
        $prevBtn.prop('disabled', false);
        return $lastBtn.addClass('active').prop('disabled', false);
      } else if (walkthrough.index === 0) {
        $nextBtn.prop('disabled', false);
        $prevBtn.prop('disabled', true);
        return $lastBtn.removeClass('active').prop('disabled', true);
      } else {
        $nextBtn.prop('disabled', false);
        $prevBtn.prop('disabled', false);
        return $lastBtn.removeClass('active').prop('disabled', true);
      }
    },
    goTo: function(index) {
      $('.screen').eq(index).addClass('active');
      return $('.dot').eq(index).addClass('active');
    },
    reset: function() {
      return $('.screen, .dot').removeClass('active');
    },
    indexMax: function() {
      return $('.screen').length - 1;
    },
    openModal: function() {
      $('.walkthrough, .shade').addClass('showframe');
      setTimeout((() => {
        return $('.walkthrough, .shade').addClass('reveal');
      }), 200);
      return this.updateScreen();
    }
  };
  $('.next-screen').click(function() {
    return walkthrough.nextScreen();
  });
  $('.prev-screen').click(function() {
    return walkthrough.prevScreen();
  });
  walkthrough.openModal();
  
  // Optionally use arrow keys to navigate walkthrough
  return $(document).keydown(function(e) {
    switch (e.which) {
      case 37:
        // left
        walkthrough.prevScreen();
        break;
      case 38:
        // up
        break;
      case 39:
        // right
        walkthrough.nextScreen();
        break;
      case 40:
        // down
        break;
      default:
        return;
    }
    e.preventDefault();
  });

  

  function execCopy(string){

    
  }
  
  
  
});

$(document).ready(function(){
  
  // 曲説明のコピーボタンを押した時
  $('.clipbtn').on('click', function(e){

    // 曲名、アーティスト名取得
    var docModal = $(this).closest('.modal-content');
    var songName = docModal.find(".modal_song")[0].textContent;
    var artistName = docModal.find(".modal_artist")[0].textContent;
    
    // 空div 生成
    var tmp = document.createElement("div");
    // 選択用のタグ生成
    var pre = document.createElement('pre');

    // 親要素のCSSで user-select: none だとコピーできないので書き換える
    pre.style.webkitUserSelect = 'auto';
    pre.style.userSelect = 'auto';

    tmp.appendChild(pre).textContent = artistName + " " + songName;

    // 要素を画面外へ
    var s = tmp.style;
    s.position = 'fixed';
    s.right = '200%';

    // body に追加
    document.body.appendChild(tmp);
    // 要素を選択
    document.getSelection().selectAllChildren(tmp);

    // クリップボードにコピー
    var result = document.execCommand("copy");

    // 要素削除
    document.body.removeChild(tmp);

    // ボタンのテキスト変更
    $(this)[0].innerHTML = "<i class=\"material-icons\">file_copy</i>コピーしました";

    // ２秒後ボタンのテキストを戻す
    setTimeout(() => {
      $(this)[0].innerHTML = "<i class=\"material-icons\">file_copy</i>曲名、アーティスト名をコピー";
    },2000);

    return result;

    
  });

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
