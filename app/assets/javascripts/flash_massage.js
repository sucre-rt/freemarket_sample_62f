$(function(){
  // フェードアウト
  setTimeout("$('.flash-message').fadeOut('slow')", 1500);

  // 表示を消す
  $('.fa-times').click(function(){
    $('.flash-message').remove();
  })
})
