!function(e) {
    function o(n) {
        if (t[n])
            return t[n].exports;
        var r = t[n] = {
            i: n,
            l: !1,
            exports: {}
        };
        return e[n].call(r.exports, r, r.exports, o),
            r.l = !0,
            r.exports
    }
    var t = {};
    o.m = e,
        o.c = t,
        o.d = function(e, t, n) {
            o.o(e, t) || Object.defineProperty(e, t, {
                configurable: !1,
                enumerable: !0,
                get: n
            })
        }
        ,
        o.n = function(e) {
            var t = e && e.__esModule ? function() {
                    return e.default
                }
                : function() {
                    return e
                }
            ;
            return o.d(t, "a", t),
                t
        }
        ,
        o.o = function(e, o) {
            return Object.prototype.hasOwnProperty.call(e, o)
        }
        ,
        o.p = "/",
        o(o.s = 0)
}([function(e, o, t) {
    e.exports = t(1)
}
    , function(e, o, t) {
        "use strict";
        var n = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function(e) {
                return typeof e
            }
            : function(e) {
                return e && "function" == typeof Symbol && e.constructor === Symbol && e !== Symbol.prototype ? "symbol" : typeof e
            }
            , r = function(e, o) {
            var t = document.createElement("div");
            t.style.cssText = "color:white;background-color:red;padding:5em;font-weight:bold;text-align:center;",
                t.innerHTML = e,
                o ? o.parentNode.insertBefore(t, o) : document.body.appendChild(t)
        }
            , d = function(e) {
            e && "object" === (void 0 === e ? "undefined" : n(e)) || r("Could not embed SpreadShop: No 'spread_shop_config' object found in window"),
            e.startToken && "fetch"in window && fetch("https://shop.spreadshirt.net/shopfiles/startTokenTracking/" + encodeURI(e.startToken) + "?source=" + encodeURI(window.location.href)),
                ["baseId", "prefix", "shopName"].forEach(function(o) {
                    if (!e[o]) {
                        throw r("<h2>Could not embed your SpreadShop!</h2><p>Please provide a '" + o + "' in the spread_shop_config object.</p>"),
                            new Error("Could not embed SpreadShop: Element with id '" + e.baseId + "' not found")
                    }
                })
        }
            , i = function(e, o) {
            if (!o) {
                var t = "<h2>Could not embed your SpreadShop!</h2><p>Please add a container with the id '" + e.baseId + "' to your HTML file.</p>";
                throw r(t),
                    new Error("Could not embed SpreadShop: Element with id '" + e.baseId + "' not found")
            }
        }
            , a = function(e, o) {
            if (null === document.doctype) {
                console.error("Could embed shop '" + e.shopName + "' because of missing doctype. Please add '<!DOCTYPE html>' at the beginning of your html file."),
                "fetch"in window && fetch("https://shop.spreadshirt.net/shopfiles/docTypeTracking/" + e.shopName + "?source=" + encodeURI(window.location.href));
                r('\n    <h2>Could not properly render your SpreadShop!</h2>\n    <p>This HTML Document does not specify a doctype. This can lead to very strange layout and styling errors.</p> \n    <p>Please add \'&lt;!DOCTYPE html&gt;\' at the beginning of your html file.</p>\n    <br />\n    <small>For more information read the documentation of <a href="https://www.w3schools.com/tags/tag_doctype.asp">doctype</a> and <a href="https://developer.mozilla.org/en-US/docs/Mozilla/Mozilla_quirks_mode_behavior">quirks mode</a>.</small>\n  ', o)
            }
        }
            , s = function(e, o) {
            var t = document.createElement("link");
            t.rel = "stylesheet",
                t.type = "text/css",
                t.id = "sprd-css",
                t.href = e + "/shopfiles/css/shop_prefixed." + o + ".css";
            var n = document.getElementById("sprd-css");
            n && n.parentNode.removeChild(n),
                document.head.appendChild(t)
        }
            , c = function(e, o) {
            var t = document.createElement("script");
            t.type = "text/javascript",
                t.src = e + "/js/shop.bundle." + o + ".js",
                t.onerror = function() {
                    r("Could not embed SpreadShop: Failed to load shop script")
                }
                ,
                document.head.appendChild(t)
        };
        window.loadShop =  function() {
            var e = window.spread_shop_config;
            d(e);
            var o = document.getElementById(e.baseId);
            i(e, o),
                a(e, o);
            var t = function(e, o) {
                return -1 !== e.indexOf(o, e.length - o.length)
            }(e.prefix, "/") ? e.prefix.substring(0, e.prefix.length - 1) : e.prefix;
            c(t, "6fba2e86ce7e530c2f19f425fae09f2a287d8791"),
                s(t, "6fba2e86ce7e530c2f19f425fae09f2a287d8791")
        };
    }
]);
