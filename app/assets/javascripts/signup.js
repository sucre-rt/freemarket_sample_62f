$(function(){

  // 生年月日取得
  $('.user-form__content__group__user-select').find('.user-select-default').change(function(){
    let year = $('#user-birthday-year').val();
    let month = $('#user-birthday-month').val();
    let day = $('#user-birthday-day').val();
    let birthday = year + month + day
    $('#user_birthday').val(birthday)
  });

})