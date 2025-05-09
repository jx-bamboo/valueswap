
(function(a, d, b, c) {
    a.navigation = function(k, s) {
        var j = {
            responsive: true,
            mobileBreakpoint: 767,
            showDuration: 300,
            hideDuration: 300,
            showDelayDuration: 0,
            hideDelayDuration: 0,
            submenuTrigger: "hover",
            effect: "fade",
            submenuIndicator: true,
            submenuIndicatorTrigger: false,
            hideSubWhenGoOut: true,
            visibleSubmenusOnMobile: false,
            overlay: true,
            overlayColor: "rgba(0, 0, 0, 0.7)",
            hidden: false,
            hiddenOnMobile: false,
            offCanvasSide: "left",
            offCanvasCloseButton: true,
            animationOnShow: "",
            animationOnHide: "",
            hideScrollBar: true,
            onInit: function() {},
            onLandscape: function() {},
            onPortrait: function() {},
            onShowOffCanvas: function() {},
            onHideOffCanvas: function() {}
        };
        var t = this,
            g = Number.MAX_VALUE,
            x = 1,
            i = "click.nav touchstart.nav",
            q = "mouseenter focusin",
            p = "mouseleave focusout";
        t.settings = {};
        var e = a(k),
            k = k;
        if (a(k).find(".nav-search").length > 0) {
            a(k).find(".nav-search").find("form").prepend("<span class='nav-search-close-button' tabindex='0'>&#10005;</span>")
        }
        t.init = function() {
            t.settings = a.extend({}, j, s);
            if (t.settings.offCanvasCloseButton) {
                a(k).find(".nav-menus-wrapper").prepend("<span class='nav-menus-wrapper-close-button'>&#10005;</span>")
            }
            if (t.settings.offCanvasSide == "right") {
                a(k).find(".nav-menus-wrapper").addClass("nav-menus-wrapper-right")
            }
            if (t.settings.hidden) {
                a(k).addClass("navigation-hidden");
                t.settings.mobileBreakpoint = 99999
            }
            h();
            a(k).find(".nav-toggle").on("click touchstart", function(A) {
                A.stopPropagation();
                A.preventDefault();
                t.showOffcanvas();
                if (s !== c) {
                    t.callback("onShowOffCanvas")
                }
            });
            a(k).find(".nav-menus-wrapper-close-button").on("click touchstart", function() {
                t.hideOffcanvas();
                if (s !== c) {
                    t.callback("onHideOffCanvas")
                }
            });
            a(k).find(".nav-search-button, .nav-search-close-button").on("click touchstart keydown", function(B) {
                B.stopPropagation();
                B.preventDefault();
                var A = B.keyCode || B.which;
                if (B.type === "click" || B.type === "touchstart" || (B.type === "keydown" && A == 13)) {
                    t.toggleSearch()
                } else {
                    if (A == 9) {
                        a(B.target).blur()
                    }
                }
            });
            a(d).resize(function() {
                t.initNavigationMode(z());
                l();
                if (t.settings.hiddenOnMobile) {
                    n()
                }
            });
            t.initNavigationMode(z());
            if (t.settings.hiddenOnMobile) {
                n()
            }
            if (t.settings.overlay) {
                a(k).append("<div class='nav-overlay-panel'></div>")
            }
            if (a(k).find(".megamenu-tabs").length > 0) {
                f()
            }
            if (s !== c) {
                t.callback("onInit")
            }
        };
        var v = function() {
            a(k).find(".nav-submenu").hide(0);
            a(k).find("li").removeClass("focus")
        };
        var h = function() {
            a(k).find("li").each(function() {
                if (a(this).children(".nav-dropdown,.megamenu-panel").length > 0) {
                    a(this).children(".nav-dropdown,.megamenu-panel").addClass("nav-submenu");
                    if (t.settings.submenuIndicator) {
                        a(this).children("a").append("<span class='submenu-indicator'><span class='submenu-indicator-chevron'></span></span>")
                    }
                }
            })
        };
        var n = function() {
            if (a(k).hasClass("navigation-portrait")) {
                a(k).addClass("navigation-hidden")
            } else {
                a(k).removeClass("navigation-hidden")
            }
        };
        t.showSubmenu = function(A, B) {
            if (z() > t.settings.mobileBreakpoint) {
                a(k).find(".nav-search").find("form").fadeOut()
            }
            if (B == "fade") {
                a(A).children(".nav-submenu").stop(true, true).delay(t.settings.showDelayDuration).fadeIn(t.settings.showDuration).removeClass(t.settings.animationOnHide).addClass(t.settings.animationOnShow)
            } else {
                a(A).children(".nav-submenu").stop(true, true).delay(t.settings.showDelayDuration).slideDown(t.settings.showDuration).removeClass(t.settings.animationOnHide).addClass(t.settings.animationOnShow)
            }
            a(A).addClass("focus")
        };
        t.hideSubmenu = function(A, B) {
            if (B == "fade") {
                a(A).find(".nav-submenu").stop(true, true).delay(t.settings.hideDelayDuration).fadeOut(t.settings.hideDuration).removeClass(t.settings.animationOnShow).addClass(t.settings.animationOnHide)
            } else {
                a(A).find(".nav-submenu").stop(true, true).delay(t.settings.hideDelayDuration).slideUp(t.settings.hideDuration).removeClass(t.settings.animationOnShow).addClass(t.settings.animationOnHide)
            }
            a(A).removeClass("focus").find(".focus").removeClass("focus")
        };
        var w = function() {
            if (t.settings.hideScrollBar) {
                a("body").addClass("no-scroll")
            }
            if (t.settings.overlay) {
                a(k).find(".nav-overlay-panel").css("background-color", t.settings.overlayColor).fadeIn(300).on("click touchstart", function() {
                    t.hideOffcanvas()
                })
            }
        };
        var o = function() {
            if (t.settings.hideScrollBar) {
                a("body").removeClass("no-scroll")
            }
            if (t.settings.overlay) {
                a(k).find(".nav-overlay-panel").fadeOut(400)
            }
        };
        t.showOffcanvas = function() {
            w();
            if (t.settings.offCanvasSide == "left") {
                a(k).find(".nav-menus-wrapper").css("transition-property", "left").addClass("nav-menus-wrapper-open")
            } else {
                a(k).find(".nav-menus-wrapper").css("transition-property", "right").addClass("nav-menus-wrapper-open")
            }
        };
        t.hideOffcanvas = function() {
            a(k).find(".nav-menus-wrapper").removeClass("nav-menus-wrapper-open").on("webkitTransitionEnd moztransitionend transitionend oTransitionEnd", function() {
                a(k).find(".nav-menus-wrapper").css("transition-property", "none").off()
            });
            o()
        };
        t.toggleOffcanvas = function() {
            if (z() <= t.settings.mobileBreakpoint) {
                if (a(k).find(".nav-menus-wrapper").hasClass("nav-menus-wrapper-open")) {
                    t.hideOffcanvas();
                    if (s !== c) {
                        t.callback("onHideOffCanvas")
                    }
                } else {
                    t.showOffcanvas();
                    if (s !== c) {
                        t.callback("onShowOffCanvas")
                    }
                }
            }
        };
        t.toggleSearch = function() {
            if (a(k).find(".nav-search").find("form").css("display") == "none") {
                a(k).find(".nav-search").find("form").fadeIn(200);
                a(k).find(".nav-search").find("input").focus()
            } else {
                a(k).find(".nav-search").find("form").fadeOut(200);
                a(k).find(".nav-search").find("input").blur()
            }
        };
        t.initNavigationMode = function(A) {
            if (t.settings.responsive) {
                if (A <= t.settings.mobileBreakpoint && g > t.settings.mobileBreakpoint) {
                    a(k).addClass("navigation-portrait").removeClass("navigation-landscape");
                    u();
                    if (s !== c) {
                        t.callback("onPortrait")
                    }
                }
                if (A > t.settings.mobileBreakpoint && x <= t.settings.mobileBreakpoint) {
                    a(k).addClass("navigation-landscape").removeClass("navigation-portrait");
                    r();
                    o();
                    t.hideOffcanvas();
                    if (s !== c) {
                        t.callback("onLandscape")
                    }
                }
                g = A;
                x = A
            } else {
                a(k).addClass("navigation-landscape");
                r();
                if (s !== c) {
                    t.callback("onLandscape")
                }
            }
        };
        var m = function() {
            a("html").on("click.body touchstart.body", function(A) {
                if (a(A.target).closest(".navigation").length === 0) {
                    a(k).find(".nav-submenu").fadeOut();
                    a(k).find(".focus").removeClass("focus");
                    a(k).find(".nav-search").find("form").fadeOut()
                }
            })
        };
        var z = function() {
            return d.innerWidth || b.documentElement.clientWidth || b.body.clientWidth
        };
        var y = function(A) {
            if (A == "landscape") {
                a(k).find(".nav-menu").find("li, a").off(i)
            } else {
                a(k).find(".nav-menu").find("li, a").off(q).off(p)
            }
        };
        var l = function() {
            if (z() > t.settings.mobileBreakpoint) {
                var A = a(k).outerWidth();
                a(k).find(".nav-menu").children("li").children(".nav-submenu").each(function() {
                    if (a(this).parent().position().left + a(this).outerWidth() > A) {
                        a(this).css("right", 0)
                    } else {
                        a(this).css("right", "auto")
                    }
                })
            }
        };
        var f = function() {
            function B(F) {
                var D = a(F).children(".megamenu-tabs-nav").children("li");
                var E = a(F).children(".megamenu-tabs-pane");
                a(D).on("mouseenter.tabs click.tabs touchstart.tabs", function(G) {
                    G.stopPropagation();
                    G.preventDefault();
                    a(D).removeClass("active");
                    a(this).addClass("active");
                    a(E).hide(0).removeClass("active");
                    a(E[a(this).index()]).show(0).addClass("active")
                })
            }
            if (a(k).find(".megamenu-tabs").length > 0) {
                var C = a(k).find(".megamenu-tabs");
                for (var A = 0; A < C.length; A++) {
                    B(C[A])
                }
            }
        };
        var r = function() {
            y("landscape");
            v();
            if (navigator.userAgent.match(/Mobi/i) || navigator.maxTouchPoints > 0 || t.settings.submenuTrigger == "click") {
                a(k).find(".nav-menu, .nav-dropdown").children("li").children("a").on(i, function(A) {
                    t.hideSubmenu(a(this).parent("li").siblings("li"), t.settings.effect);
                    a(this).closest(".nav-menu").siblings(".nav-menu").find(".nav-submenu").fadeOut(t.settings.hideDuration);
                    if (a(this).siblings(".nav-submenu").length > 0) {
                        A.stopPropagation();
                        A.preventDefault();
                        if (a(this).siblings(".nav-submenu").css("display") == "none") {
                            t.showSubmenu(a(this).parent("li"), t.settings.effect);
                            l();
                            return false
                        } else {
                            t.hideSubmenu(a(this).parent("li"), t.settings.effect)
                        }
                        if (a(this).attr("target") === "_blank" || a(this).attr("target") === "blank") {
                            d.open(a(this).attr("href"))
                        } else {
                            if (a(this).attr("href") === "#" || a(this).attr("href") === "" || a(this).attr("href") === "javascript:void(0)") {
                                return false
                            } else {
                                d.location.href = a(this).attr("href")
                            }
                        }
                    }
                })
            } else {
                a(k).find(".nav-menu").find("li").on(q, function() {
                    t.showSubmenu(this, t.settings.effect);
                    l()
                }).on(p, function() {
                    t.hideSubmenu(this, t.settings.effect)
                })
            }
            if (t.settings.hideSubWhenGoOut) {
                m()
            }
        };
        var u = function() {
            y("portrait");
            v();
            if (t.settings.visibleSubmenusOnMobile) {
                a(k).find(".nav-submenu").show(0)
            } else {
                a(k).find(".submenu-indicator").removeClass("submenu-indicator-up");
                if (t.settings.submenuIndicator && t.settings.submenuIndicatorTrigger) {
                    a(k).find(".submenu-indicator").on(i, function(A) {
                        A.stopPropagation();
                        A.preventDefault();
                        t.hideSubmenu(a(this).parent("a").parent("li").siblings("li"), "slide");
                        t.hideSubmenu(a(this).closest(".nav-menu").siblings(".nav-menu").children("li"), "slide");
                        if (a(this).parent("a").siblings(".nav-submenu").css("display") == "none") {
                            a(this).addClass("submenu-indicator-up");
                            a(this).parent("a").parent("li").siblings("li").find(".submenu-indicator").removeClass("submenu-indicator-up");
                            a(this).closest(".nav-menu").siblings(".nav-menu").find(".submenu-indicator").removeClass("submenu-indicator-up");
                            t.showSubmenu(a(this).parent("a").parent("li"), "slide");
                            return false
                        } else {
                            a(this).parent("a").parent("li").find(".submenu-indicator").removeClass("submenu-indicator-up");
                            t.hideSubmenu(a(this).parent("a").parent("li"), "slide")
                        }
                    })
                } else {
                    a(k).find(".nav-menu, .nav-dropdown").children("li").children("a").each(function() {
                        if (a(this).siblings(".nav-submenu").length > 0) {
                            a(this).on(i, function(A) {
                                A.stopPropagation();
                                A.preventDefault();
                                t.hideSubmenu(a(this).parent("li").siblings("li"), t.settings.effect);
                                t.hideSubmenu(a(this).closest(".nav-menu").siblings(".nav-menu").children("li"), "slide");
                                if (a(this).siblings(".nav-submenu").css("display") == "none") {
                                    a(this).children(".submenu-indicator").addClass("submenu-indicator-up");
                                    a(this).parent("li").siblings("li").find(".submenu-indicator").removeClass("submenu-indicator-up");
                                    a(this).closest(".nav-menu").siblings(".nav-menu").find(".submenu-indicator").removeClass("submenu-indicator-up");
                                    t.showSubmenu(a(this).parent("li"), "slide");
                                    return false
                                } else {
                                    a(this).parent("li").find(".submenu-indicator").removeClass("submenu-indicator-up");
                                    t.hideSubmenu(a(this).parent("li"), "slide")
                                }
                                if (a(this).attr("target") === "_blank" || a(this).attr("target") === "blank") {
                                    d.open(a(this).attr("href"))
                                } else {
                                    if (a(this).attr("href") === "#" || a(this).attr("href") === "" || a(this).attr("href") === "javascript:void(0)") {
                                        return false
                                    } else {
                                        d.location.href = a(this).attr("href")
                                    }
                                }
                            })
                        }
                    })
                }
            }
        };
        t.callback = function(A) {
            if (s[A] !== c) {
                s[A].call(k)
            }
        };
        t.init()
    };
    a.fn.navigation = function(e) {
        return this.each(function() {
            if (c === a(this).data("navigation")) {
                var f = new a.navigation(this, e);
                a(this).data("navigation", f)
            }
        })
    }
})(jQuery, window, document);