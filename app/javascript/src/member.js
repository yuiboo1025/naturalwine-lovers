//member一覧ページ　列でクリックできるよう記述 
  window.onload = function() { //HTMLを読み込んでからscriptを読み込む
    $(".member_index_tbody_td").on('click', function() {
      window.location = $(this).data("href");
    });
  }