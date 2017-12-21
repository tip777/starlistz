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
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require select2
//= require_tree .
$(function() {
    var h;
    //スマホの場合padding-top足す
    if(!window.matchMedia('(min-width:736px)').matches){
        h = $('#header').height() + 100;
    }else{
        h = $('#header').height();
    }
    $('#page-wrapper').css('padding-top', h);
});
//= require turbolinks
//= require_tree .

$(function() {
    //header padding-top
    // var h;
    // h = $('#header').height();
    // $('#page-wrapper').css('padding-top', h);

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
