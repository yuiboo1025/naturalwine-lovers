
//wine_indexのタブ表示
    //ページを開くときに実行されるように記載
    $(function() {
    //初期設定で表示されるのはtab-Allのコンテンツだけにして、それ以外の内容は非表示にする
      $('#tab-contents .tab[id != "tab-All"]').hide();
    
    　　//id="tab-menu"のaタグがクリックされたときに、処理を実行
      $('#tab-menu a').on('click', function(event) {
        //id="tab-contents"内のいずれかのタブがクリックされたときに、そのタブ内の全コンテンツをいったん非表示
        $("#tab-contents .tab").hide();
        //activeクラスを削除する(CSSを対応させるため)
        $("#tab-menu .active").removeClass("active");
        //$(this)のとき(タブがクリックされたとき)activeクラスを追加する
        $(this).addClass("active");
        //href属性を取得し、取得したhref属性の中身を表示
        $($(this).attr("href")).show();
        event.preventDefault();
      });
      
    });