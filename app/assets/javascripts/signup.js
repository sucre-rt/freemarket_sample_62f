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

// パスワードを表示する
$(function(){
  let swow_password_box = $(".user-form__content__password__check__show")

  function showPassword(password) {
    let html = `<span class="form-password-revelation-revealed-password">${ password }</span>`
    swow_password_box.append(html)
  }

  // パスワードの取得表示
  $('#user_password').on("keyup", function(e) {
    e.preventDefault();
    swow_password_box.empty();
    let password = $("#user_password").val();
    if (password.length !== 0) {
      showPassword(password)
    }
  });

  // 表示非表示、チェックボックスカラー
  let password_show_box = $('.user-form__content__password__check__show');
  $('#password-check').click(function(){
    password_show_box.toggle();
    let check_mark = ('#password-check-mark')
    if (password_show_box.is(':visible')) {
      $(check_mark).css('background-color', '#0099e8');
    } else {
      $(check_mark).css('background-color', '#fff');
    }
  });
});