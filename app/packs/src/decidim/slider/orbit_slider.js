$(() => {
  $(".orbit-previous").after(`<button class="control" aria-label="button-control">`);
  const plugin = $('.orbit').data("zfPlugin");

   $(document.body).on( "click", ".orbit-bullets > .control", function() {
    $(this).toggleClass("pause");

    if ($(this).hasClass("pause")) {
      plugin.options.autoPlay = false;
      plugin.$element.data('clickedOn', true);
      plugin.timer.pause();
    } else {
      plugin.$element.data('clickedOn', false);
      plugin.options.autoPlay = true;
      plugin.timer.restart();
    }
  });

  $("#slider-block .orbit-previous, #slider-block .orbit-next, #slider-block .orbit-bullets > button")
    .attr('tabindex', 0)
    .on('click.zf.orbit touchend.zf.orbit', function (e) {
      const plugin = $('.orbit').data("zfPlugin");
      plugin.options.autoPlay = false;
      plugin.$element.data('clickedOn', true);
      plugin.timer.pause();
    });

    $(".orbit").on("beforeslidechange.zf.orbit", function (event, currentSlide, newSlide) {
        if (currentSlide.find("video").length > 0){
            currentSlide.find("video")[0].pause();
        }
        if (newSlide.find("video").length > 0){
            newSlide.find("video")[0].play();
        }
    });
});
