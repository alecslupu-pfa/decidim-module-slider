
document.addEventListener("DOMContentLoaded", function(event) {
    $(".master-language-chooser").change(function (){
        var text = $(this).find(":selected").text();
        $('.language-change').children().filter(function(){
            return this.text == text;
        }).each(function (){
            let $select = $(this).parent();
            $select.val($(this).val());
            let targetTabPaneSelector = $select.val();
            let $tabsContent = $("div[data-tabs-content='" + $select.attr("id") + "']");
            $tabsContent.children(".is-active").removeClass("is-active");
            $(targetTabPaneSelector).addClass("is-active");
        })
    });
})