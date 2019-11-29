$(function(){
  var cover = $(".main__cover");
  var container = $(".main__cover__container");
  var items = $(".main__cover__container__item");
  var buttonLeft = $(".main__cover__controller__button-left");
  var buttonRight = $(".main__cover__controller__button-right");
  var timer;

  autoSlide();
  buttonRight.on("click", slideLeft);
  buttonLeft.on("click", slideRight);

  container.hover(
    function() {
      container.addClass("hover");
    },
    function() {
      container.removeClass("hover");
    }
  );

  function autoSlide() {
    timer = setTimeout(function() {
      if(!container.hasClass("hover")) {
        slideLeft();
      }
      autoSlide();
    }, 3000);
  }

  function slideLeft() {
    if(!container.hasClass("sliding-left") && !container.hasClass("sliding-right")) {
      container.addClass("sliding-left");
      setTimeout(function() {
        items = $(".main__cover__container__item");
        items.eq(0).appendTo(container);
        container.removeClass("sliding-left");
      }, 500);
    }
  }

  function slideRight() {
    if(!container.hasClass("sliding-left") && !container.hasClass("sliding-right")) {
      container.addClass("sliding-right");
      setTimeout(function() {
        items = $(".main__cover__container__item");
        items.eq(0).appendTo(container);
        container.removeClass("sliding-right");
      }, 500);
    }
  }
});
