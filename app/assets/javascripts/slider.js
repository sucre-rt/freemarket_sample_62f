var timer, timer2;
var slider, items;

$(function(){
  slider = $(".main__slider__contents");
  items = slider.find(".main__slider__contents__item");
  buttonLeft = $(".main__slider__controller__button-left");
  buttonRight = $(".main__slider__controller__button-right");

  slider.css("width", items.length * 100 + "vw");

  buttonLeft.on("click", leftSlide);
  buttonRight.on("click", rightSlide);

  //autoSlide();

  function leftSlide() {
    if(!slider.hasClass("right-sliding") && !slider.hasClass("left-sliding")) {
      //clearTimeout(timer);
      slider.addClass("right-sliding");

      timer2 = setTimeout(function() {
        items = slider.find(".main__slider__contents__item");
        $(items[items.length - 1]).prependTo(slider);
        slider.removeClass("right-sliding");
      }, 1000);
    }
  }

  function rightSlide() {
    if(!slider.hasClass("right-sliding") && !slider.hasClass("left-sliding")) {
      //clearTimeout(timer);
      slider.addClass("left-sliding");

      timer2 = setTimeout(function() {
        items = slider.find(".main__slider__contents__item");
        $(items[0]).appendTo(slider);
        slider.removeClass("left-sliding");
      }, 1000);
    }
  }

  function autoSlide() {
    timer = setInterval(function() {
      rightSlide();
    }, 3000);
  }
});
