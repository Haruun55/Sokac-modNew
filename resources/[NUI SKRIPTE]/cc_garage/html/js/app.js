(function(t) {
    function e(e) {
        for (var a, c, r = e[0], o = e[1], l = e[2], u = 0, h = []; u < r.length; u++) c = r[u], Object.prototype.hasOwnProperty.call(s, c) && s[c] && h.push(s[c][0]), s[c] = 0;
        for (a in o) Object.prototype.hasOwnProperty.call(o, a) && (t[a] = o[a]);
        p && p(e);
        while (h.length) h.shift()();
        return i.push.apply(i, l || []), n()
    }

    function n() {
        for (var t, e = 0; e < i.length; e++) {
            for (var n = i[e], a = !0, r = 1; r < n.length; r++) {
                var o = n[r];
                0 !== s[o] && (a = !1)
            }
            a && (i.splice(e--, 1), t = c(c.s = n[0]))
        }
        return t
    }
    var a = {},
        s = { app: 0 },
        i = [];

    function c(e) { if (a[e]) return a[e].exports; var n = a[e] = { i: e, l: !1, exports: {} }; return t[e].call(n.exports, n, n.exports, c), n.l = !0, n.exports }
    c.m = t, c.c = a, c.d = function(t, e, n) { c.o(t, e) || Object.defineProperty(t, e, { enumerable: !0, get: n }) }, c.r = function(t) { "undefined" !== typeof Symbol && Symbol.toStringTag && Object.defineProperty(t, Symbol.toStringTag, { value: "Module" }), Object.defineProperty(t, "__esModule", { value: !0 }) }, c.t = function(t, e) {
        if (1 & e && (t = c(t)), 8 & e) return t;
        if (4 & e && "object" === typeof t && t && t.__esModule) return t;
        var n = Object.create(null);
        if (c.r(n), Object.defineProperty(n, "default", { enumerable: !0, value: t }), 2 & e && "string" != typeof t)
            for (var a in t) c.d(n, a, function(e) { return t[e] }.bind(null, a));
        return n
    }, c.n = function(t) { var e = t && t.__esModule ? function() { return t["default"] } : function() { return t }; return c.d(e, "a", e), e }, c.o = function(t, e) { return Object.prototype.hasOwnProperty.call(t, e) }, c.p = "nui://cc_garage/html/";
    var r = window["webpackJsonp"] = window["webpackJsonp"] || [],
        o = r.push.bind(r);
    r.push = e, r = r.slice();
    for (var l = 0; l < r.length; l++) e(r[l]);
    var p = o;
    i.push([0, "chunk-vendors"]), n()
})({
    0: function(t, e, n) { t.exports = n("56d7") },
    "56d7": function(t, e, n) {
        "use strict";
        n.r(e);
        n("e260"), n("e6cf"), n("cca6"), n("a79d");
        var a = n("2b0e"),
            s = function() {
                var t = this,
                    e = t.$createElement,
                    n = t._self._c || e;
                return n("div", { attrs: { id: "app" } }, [t.closed ? t._e() : n("div", { staticClass: "container" }, [n("div", { staticClass: "close", on: { click: function(e) { return t.close() } } }, [n("h1", { staticClass: "x" }, [t._v("x")])]), n("div", { staticClass: "inner-container" }, [t._m(0), n("img", { staticClass: "logo", attrs: { src: "https://cdn.discordapp.com/attachments/808766696328003664/1021482795958280223/unknown_7_1_3.png", alt: "logo" } }), t.parking ? n("ul", { staticClass: "vehicles" }, t._l(t.parkVehs, (function(e, a) { return n("li", { key: a, class: "vehicle row-" + (a > 2 ? a <= 3 ? 2 : 3 : 1) }, [n("div", { staticClass: "vehicle-div", on: { click: function(n) { return t.park(e.plate, !0) } } }, [n("img", { staticClass: "vehicle-img", attrs: { src: "car.png", alt: "car.svg" } }), n("p", { staticClass: "veh-name" }, [t._v(t._s(e.name))]), n("p", { staticClass: "veh-plate" }, [t._v(t._s(e.plate))])]), n("div", { staticClass: "edit-icon-container", on: { click: function(e) { return t.edit(a) } } }, [n("img", { staticClass: "edit-icon", attrs: { src: "pen.svg", alt: "pen.svg" } })])]) })), 0) : n("ul", { staticClass: "vehicles" }, t._l(t.vehicles, (function(e, a) { return n("li", { key: a, class: "vehicle row-" + (a > 2 ? a <= 3 ? 2 : 3 : 1) }, [n("div", { staticClass: "vehicle-div", on: { click: function(n) { return t.park(e.plate, !1) } } }, [n("img", { staticClass: "vehicle-img", attrs: { src: "car.png", alt: "car.svg" } }), n("p", { staticClass: "veh-name" }, [t._v(t._s(e.name))]), n("p", { staticClass: "veh-plate" }, [t._v(t._s(e.plate))])]), n("div", { staticClass: "edit-icon-container", on: { click: function(e) { return t.edit(a) } } }, [n("img", { staticClass: "edit-icon", attrs: { src: "pen.svg", alt: "pen.svg" } })])]) })), 0), n("div", { staticClass: "arrows" }, [n("div", { staticClass: "arrow-out", on: { click: function(e) { return t.changeSite(!1) } } }, [t._v("IZVUCI")]), n("div", { staticClass: "arrow-in", on: { click: function(e) { return t.changeSite(!0) } } }, [t._v("PARKIRAJ")])])])]), t.editing > -1 ? n("div", { staticClass: "editor" }, [n("div", { staticClass: "editor-window" }, [n("h2", { staticClass: "edit-heading" }, [t._v("Novo ime vozila"), n("br"), t._v(t._s(t.vehicles[t.editing].name) + " ")]), n("input", { directives: [{ name: "model", rawName: "v-model", value: t.newName, expression: "newName" }], attrs: { type: "text", placeholder: "Nove ime" }, domProps: { value: t.newName }, on: { input: function(e) { e.target.composing || (t.newName = e.target.value) } } }), n("div", { staticClass: "btn-cancel", on: { click: function(e) { t.editing = -1 } } }, [n("p", [t._v("x")])]), n("div", { staticClass: "btn-submit", on: { click: function(e) { return t.submit() } } }, [n("p", [t._v("   Prihvati :)")])])])]) : t._e()])
            },
            i = [function() {
                var t = this,
                    e = t.$createElement,
                    n = t._self._c || e;
                return n("h1", { staticClass: "heading" }, [t._v(""), n("br"), t._v("")])
            }],
            c = (n("d3b7"), n("b0c0"), {
                data: function() { return { closed: !0, newName: "", editing: -1, sites: 0, parking: !1, vehicles: [], parkVehs: [] } },
                methods: {
                    changeSite: function(t) { this.parking = t, t ? (fetch("https://cc_garage/enable-parking", { method: "post" }), this.vehicles = [], this.parkVehs = []) : (fetch("https://cc_garage/enable-parkout", { method: "post" }), this.vehicles = [], this.parkVehs = []) },
                    getVehicles: function(t) {
                        for (var e = 0; e < t.length / 9; e++) this.sites++;
                        this.vehicles = t
                    },
                    edit: function(t) { this.editing = t },
                    submit: function() { this.vehicles[this.editing].name = this.newName, fetch("https://cc_garage/new-name", { method: "post", body: JSON.stringify({ plate: this.vehicles[this.editing].plate, newName: this.newName }) }), this.editing = -1, this.newName = "" },
                    close: function() { this.closed = !0, this.vehicles = [], this.parkVehs = [], this.parking = !1, fetch("https://cc_garage/escape", { method: "post" }) },
                    park: function(t, e) { console.log("close"), e ? fetch("https://cc_garage/park-in", { method: "post", body: JSON.stringify({ plate: t }) }) : fetch("https://cc_garage/park-out", { method: "post", body: JSON.stringify({ plate: t }) }), this.close() }
                },
                mounted: function() {
                    var t = this;
                    window.addEventListener("message", (function(e) {
                        var n = e.data;
                        switch (n.action) {
                            case "open":
                                fetch("https://cc_garage/enable-parkout", { method: "post" }), t.closed = !1;
                                break;
                            case "close":
                                t.closed = !0;
                                break;
                            case "add":
                                t.vehicles.push({ name: n.name, plate: n.plate });
                                break;
                            case "add-p":
                                t.parkVehs.push({ name: n.name, plate: n.plate });
                                break
                        }
                    }))
                }
            }),
            r = c,
            o = (n("5c0b"), n("2877")),
            l = Object(o["a"])(r, s, i, !1, null, null, null),
            p = l.exports,
            u = n("8c4f");
        a["a"].use(u["a"]);
        var h = [],
            d = new u["a"]({ routes: h }),
            v = d,
            f = n("2f62");
        a["a"].use(f["a"]);
        var g = new f["a"].Store({ state: {}, mutations: {}, actions: {}, modules: {} });
        a["a"].config.productionTip = !1, new a["a"]({ router: v, store: g, render: function(t) { return t(p) } }).$mount("#app")
    },
    "5c0b": function(t, e, n) {
        "use strict";
        n("9c0c")
    },
    "9c0c": function(t, e, n) {}
});
//# sourceMappingURL=app.js.map