// 生年月日取得
$(function(){
  $('.user-form__content__group__user-select').find('.user-select-default').change(function(){
    let year = $('#user-birthday-year').val();
    let month = $('#user-birthday-month').val();
    let day = $('#user-birthday-day').val();
    let birthday = year + month + day
    $('#user_birthday').val(birthday)
  });
})

// カード情報の取得
// $(function(){

//   Payjp.setPublicKey('pk_test_34d7bf26ffb0a19c8c6ad2e1'); // payjp公開鍵

//   let form = $("#signup-card-form");

//   $(form).on("click", "#signup-token-submit", function(e){
//     e.preventDefault();
//     form.find("input[type=submit]").prop("disabled", true);

//     let card = {
//       number:     parseInt($("#signup-card-number").val()), // 入力されたカード情報の文字列を整数に変換して取得
//       exp_month:  parseInt($("#signup-exp-month").val()),
//       exp_year:   parseInt($("#signup-exp-year").val()),
//       cvc:        parseInt($("#signup-cvc").val())
//     };
//   })

// })