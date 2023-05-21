// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"
import '@fortawesome/fontawesome-free/js/all'
import "../src/wine.js"
import "../src/member.js"


Rails.start()
//新たなmap情報が読み込まれないため、turbolinks機能をoffにする
//Turbolinks.start()
ActiveStorage.start()

global.$ = jQuery;
window.$ = jQuery;

import Raty from "../src/raty.js"
window.raty = function(elem,opt) {
  let raty =  new Raty(elem,opt)
  raty.init();
  return raty;
}

//フラッシュメッセージがフェードアウトする
//setTimeoutとは、指定した秒数だけ処理の実行を遅らせることのできるJavaScriptのメソッド
$(function() {
  setTimeout("$('.flash-message').fadeOut('slow')", 2000);
});

//headerハンバーガーメニュー
//「this」は、イベントが発生した要素のみ変化させたいときに使います。
$(function() {
  $('.menu-trigger').on('click', function(event) {
    //toggleClass()を設定すると、アイコンがクリックされたときにactiveクラスが追加され、もう一度クリックすると削除されます。
    $(this).toggleClass('active');
    //fadeToggle()は、要素のフェードイン・フェードアウトを切り替えるメソッド
    $('#sp-menu').fadeToggle();
    event.preventDefault();
  });
});