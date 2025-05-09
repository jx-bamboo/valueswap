
! function() {
    function ak() {
        a3.keyboardSupport && aC("keydown", ac)
    }

    function aQ() {
        if (!ad && document.body) {
            ad = !0;
            var k = document.body,
                h = document.documentElement,
                g = window.innerHeight,
                j = k.scrollHeight;
            if (af = document.compatMode.indexOf("CSS") >= 0 ? h : k, aj = k, ak(), top != self) {
                a0 = !0
            } else {
                if (j > g && (k.offsetHeight <= g || h.offsetHeight <= g)) {
                    var b = document.createElement("div");
                    b.style.cssText = "position:absolute; z-index:-10000; top:0; left:0; right:0; height:" + af.scrollHeight + "px", document.body.appendChild(b);
                    var e;
                    aR = function() {
                        e || (e = setTimeout(function() {
                            aB || (b.style.height = "0", b.style.height = af.scrollHeight + "px", e = null)
                        }, 500))
                    }, setTimeout(aR, 10), aC("resize", aR);
                    var f = {
                        attributes: !0,
                        childList: !0,
                        characterData: !1
                    };
                    if (aD = new aY(aR), aD.observe(k, f), af.offsetHeight <= g) {
                        var d = document.createElement("div");
                        d.style.clear = "both", k.appendChild(d)
                    }
                }
            }
            a3.fixedBackground || aB || (k.style.backgroundAttachment = "scroll", h.style.backgroundAttachment = "scroll")
        }
    }

    function aG() {
        aD && aD.disconnect(), aX(ab, aM), aX("mousedown", au), aX("keydown", ac), aX("resize", aR), aX("load", aQ)
    }

    function aE(c, k, h) {
        if (aI(k, h), 1 != a3.accelerationMax) {
            var g = Date.now(),
                j = g - aw;
            if (j < a3.accelerationDelta) {
                var b = (1 + 50 / j) / 2;
                b > 1 && (b = Math.min(b, a3.accelerationMax), k *= b, h *= b)
            }
            aw = Date.now()
        }
        if (aK.push({
                x: k,
                y: h,
                lastX: 0 > k ? 0.99 : -0.99,
                lastY: 0 > h ? 0.99 : -0.99,
                start: Date.now()
            }), !aJ) {
            var d = c === document.body,
                f = function(t) {
                    for (var v = Date.now(), e = 0, i = 0, y = 0; y < aK.length; y++) {
                        var l = aK[y],
                            x = v - l.start,
                            o = x >= a3.animationTime,
                            q = o ? 1 : x / a3.animationTime;
                        a3.pulseAlgorithm && (q = aZ(q));
                        var z = l.x * q - l.lastX >> 0,
                            p = l.y * q - l.lastY >> 0;
                        e += z, i += p, l.lastX += z, l.lastY += p, o && (aK.splice(y, 1), y--)
                    }
                    d ? window.scrollBy(e, i) : (e && (c.scrollLeft += e), i && (c.scrollTop += i)), k || h || (aK = []), aK.length ? aW(f, c, 1000 / a3.frameRate + 1) : aJ = !1
                };
            aW(f, c, 0), aJ = !0
        }
    }

    function aM(c) {
        ad || aQ();
        var f = c.target,
            g = aT(f);
        if (!g || c.defaultPrevented || c.ctrlKey) {
            return !0
        }
        if (ar(aj, "embed") || ar(f, "embed") && /\.pdf/i.test(f.src) || ar(aj, "object") || f.shadowRoot) {
            return !0
        }
        var b = -c.wheelDeltaX || c.deltaX || 0,
            d = -c.wheelDeltaY || c.deltaY || 0;
        return aH && (c.wheelDeltaX && ae(c.wheelDeltaX, 120) && (b = -120 * (c.wheelDeltaX / Math.abs(c.wheelDeltaX))), c.wheelDeltaY && ae(c.wheelDeltaY, 120) && (d = -120 * (c.wheelDeltaY / Math.abs(c.wheelDeltaY)))), b || d || (d = -c.wheelDelta || 0), 1 === c.deltaMode && (b *= 40, d *= 40), !a3.touchpadSupport && aV(d) ? !0 : (Math.abs(b) > 1.2 && (b *= a3.stepSize / 120), Math.abs(d) > 1.2 && (d *= a3.stepSize / 120), aE(g, b, d), c.preventDefault(), void aA())
    }

    function ac(j) {
        var v = j.target,
            p = j.ctrlKey || j.altKey || j.metaKey || j.shiftKey && j.keyCode !== az.spacebar;
        document.body.contains(aj) || (aj = document.activeElement);
        var q = /^(textarea|select|embed|object)$/i,
            b = /^(button|submit|radio|checkbox|file|color|image)$/i;
        if (j.defaultPrevented || q.test(v.nodeName) || ar(v, "input") && !b.test(v.type) || ar(aj, "video") || ap(j) || v.isContentEditable || p) {
            return !0
        }
        if ((ar(v, "button") || ar(v, "input") && b.test(v.type)) && j.keyCode === az.spacebar) {
            return !0
        }
        if (ar(v, "input") && "radio" == v.type && aN[j.keyCode]) {
            return !0
        }
        var l, g = 0,
            h = 0,
            u = aT(aj),
            k = u.clientHeight;
        switch (u == document.body && (k = window.innerHeight), j.keyCode) {
            case az.up:
                h = -a3.arrowScroll;
                break;
            case az.down:
                h = a3.arrowScroll;
                break;
            case az.spacebar:
                l = j.shiftKey ? 1 : -1, h = -l * k * 0.9;
                break;
            case az.pageup:
                h = 0.9 * -k;
                break;
            case az.pagedown:
                h = 0.9 * k;
                break;
            case az.home:
                h = -u.scrollTop;
                break;
            case az.end:
                var n = u.scrollHeight - u.scrollTop - k;
                h = n > 0 ? n + 10 : 0;
                break;
            case az.left:
                g = -a3.arrowScroll;
                break;
            case az.right:
                g = a3.arrowScroll;
                break;
            default:
                return !0
        }
        aE(u, g, h), j.preventDefault(), aA()
    }

    function au(a) {
        aj = a.target
    }

    function aA() {
        clearTimeout(al), al = setInterval(function() {
            av = {}
        }, 1000)
    }

    function ag(a, c) {
        for (var b = a.length; b--;) {
            av[ao(a[b])] = c
        }
        return c
    }

    function aT(c) {
        var j = [],
            g = document.body,
            f = af.scrollHeight;
        do {
            var h = av[ao(c)];
            if (h) {
                return ag(j, h)
            }
            if (j.push(c), f === c.scrollHeight) {
                var b = aO(af) && aO(g),
                    d = b || an(af);
                if (a0 && ai(af) || !a0 && d) {
                    return ag(j, aa())
                }
            } else {
                if (ai(c) && an(c)) {
                    return ag(j, c)
                }
            }
        } while (c = c.parentElement)
    }

    function ai(a) {
        return a.clientHeight + 10 < a.scrollHeight
    }

    function aO(a) {
        var b = getComputedStyle(a, "").getPropertyValue("overflow-y");
        return "hidden" !== b
    }

    function an(a) {
        var b = getComputedStyle(a, "").getPropertyValue("overflow-y");
        return "scroll" === b || "auto" === b
    }

    function aC(a, b) {
        window.addEventListener(a, b, !1)
    }

    function aX(a, b) {
        window.removeEventListener(a, b, !1)
    }

    function ar(a, b) {
        return (a.nodeName || "").toLowerCase() === b.toLowerCase()
    }

    function aI(a, b) {
        a = a > 0 ? 1 : -1, b = b > 0 ? 1 : -1, (a2.x !== a || a2.y !== b) && (a2.x = a, a2.y = b, aK = [], aw = 0)
    }

    function aV(a) {
        return a ? (aF.length || (aF = [a, a, a]), a = Math.abs(a), aF.push(a), aF.shift(), clearTimeout(ah), ah = setTimeout(function() {
            window.localStorage && (localStorage.SS_deltaBuffer = aF.join(","))
        }, 1000), !a1(120) && !a1(100)) : void 0
    }

    function ae(a, b) {
        return Math.floor(a / b) == a / b
    }

    function a1(a) {
        return ae(aF[0], a) && ae(aF[1], a) && ae(aF[2], a)
    }

    function ap(a) {
        var c = a.target,
            b = !1;
        if (-1 != document.URL.indexOf("www.youtube.com/watch")) {
            do {
                if (b = c.classList && c.classList.contains("html5-video-controls")) {
                    break
                }
            } while (c = c.parentNode)
        }
        return b
    }

    function aP(a) {
        var d, c, b;
        return a *= a3.pulseScale, 1 > a ? d = a - (1 - Math.exp(-a)) : (c = Math.exp(-1), a -= 1, b = 1 - Math.exp(-a), d = c + b * (1 - c)), d * a3.pulseNormalize
    }

    function aZ(a) {
        return a >= 1 ? 1 : 0 >= a ? 0 : (1 == a3.pulseNormalize && (a3.pulseNormalize /= aP(1)), aP(a))
    }

    function ay(a) {
        for (var b in a) {
            at.hasOwnProperty(b) && (a3[b] = a[b])
        }
    }
    var aj, aD, aR, al, ah, at = {
            frameRate: 150,
            animationTime: 400,
            stepSize: 100,
            pulseAlgorithm: !0,
            pulseScale: 4,
            pulseNormalize: 1,
            accelerationDelta: 50,
            accelerationMax: 3,
            keyboardSupport: !0,
            arrowScroll: 50,
            touchpadSupport: !1,
            fixedBackground: !0,
            excluded: ""
        },
        a3 = at,
        aB = !1,
        a0 = !1,
        a2 = {
            x: 0,
            y: 0
        },
        ad = !1,
        af = document.documentElement,
        aF = [],
        aH = /^Mac/.test(navigator.platform),
        az = {
            left: 37,
            up: 38,
            right: 39,
            down: 40,
            spacebar: 32,
            pageup: 33,
            pagedown: 34,
            end: 35,
            home: 36
        },
        aN = {
            37: 1,
            38: 1,
            39: 1,
            40: 1
        },
        aK = [],
        aJ = !1,
        aw = Date.now(),
        ao = function() {
            var a = 0;
            return function(b) {
                return b.uniqueID || (b.uniqueID = a++)
            }
        }(),
        av = {};
    window.localStorage && localStorage.SS_deltaBuffer && (aF = localStorage.SS_deltaBuffer.split(","));
    var ab, aW = function() {
            return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || function(a, c, b) {
                window.setTimeout(a, b || 1000 / 60)
            }
        }(),
        aY = window.MutationObserver || window.WebKitMutationObserver || window.MozMutationObserver,
        aa = function() {
            var a;
            return function() {
                if (!a) {
                    var c = document.createElement("div");
                    c.style.cssText = "height:10000px;width:1px;", document.body.appendChild(c);
                    var b = document.body.scrollTop;
                    document.documentElement.scrollTop;
                    window.scrollBy(0, 3), a = document.body.scrollTop != b ? document.body : document.documentElement, window.scrollBy(0, -3), document.body.removeChild(c)
                }
                return a
            }
        }(),
        aU = window.navigator.userAgent,
        aq = /Edge/.test(aU),
        ax = /chrome/i.test(aU) && !aq,
        aL = /safari/i.test(aU) && !aq,
        a4 = /mobile/i.test(aU),
        am = /Windows NT 6.1/i.test(aU) && /rv:11/i.test(aU),
        aS = (ax || aL || am) && !a4;
    "onwheel" in document.createElement("div") ? ab = "wheel" : "onmousewheel" in document.createElement("div") && (ab = "mousewheel"), ab && aS && (aC(ab, aM), aC("mousedown", au), aC("load", aQ)), ay.destroy = aG, window.SmoothScrollOptions && ay(window.SmoothScrollOptions), "function" == typeof define && define.amd ? define(function() {
        return ay
    }) : "object" == typeof exports ? module.exports = ay : window.SmoothScroll = ay
}();