# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true

pin "jquery321", to: "js/jquery-3.2.1.min.js"
pin "jquery_magnific", to: "js/jquery.magnific-popup.min.js"
pin "owl_Carousel", to: "js/owl.carousel.min.js"
pin "navigation", to: "js/navigation.js"
pin "jquery_appear", to: "js/jquery.appear.min.js"
pin "wow_min", to: "js/wow.min.js"
pin "chart", to: "js/chart.min.js"
pin "particles", to: "js/particles.min.js"
pin "smooth_scroling", to: "js/smooth-scroling.js"
pin "main", to: "js/main.js"

