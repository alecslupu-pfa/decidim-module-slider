document.addEventListener("DOMContentLoaded", function(event) {
    let masterLanguageChooser = document.querySelector(".master-language-chooser");
    masterLanguageChooser.addEventListener("change", function() {
        let text = this.options[this.selectedIndex].text;

        let languageChange = document.querySelectorAll(".language-change");
        languageChange.forEach(function(item) {
            Array.from(item.children).filter(function (child) {
                return child.text == text;
            }).forEach(function (selected) {
                let tabList = selected.parentNode;
                let card = tabList.parentNode.parentNode.parentNode;

                card.querySelector(`div[data-tabs-content="${tabList.id}"]`).querySelector(".is-active").classList.remove("is-active");
                card.querySelector(selected.value).classList.add("is-active");
                for (var i = 0; i< tabList.options.length; i++){
                    if (tabList.options[i].text == text) {
                        tabList.selectedIndex = i;
                        break;
                    }
                }
            });
        });

        document.querySelectorAll(".tabs-title").forEach(function(item){
            Array.from(item.children).filter(function(child){
                return child.text == text;
            }).forEach(function(selected){
                let tabList = selected.parentNode.parentNode;
                let card = tabList.parentNode.parentNode;

                card.querySelector(`div[data-tabs-content="${tabList.id}"]`).querySelector(".is-active").classList.remove("is-active");
                card.querySelector(selected.getAttribute("href")).classList.add("is-active");
                let currentActiveTab = tabList.querySelector(".tabs-title.is-active");
                currentActiveTab.classList.remove("is-active");
                currentActiveTab.querySelector("a").removeAttribute("aria-selected");
                selected.parentNode.classList.add("is-active");
            });
        });
    });
});