$(function(){
  $('.image-list').hover(
    function(){
      var big = $('.product-box-content__product-main-content__product-image__big');
      var imageList = $(this).addClass('image-list-active');
      var index = imageList.index();

      if(!big.hasClass('sliding')) {
        big.addClass('sliding').animate({
          'scrollLeft': index * 300
        }, {
          'complete': function() {
            big.removeClass("sliding");
          }
        }, 500);
      }
    },
    function(){
      $(this).removeClass('image-list-active')
    }
  );
})
