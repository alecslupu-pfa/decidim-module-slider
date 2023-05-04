$(() => {
    $("*[data-skip-when-finished]").each(function (index, elemet) {
        elemet.addEventListener('ended', function () {
            document.querySelector('.orbit').querySelector(".orbit-next").click();
        });
    });

    $(".orbit-previous").after(`<button class="control" aria-label="button-control">`);
    const plugin = $('.orbit').data("zfPlugin");

    if (typeof (plugin.timer) !== "undefined") {
        $(document.body).on("click", ".orbit-bullets > .control", function () {
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
    }

    window.slidePromises = [];

    $("#slider-block .orbit-previous, #slider-block .orbit-next, #slider-block .orbit-bullets > button")
        .attr('tabindex', 0)
        .on('click.zf.orbit touchend.zf.orbit', function (e) {
            const plugin = $('.orbit').data("zfPlugin");
            if (typeof (plugin.timer) !== "undefined") {
                plugin.options.autoPlay = false;
                plugin.$element.data('clickedOn', true);
                plugin.timer.pause();
            }
        });

    $(".orbit").on("beforeslidechange.zf.orbit", function (event, currentSlide, newSlide) {
        var currentVideo = currentSlide[0].querySelector('video');
        var newVideo = newSlide[0].querySelector('video');
        if (newVideo) {
            slidePromises[newSlide[0].dataset.slide] = newVideo.play();
        }

        if (currentVideo) {
            if (slidePromises[currentSlide[0].dataset.slide] !== undefined) {
                slidePromises[currentSlide[0].dataset.slide].then(_ => {
                    currentVideo.pause();
                })
                    .catch(error => {
                        // Auto-play was prevented
                        // Show paused UI.
                    });
            }
        }
    });
});
