$(function(){
  $('.image-list').hover(
    function(){
      $(this).addClass('image-list-active')
      let img = $(this).children('img').attr('src');
      $('.product-box-content__product-main-content__product-image__big').children('img').attr("src",img);
    },
    function(){
      $(this).removeClass('image-list-active')
    }
  );
})