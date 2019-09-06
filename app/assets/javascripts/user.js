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

    // テキストボックスに値が存在する場合
    if (input) {
      // 非同期通信
      console.log(input);
      $.ajax({
        url: '/users',
        type: "GET",
        data: {keyword: input},
        dataType: 'json'
      })

      // 非同期通信成功時（DB検索成功時）
      .done(function(users){
        console.log(users);
        // 検索結果リストを空にする（子要素のみ削除される）
        $("#user-search-result").empty();

        // 検索結果が空ではない場合
        if (users.length !== 0) {
          // データの数だけappendUser関数を実行
          users.forEach(function(user){
            appendUser(user);
          });
        }  else {
          // 検索結果が空の場合（メッセージを表示する）
          appendErrMsgToHTML("一致するユーザーが見つかりません");
        }
      })

      // 非同期通信失敗時（DB検索成功時）
      .fail(function(){
        // アラートメッセージを表示する
        alert('ユーザー検索に失敗しました')
      })

    } else {
      // テキストボックスに値が存在しない場合
      // 検索結果リストを空にする
      $("#user-search-result").empty();
    }
  })


  // メンバーリストの親要素(div)を取得
  var member_list = $("#chat-group-users");
  // カレントユーザー部分の要素を取得
  var current_user = $("#chat-group-users").children();

  // 追加するユーザーのhtmlを生成
  function appendMember(add){
    var html = `<div class="chat-group-user clearfix">
    <p class="chat-group-user__name">${ add.userName }</p>
    <div class="user-search-remove chat-group-user__btn chat-group-user__btn--remove" data-user-id="${ add.userId }" data-user-name="${ add.userName }">削除</div>
    </div>`
    // メンバーリストに作成したhtmlを追加
    member_list.append(current_user);
    member_list.append(html);
  }
  // 追加ボタン押下時のイベント
  $(document).on("click", ".chat-group-user__btn--add", function() {
    var member = $(this).data();
    console.log(member);

    // 検索結果リストを空にする（子要素のみ削除される）
    $("#chat-group-users").empty();
    // チャットメンバーに選択したユーザーを追加する
    appendMember(member);
    // 検索結果リストから選択したユーザーを削除する
    $(this).parent().remove();
  })

  //   // 削除ボタン押下時のイベント
  // $('.chat-group-user__btn--remove').on("click", function() {
  //   // チャットメンバーから選択したユーザーを削除する
  //   // 再度キーワード検索を実施する
  // })
})