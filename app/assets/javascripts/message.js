$(function() {
  // 取得したデータを元にmessage部分のhtmlを生成する
  function buildHTML(message){
      var html = `<div class="message">
                    <div class="message__upper-info">
                      <p class="message__upper-info__talker">
                        ${ message.user_name }
                      </p>
                      <p class="message__upper-info__data">
                        ${ message.time }
                      </p>
                    </div>
                    <div class="message__lower-info">`;
    // テキストが存在した場合追加
    if (message.text) {
      html = html.concat (`                      <p class="message__lower-info__text">${ message.text }</p>`);
    } 
    // 画像が存在した場合追加
    if (message.image) {
      html  = html.concat (`                      <img class="message__lower-info__image" src="${ message.image }" alt="${ message.image }">`);
    }
    // 閉じタグ
    html  = html.concat (`                    </div>
    </div>`);

    return html;
  }

  // メッセージが追加された分だけ下にスクロールさせる
  function scroll() {
    $('.messages').animate({scrollTop: $('.messages')[0].scrollHeight});
  }

  // フォームの送信ボタンが押下された時
  $('#new_message').on('submit', function(e) {
    // デフォルトのイベントを中止する（同期通信防止）
    e.preventDefault();
    // フォームから送信された内容を保持するインスタンス生成
    var formData = new FormData(this);
    // フォームのactionの価を取得しurlへ代入
    var url = $(this).attr('action');

    // 非同期通信
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      // オブジェクトをクエリ文字に変換しない
      processData: false,
      // ファイル形式の上書きを許可しない
      contentType: false
    })
    // 非同期通信成功時（DB登録成功時）
    .done(function(data){
      // メッセージ表示部分のhtmlを生成
      var html = buildHTML(data);
      // class="message"内に作成したhtmlを追記する
      $('.messages').append(html);

      // フォームの初期化
      $('.new_message')[0].reset();
      // 送信ボタンが押された状態を解除する
      $('.submit-btn').prop('disabled', false);

      // スクロールの処理を実行する
      scroll()
    })
    .fail(function(){
      // アラートメッセージを表示する
      alert('メッセージを入力して下さい')
      $('.submit-btn').prop('disabled', false);
    })
  })
})