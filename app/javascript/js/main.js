
(function(a) {
    a(window).on("load", function() {
        a("#preloader").addClass("loaded")
    });
    a(".cencel-preloader").on("click", function(i) {
        i.preventDefault();
        if (!(a("#preloader").hasClass("loaded"))) {
            a("#preloader").addClass("loaded")
        }
    });
    if (a(".search-wrap").length > 0) {
        var g = true;
        a(".searchIcon").on("click", function(i) {
            i.preventDefault();
            if (g) {
                a(".search-wrap").fadeIn("slow");
                g = false
            } else {
                a(".search-wrap").fadeOut("slow");
                g = true
            }
        });
        a(document).on("mouseup", function(j) {
            var i = a(".search-inner");
            if (!i.is(j.target) && i.has(j.target).length === 0) {
                a(".search-wrap").fadeOut("slow");
                g = true
            }
        })
    }
    if (a("#navigation1").length > 0) {
        a("#navigation1").navigation({
            effect: "fade",
            mobileBreakpoint: 992,
        });
        if (a(".scrolls").length > 0) {
            a(".scrolls").on("click", function() {
                a("html, body").animate({
                    scrollTop: a(this.hash).offset().top - 100
                }, 1000);
                return false
            })
        }
    }
    if (a(".xs-modal-popup").length > 0) {
        a(".xs-modal-popup").magnificPopup({
            type: "inline",
            fixedContentPos: false,
            fixedBgPos: true,
            overflowY: "auto",
            closeBtnInside: false,
            mainClass: "mfp-fade",
            callbacks: {
                beforeOpen: function() {
                    this.st.mainClass = "my-mfp-slide-bottom xs-promo-popup"
                }
            }
        })
    }

    // function h() {
    //     var j = new Date("2018-8-17");
    //     var m = new Date();
    //     var o = j - m;
    //     var i = Math.floor(o / 1000 / 60 / 60 / 24);
    //     var k = Math.floor((o / 1000 / 60 / 60) - (i * 24));
    //     var l = Math.floor((o / 1000 / 60) - (i * 24 * 60) - (k * 60));
    //     var n = Math.floor((o / 1000) - (i * 24 * 60 * 60) - (k * 60 * 60) - (l * 60));
    //     if (k < "10") {
    //         k = "0" + k
    //     }
    //     if (l < "10") {
    //         l = "0" + l
    //     }
    //     if (n < "10") {
    //         n = "0" + n
    //     }
    //     a("#xs_days").html(i);
    //     a("#xs_hours").html(k);
    //     a("#xs_minuts").html(l);
    //     a("#xs_second").html(n)
    // }
		
    // setInterval(function() {
    //     h()
    // }, 1000);
		
    a(".xs-video").magnificPopup({
        type: "iframe",
    });
 //    if (a("#myChart").length > 0) {
	// 		var c = document.getElementById("myChart").getContext("2d");
	// 		var e = new Chart(c,{
	// 				type: "doughnut",
	// 				data: {
	// 						labels: ["Community", "Reserved Fund", "Advisor Team", "Sold Globaly"],
	// 						datasets: [{
	// 								data: [10, 8, 12, 70],
	// 								backgroundColor: ["#ae31d9", "#f18b7e", "#5db7fa", "#26d7e5"],
	// 								borderColor: ["#02014c", "#02014c", "#56a7f9", "#56a7f9"],
	// 								borderWidth: 0,
	// 						}]
	// 				},
	// 				options: {
	// 						legend: {
	// 								display: false,
	// 						}
	// 				}
	// 		})
	// }
	// if (a("#myChartTwo").length > 0) {
	// 	var d = document.getElementById("myChartTwo").getContext("2d");
	// 	var f = new Chart(d,{
	// 			type: "doughnut",
	// 			data: {
	// 					labels: ["Community", "Reserved Fund", "Advisor Team", "Sold Globaly"],
	// 					datasets: [{
	// 							data: [10, 8, 12, 70],
	// 							backgroundColor: ["#c13cbd", "#4a8df8", "#26d7e5", "#ef7b7e"],
	// 							borderColor: ["#02014c", "#02014c", "#56a7f9", "#ef7b7e"],
	// 							borderWidth: 0
	// 					}]
	// 			},
	// 			options: {
	// 					legend: {
	// 							display: false,
	// 					}
	// 			}
	// 	})
	// }
    if (a(".offset-side-bar").length > 0) {
        a(".offset-side-bar").on("click", function(i) {
            i.preventDefault();
            i.stopPropagation();
            a(".cart-group").addClass("isActive")
        })
    }
    if (a(".close-side-widget").length > 0) {
        a(".close-side-widget").on("click", function(i) {
            i.preventDefault();
            a(".cart-group").removeClass("isActive")
        })
    }
    if (a(".navSidebar-button").length > 0) {
        a(".navSidebar-button").on("click", function(i) {
            i.preventDefault();
            i.stopPropagation();
            a(".info-group").addClass("isActive")
        })
    }
    if (a(".close-side-widget").length > 0) {
        a(".close-side-widget").on("click", function(i) {
            i.preventDefault();
            a(".info-group").removeClass("isActive")
        })
    }
    a("body").on("click", function(i) {
        a(".info-group").removeClass("isActive");
        a(".cart-group").removeClass("isActive")
    });
    a(".xs-sidebar-widget").on("click", function(i) {
        i.stopPropagation()
    });
    // a(window).on("scroll", function() {
    //     if (a(window).scrollTop() > 4000) {
    //         a(".BackTo").fadeIn("slow")
    //     } else {
    //         a(".BackTo").fadeOut("slow")
    //     }
    // });
    // a("body, html").on("click", ".BackTo", function(i) {
    //     i.preventDefault();
    //     a("html, body").animate({
    //         scrollTop: 0
    //     }, 800)
    // });
    // if (a(window).width() > 767) {
    //     a(".BackTo").css("display", "none")
    // }
    if (a("#client-slider").length > 0) {
        var b = a("#client-slider");
        b.owlCarousel({
            items: 5,
            mouseDrag: true,
            touchDrag: true,
            dots: true,
            loop: true,
            autoplay: true,
            autoplayTimeout: 2000,
            autoplayHoverPause: true,
            smartSpeed: 800,
            responsive: {
                0: {
                    items: 2,
                },
                480: {
                    items: 2,
                },
                768: {
                    items: 4,
                },
                991: {
                    items: 5,
                }
            }
        })
    }
    a(window).on("load", function() {
        a("#particles-js").length && particlesJS("particles-js", {
            particles: {
                number: {
                    value: 28
                },
                color: {
                    value: ["#0182cc", "#00befa", "#0182cc"]
                },
                shape: {
                    type: "circle"
                },
                opacity: {
                    value: 1,
                    random: !1,
                    anim: {
                        enable: !1
                    }
                },
                size: {
                    value: 3,
                    random: !0,
                    anim: {
                        enable: !1
                    }
                },
                line_linked: {
                    enable: !1
                },
                move: {
                    enable: !0,
                    speed: 2,
                    direction: "none",
                    random: !0,
                    straight: !1,
                    out_mode: "out"
                }
            },
            interactivity: {
                detect_on: "canvas",
                events: {
                    onhover: {
                        enable: !1
                    },
                    onclick: {
                        enable: !1
                    },
                    resize: !0
                }
            },
            retina_detect: !0
        })
    });
		
    a(function() {
        var i = new WOW({
            boxClass: "wow",
            animateClass: "animated",
            offset: 0,
            mobile: false,
            live: true,
            scrollContainer: null,
        });
        i.init()
    });
		
    a(window).on("scroll", function() {
        if (a(window).scrollTop() > 100) {
            a(".header").addClass("fixed-header animated fadeInDown")
        } else {
            a(".header").removeClass("fixed-header animated fadeInDown")
        }
        if (a(window).width() < 991) {
            a(".header").removeClass("fixed-header animated fadeInDown")
        }
    })
})(jQuery);