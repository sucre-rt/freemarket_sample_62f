$(function(){

  let birthday = []

  $('#user-birthday-year').change(function(){
    let year = $("option:selected").val();
    // birthday.push(year)
    // $('#user_birthday').val(year);
  });
  $('#user-birthday-month').change(function(){
    let month = $("option:selected").val();
    // birthday.push(month)
    // $('#user_birthday').val(birthday.join(','));
  });
  $('#user-birthday-day').change(function(){
    let day = $("option:selected").val();
    // birthday.push(day)
  })
  console.log(year);
  let user_birthday = birthday.join(',');
  $('#user_birthday').val(user_birthday);
})