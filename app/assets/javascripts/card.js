$(function(){

  Payjp.setPublicKey('pk_test_34d7bf26ffb0a19c8c6ad2e1'); // payjp公開鍵

  let form = $("#card-form");

  $(form).on("click", "#card-token-submit", function(e){
    e.preventDefault();
    form.find("input[type=submit]").prop("disabled", true); // submitボタンを無効にし直接アプリに値が送られてくるのを防ぐ
    // ユーザーが入力したデータからカードを作成
    let card = {
      number:     parseInt($("#card-number").val()), // 入力されたカード情報の文字列を整数に変換して取得
      exp_month:  parseInt($("#card-exp-month").val()),
      exp_year:   parseInt($("#card-exp-year").val()),
      cvc:        parseInt($("#card-cvc").val())
    };

    // payjpサーバーと通信させ、トークンを作成
    Payjp.createToken(card, function(status, response){

      if (status == 200) {    // 通信に成功した場合

        $("#card-number").removeAttr("name");
        $("#card-exp-month").removeAttr("name");
        $("#card-exp-year").removeAttr("name");
        $("#card-cvc").removeAttr("name");          // DBに値が入らないように削除させる

        let token = response.id;      // response.idでtokenのidが取れる
        $(form).append($('<input type="hidden" name="payjp_token" class="payjp-token" />').val(token));
          // コントローラにトークンIDを渡すためのinputタグを挿入。コントローラ側でparamsとして取得できる

        $(form).get(0).submit();    // 初期化していたsubmitのイベントを実行させる

      } else {    // payjpとの通信に失敗した場合

        alert("カードの登録に失敗しました");
        form.find("input[type=submit]").prop("disabled", false);  // ページを更新しなくても再度入力を行えるようにする

      };
    });
  });
})