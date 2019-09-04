$(function() {
  // 検索結果リストの親要素(div)を取得
  var search_list = $("#user-search-result");
  // 検索結果を生成
  function appendUser(user){
    var html = `<div class="chat-group-user clearfix">
    <p class="chat-group-user__name">${ user.name }</p>
    <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${ user.id }" data-user-name="${ user.name }">追加</div>
  </div>`
    // 検索結果リストに作成したhtmlを追加
    search_list.append(html);
  }

  // 検索結果リストの再描画（メッセージ表示）
  function appendErrMsgToHTML(msg) {
    var html = `<div class="chat-group-user clearfix">
    <p class="chat-group-user__name">${ msg }</p>
  </div>`
    // 検索結果リストに作成したhtmlを追加
    search_list.append(html);
  }
  
  // テキストフィールドでキーが離れた時
  $('#user-search-field').on("keyup", function() {
    // その時点で入力されているテキストボックスの値を取得
    var input = $("#user-search-field").val();
    // 非同期通信
    console.log(input);
    $.ajax({
      url: '/users',
      type: "GET",
      data: {keyword: input},
      dataType: 'json'
    })

    // 非同期通信成功時（DB登録成功時）
    .done(function(users){
      // 検索結果リストを空にする（emptyメソッドで指定したDOM要素の子要素のみを削除する）
      $("#user-search-result").empty();
      // usersが空ではない場合
      if (users.length !== 0) {
        // データの数だけappendUser関数を実行
        users.forEach(function(user){
          appendUser(user);
        });
      }
      else {
        // 検索結果リストを空にする
        $("#user-search-result").empty();
        // usersが空の場合（メッセージを表示する）
        appendErrMsgToHTML("一致するユーザーが見つかりません");
      }
    })

    .fail(function(){
      // アラートメッセージを表示する
      alert('メッセージを入力して下さい')
    })
  })
})