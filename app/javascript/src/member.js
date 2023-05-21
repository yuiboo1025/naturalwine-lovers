//member一覧ページ　列でクリックできるよう記述 
  window.onload = function() { //HTMLを読み込んでからscriptを読み込む
    $(".member_index_tbody_td").on('click', function() {
      window.location = $(this).data("href");
    });
  }
  
  //JavaScriptでページ遷移をするには、window.locationオブジェクトを使います。
  //「this」は、イベントが発生した要素のみ変化させたいときに使います。
  //data()メソッドを実行することですべてのdata属性が取得できる
  