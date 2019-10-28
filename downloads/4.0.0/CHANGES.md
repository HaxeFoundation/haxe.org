## 2019-10-26: 4.0.0

__New features__:

* all : added `-D warn-var-shadowing`
* all : added column to StackItem.FilePos ([#6665](https://github.com/HaxeFoundation/haxe/issues/6665))
* all : added experimental null-safety feature through `--macro nullSafety("package")` ([#7717](https://github.com/HaxeFoundation/haxe/issues/7717))
* all : added final keyword ([#6596](https://github.com/HaxeFoundation/haxe/issues/6596))
* all : added haxe.Log.formatOutput ([#6738](https://github.com/HaxeFoundation/haxe/issues/6738))
* all : added JSON-RPC-based display protocol
* all : added JVM target
* all : added keyValueIterator to Map and its implementations
* all : added new function type syntax (`(a:Int, b:String)->Void`) ([#6645](https://github.com/HaxeFoundation/haxe/issues/6645))
* all : added strictness settings for the null-safety checker, using loose checking by default ([#7811](https://github.com/HaxeFoundation/haxe/issues/7811))
* all : added support for arrow functions
* all : added support for write-mode `@:op(a.b)`
* all : allow `enum abstract` syntax instead of `@:enum abstract` ([#4282](https://github.com/HaxeFoundation/haxe/issues/4282))
* all : allow `extern` on fields instead of `@:extern`
* all : allow enum values without arguments as default function argument values ([#7439](https://github.com/HaxeFoundation/haxe/issues/7439))
* all : reworked macro interpreter
* all : support `@:using` on type declarations ([#7462](https://github.com/HaxeFoundation/haxe/issues/7462))
* all : support `for (key => value in e)` syntax for key-value iterators
* all : support `inline call()` and `inline new` expressions ([#7425](https://github.com/HaxeFoundation/haxe/issues/7425))
* all : support `Type1 & Type2` intersection syntax for type parameter constraints and structures ([#7127](https://github.com/HaxeFoundation/haxe/issues/7127))
* all : support auto-numbering and auto-stringification in enum abstracts ([#7139](https://github.com/HaxeFoundation/haxe/issues/7139))
* all : support loop-unrolling on `for (i in 0...5)` ([#7365](https://github.com/HaxeFoundation/haxe/issues/7365))
* all : support markup literal strings but require them to be macro-processed ([#7438](https://github.com/HaxeFoundation/haxe/issues/7438))
* all : support signature completion on incomplete structures ([#5767](https://github.com/HaxeFoundation/haxe/issues/5767))
* all : support Unicode strings properly on all targets
* hl : added hl.Format.digest, use it for native Sha1/Md5
* js : added ES6 class generation with `-D js-es=6` ([#7806](https://github.com/HaxeFoundation/haxe/issues/7806))
* js : added js.Map and js.Set and js.JsIterator extern definitions (ES6)
* js : added js.Syntax class for generating unsupported JavaScript syntax in a type-safe analyzer-friendly way
* lua : add -D lua-vanilla, which emits code with reduced functionality but no additional lib dependencies

__General improvements and optimizations__:

* all : [breaking] disallow static extensions on implicit `this` ([#6036](https://github.com/HaxeFoundation/haxe/issues/6036))
* all : [breaking] disallow static extensions through abstract field casts ([#5924](https://github.com/HaxeFoundation/haxe/issues/5924))
* all : [breaking] disallowed static variables that have no type-hint and expression ([#6440](https://github.com/HaxeFoundation/haxe/issues/6440))
* all : [breaking] reserved `operator` and `overload` as keywords ([#7413](https://github.com/HaxeFoundation/haxe/issues/7413))
* all : added --server-connect ([#8730](https://github.com/HaxeFoundation/haxe/issues/8730))
* all : added `@:bypassAccessor`
* all : added `haxe4` define
* all : added display/typeDefinition to display protocol ([#7266](https://github.com/HaxeFoundation/haxe/issues/7266))
* all : added support for `case var x` syntax and detect possible typos ([#6608](https://github.com/HaxeFoundation/haxe/issues/6608))
* all : allow `@:commutative` on non-static abstract functions ([#5599](https://github.com/HaxeFoundation/haxe/issues/5599))
* all : allow `var ?x` and `final ?x` parsing in structures ([#6947](https://github.com/HaxeFoundation/haxe/issues/6947))
* all : allow parsing `#if (a.b)` ([#8005](https://github.com/HaxeFoundation/haxe/issues/8005))
* all : allow true and false expressions as type parameters ([#6958](https://github.com/HaxeFoundation/haxe/issues/6958))
* all : allowed assigning `[]` where `Map` is expected ([#7426](https://github.com/HaxeFoundation/haxe/issues/7426))
* all : allowed enum constructors without arguments as static inline var ([#8187](https://github.com/HaxeFoundation/haxe/issues/8187))
* all : allowed function types in @:generic ([#3697](https://github.com/HaxeFoundation/haxe/issues/3697))
* all : changed haxe.xml.Fast to an abstract
* all : create temp vars in pattern matcher to avoid duplicate access ([#8064](https://github.com/HaxeFoundation/haxe/issues/8064))
* all : detect invalid #tokens in inactive code ([#7108](https://github.com/HaxeFoundation/haxe/issues/7108))
* all : do not require semicolon for markup literals ([#7438](https://github.com/HaxeFoundation/haxe/issues/7438))
* all : fixed various display-related problems
* all : implemented `for` loop unrolling ([#3784](https://github.com/HaxeFoundation/haxe/issues/3784))
* all : improved --help-defines and --help-metas
* all : improved --times performance ([#8733](https://github.com/HaxeFoundation/haxe/issues/8733))
* all : improved and unified identifier checks for names, fields and types ([#8708](https://github.com/HaxeFoundation/haxe/issues/8708))
* all : improved completion support in .platform.hx files
* all : improved diagnostics of syntax errors ([#7940](https://github.com/HaxeFoundation/haxe/issues/7940))
* all : improved display support in many areas
* all : improved handling of default values when inlining ([#8397](https://github.com/HaxeFoundation/haxe/issues/8397))
* all : improved handling of native libraries on the compilation server ([#8629](https://github.com/HaxeFoundation/haxe/issues/8629))
* all : improved memory handling of the compilation server (8727)
* all : improved optimization when comparing against `null`
* all : improved overall file finding ([#8202](https://github.com/HaxeFoundation/haxe/issues/8202))
* all : improved overall robustness of the parser in display mode
* all : improved parser error messages ([#7912](https://github.com/HaxeFoundation/haxe/issues/7912))
* all : improved positions of `switch` and `case` expressions ([#7947](https://github.com/HaxeFoundation/haxe/issues/7947))
* all : improved server reaction to added and removed files ([#8451](https://github.com/HaxeFoundation/haxe/issues/8451))
* all : improved support of hovering over inactive conditional compilation blocks
* all : improved unification error messages ([#7547](https://github.com/HaxeFoundation/haxe/issues/7547))
* all : improved various aspects of the display API
* all : inherit `@:native` for overriden methods ([#7844](https://github.com/HaxeFoundation/haxe/issues/7844))
* all : made `@:expose` imply `@:keep` ([#7695](https://github.com/HaxeFoundation/haxe/issues/7695))
* all : made `@:using` actually work
* all : made `final` on structure fields invariant ([#7039](https://github.com/HaxeFoundation/haxe/issues/7039))
* all : made all non-warning/non-error compiler messages output to stdout ([#4480](https://github.com/HaxeFoundation/haxe/issues/4480))
* all : made parser in display mode much more tolerant
* all : made various improvements to the display API as usual
* all : make `final` in structures use class notation
* all : make DCE keep constructor if any instance field is kept ([#6690](https://github.com/HaxeFoundation/haxe/issues/6690))
* all : make display/references and display/toplevel actually work sometimes
* all : metadata can now use `.`, e.g. `@:a.b`. This is represented as a string ([#3959](https://github.com/HaxeFoundation/haxe/issues/3959))
* all : properly disallowed some modifier combinations related to `final` ([#8335](https://github.com/HaxeFoundation/haxe/issues/8335))
* all : properly error on `@:op(a = b)` ([#6903](https://github.com/HaxeFoundation/haxe/issues/6903))
* all : remove some redundant cast expressions ([#8725](https://github.com/HaxeFoundation/haxe/issues/8725))
* all : replaced some occurrences of List with Array
* all : reworked CLI usage/help output ([#6862](https://github.com/HaxeFoundation/haxe/issues/6862))
* all : show typo suggestions when declaring `override` field ([#7847](https://github.com/HaxeFoundation/haxe/issues/7847))
* all : standardized identifiers allowed in markup literals ([#7558](https://github.com/HaxeFoundation/haxe/issues/7558))
* all : support `@:pure(false)` on variable fields ([#8338](https://github.com/HaxeFoundation/haxe/issues/8338))
* all : support `override |` completion
* all : support hovering conditional compilation identifiers
* all : support parsing dots in conditional compilation, e.g. `#if target.sys`
* all : support partial completion results ([#8642](https://github.com/HaxeFoundation/haxe/issues/8642))
* all : unified cast, catch and Std.is behavior of null-values ([#7532](https://github.com/HaxeFoundation/haxe/issues/7532))
* all : unified various parts of the String API across all targets
* cs : generate native type parameter constraints (#8311, #7863)
* cs : improved generation of enum classes ([#6119](https://github.com/HaxeFoundation/haxe/issues/6119))
* cs : support .NET core target ([#8391](https://github.com/HaxeFoundation/haxe/issues/8391))
* display : added `this` and `super` to toplevel completion ([#6051](https://github.com/HaxeFoundation/haxe/issues/6051))
* eval : fixed many error positions
* eval : greatly improved debugger interaction ([#7839](https://github.com/HaxeFoundation/haxe/issues/7839))
* eval : improved debugger, support conditional breakpoints
* eval : improved handling of capture variables ([#8017](https://github.com/HaxeFoundation/haxe/issues/8017))
* eval : improved IntMap and StringMap performance
* eval : improved object prototype field handling ([#7393](https://github.com/HaxeFoundation/haxe/issues/7393))
* eval : improved performance of instance calls
* eval : improved performance of various string operations ([#7982](https://github.com/HaxeFoundation/haxe/issues/7982))
* eval : optimized int switches ([#7481](https://github.com/HaxeFoundation/haxe/issues/7481))
* eval : properly support threads when debugging ([#7991](https://github.com/HaxeFoundation/haxe/issues/7991))
* eval: improved performance of regular expressions ([#8693](https://github.com/HaxeFoundation/haxe/issues/8693))
* flash : rework support for native Flash properties ([#8241](https://github.com/HaxeFoundation/haxe/issues/8241))
* flash : updated Flash externs to version 32.0 (now using `final`, `enum abstract` and `haxe.extern.Rest`)
* js : added externs for js.Date ([#6855](https://github.com/HaxeFoundation/haxe/issues/6855))
* js : enums are now generated as objects instead of arrays ([#6350](https://github.com/HaxeFoundation/haxe/issues/6350))
* js : generate `value instanceof MyClass` instead of `Std.is(value, MyClass)` ([#6687](https://github.com/HaxeFoundation/haxe/issues/6687))
* js : generate dot-access for "keyword" field names ([#7645](https://github.com/HaxeFoundation/haxe/issues/7645))
* js : generate faster code for `x.iterator()` calls ([#6669](https://github.com/HaxeFoundation/haxe/issues/6669))
* js : improve js.Promise extern: now `then` callback argument types can be properly inferred ([#7644](https://github.com/HaxeFoundation/haxe/issues/7644))
* js : improved generation of `break` inside `switch` inside loops ([#4964](https://github.com/HaxeFoundation/haxe/issues/4964))
* js : improved HTML externs
* js : optimized run-time type checking against interfaces ([#7834](https://github.com/HaxeFoundation/haxe/issues/7834))
* js : respect `-D source-map` flag to generate source maps in release builds
* js : rework exception handling, added js.Lib.getOriginalException ([#6713](https://github.com/HaxeFoundation/haxe/issues/6713))
* js : skip generation of interfaces when no run-time type checking needed ([#7843](https://github.com/HaxeFoundation/haxe/issues/7843))
* js : updated externs for `Float32Array` and `Float64Array` ([#8864](https://github.com/HaxeFoundation/haxe/issues/8864))
* js : updated HTML externs
* js : updated jQuery extern (js.jquery.*) for jQuery 1.12.4 / 3.2.1 support.
* js : use lazy getter for HaxeError.message instead of calling String(val) in the ctor ([#6754](https://github.com/HaxeFoundation/haxe/issues/6754))
* lua : improved -D lua-vanilla
* macro : static variables are now always re-initialized when using the compilation server ([#5746](https://github.com/HaxeFoundation/haxe/issues/5746))
* macro : support `@:persistent` to keep macro static values across compilations
* Makefile : default Unix installation location $(INSTALL_DIR) changed from /usr to /usr/local.
* Makefile : default Unix std location $(INSTALL_STD_DIR) changed from $(INSTALL_LIB_DIR)/std to $(INSTALL_DIR)/share/haxe/std.
* php : added `php.Syntax.code()` instead of deprecated `untyped __php__()` ([#6708](https://github.com/HaxeFoundation/haxe/issues/6708))
* php : added array access to `php.NativeStructArray` ([#8893](https://github.com/HaxeFoundation/haxe/issues/8893))
* php : added methods to `php.Syntax` for each php operator: `??`, `?:`, `**` etc. ([#6708](https://github.com/HaxeFoundation/haxe/issues/6708))
* php : changed `--php-prefix`, `--php-front` and `--php-lib` to `-D php-prefix=`, `-D php-front=` and `-D php-lib=` respectively
* php : implemented direct method comparison. No need to use `Reflect.compareMethods()`
* php : improved performance of various parser implementations ([#8083](https://github.com/HaxeFoundation/haxe/issues/8083))
* php : Optimized `Map.copy()` and `Array.copy()`
* php : Optimized haxe.ds.Vector (VectorData is not Array anymore)
* php : Optimized iterators of `Map` and native arrays.
* php : Support native PHP generators. See `php.Syntax.yield()` and `php.Generator`
* python : add ssl support for http requests
* python : improve Sys.print(ln) code generation ([#6184](https://github.com/HaxeFoundation/haxe/issues/6184))
* sys : the `database` parameter of `Mysql.connect` is now optional

__Standard Library__:

* all : [breaking] made Lambda functions return Array instead of List ([#7097](https://github.com/HaxeFoundation/haxe/issues/7097))
* all : [breaking] removed `return this` from some haxe.Http methods ([#6980](https://github.com/HaxeFoundation/haxe/issues/6980))
* all : `BalancedTree implements `haxe.Constraints.IMap` ([#6231](https://github.com/HaxeFoundation/haxe/issues/6231))
* all : added `EReg.escape` ([#5098](https://github.com/HaxeFoundation/haxe/issues/5098))
* all : added `iterator()` to `haxe.DynamicAccess` ([#7892](https://github.com/HaxeFoundation/haxe/issues/7892))
* all : added `keyValueIterator()` to `haxe.DynamicAccess` ([#7769](https://github.com/HaxeFoundation/haxe/issues/7769))
* all : added `resize` to Array ([#6869](https://github.com/HaxeFoundation/haxe/issues/6869))
* all : added default timeout to HTTP sockets ([#8646](https://github.com/HaxeFoundation/haxe/issues/8646))
* all : added haxe.iterators package
* all : added JSON-RPC protocol types to haxe.display package ([#8610](https://github.com/HaxeFoundation/haxe/issues/8610))
* all : added Map.clear ([#8681](https://github.com/HaxeFoundation/haxe/issues/8681))
* all : added StringTools.contains ([#7608](https://github.com/HaxeFoundation/haxe/issues/7608))
* all : improved Date API ([#8508](https://github.com/HaxeFoundation/haxe/issues/8508))
* all : improved StringTools.lpad/rpad/htmlEscape implementation
* all : introduced `Std.downcast` as replacement for `Std.instance` ([#8301](https://github.com/HaxeFoundation/haxe/issues/8301))
* all : introduced `UnicodeString`, deprecated `haxe.Utf8` ([#8298](https://github.com/HaxeFoundation/haxe/issues/8298))
* all : moved List to haxe.ds ([#6610](https://github.com/HaxeFoundation/haxe/issues/6610))
* all : moved typed arrays from `js.html` to `js.lib` ([#7894](https://github.com/HaxeFoundation/haxe/issues/7894))
* all : turned sys.thread.Thread into abstracts ([#8130](https://github.com/HaxeFoundation/haxe/issues/8130))
* all : unified various Thread APIs in sys.thread ([#7999](https://github.com/HaxeFoundation/haxe/issues/7999))
* cs : added sys.thread implementations ([#8166](https://github.com/HaxeFoundation/haxe/issues/8166))
* eval : completed Thread API
* flash : added flash.AnyType ([#8549](https://github.com/HaxeFoundation/haxe/issues/8549))
* java : added java.NativeString ([#8163](https://github.com/HaxeFoundation/haxe/issues/8163))
* js : moved various classes to js.lib ([#7390](https://github.com/HaxeFoundation/haxe/issues/7390))
* macro : added Context.getMessages and Context.filterMessages ([#8471](https://github.com/HaxeFoundation/haxe/issues/8471))
* macro : added Context.info ([#8478](https://github.com/HaxeFoundation/haxe/issues/8478))
* macro : added function kind to EFunction ([#8653](https://github.com/HaxeFoundation/haxe/issues/8653))
* macro : added have.display.Position and PositionTools.toRange ([#6599](https://github.com/HaxeFoundation/haxe/issues/6599))
* macro : added string literal kind to CString ([#8668](https://github.com/HaxeFoundation/haxe/issues/8668))

__Bugfixes__:

* all : [breaking] `function () { }(e)` is no longer parsed as a call ([#5854](https://github.com/HaxeFoundation/haxe/issues/5854))
* all : cleaned up `inline` handling ([#7155](https://github.com/HaxeFoundation/haxe/issues/7155))
* all : delay interface accessor generation properly (#6225, #6672)
* all : disallowed `return null` from Void-functions ([#7198](https://github.com/HaxeFoundation/haxe/issues/7198))
* all : don't generate return expressions in Void lambda functions ([#6503](https://github.com/HaxeFoundation/haxe/issues/6503))
* all : fix GC compacting too often in server mode
* all : fix some invalid Json being accepted by haxe.format.JsonParser ([#6734](https://github.com/HaxeFoundation/haxe/issues/6734))
* all : fixed @:generic naming ([#6968](https://github.com/HaxeFoundation/haxe/issues/6968))
* all : fixed @:structInit not being compatible with `final` fields ([#7182](https://github.com/HaxeFoundation/haxe/issues/7182))
* all : fixed `-D no-deprecation-warnings` for typedefs and enums
* all : fixed `@:allow(package)` allowing too much ([#8306](https://github.com/HaxeFoundation/haxe/issues/8306))
* all : fixed `from Dynamic` on abstracts ([#8425](https://github.com/HaxeFoundation/haxe/issues/8425))
* all : fixed `inline new` handling ([#8240](https://github.com/HaxeFoundation/haxe/issues/8240))
* all : fixed `Null<T>` inconsistency in if/ternary expressions ([#6955](https://github.com/HaxeFoundation/haxe/issues/6955))
* all : fixed abstract `@:to` used when `from` is available in a specific case ([#6751](https://github.com/HaxeFoundation/haxe/issues/6751))
* all : fixed and restricted various Unicode-related issues in String literals
* all : fixed argument default value checking for externs ([#7752](https://github.com/HaxeFoundation/haxe/issues/7752))
* all : fixed autogenerated constructor for extending @:structInit classes (#6822, #6078)
* all : fixed bad unary operator optimization ([#7704](https://github.com/HaxeFoundation/haxe/issues/7704))
* all : fixed bug regarding abstract `this` modification in inline methods ([#8454](https://github.com/HaxeFoundation/haxe/issues/8454))
* all : fixed bug that skipped checking @:from typing in some cases ([#6564](https://github.com/HaxeFoundation/haxe/issues/6564))
* all : fixed call-site inlining on abstracts ([#7886](https://github.com/HaxeFoundation/haxe/issues/7886))
* all : fixed capture variables being allowed in `.match` ([#7921](https://github.com/HaxeFoundation/haxe/issues/7921))
* all : fixed cast handling in try-catch expressions ([#8257](https://github.com/HaxeFoundation/haxe/issues/8257))
* all : fixed compilation server module dependency issue related to macros ([#7448](https://github.com/HaxeFoundation/haxe/issues/7448))
* all : fixed compiler hang in display mode ([#7236](https://github.com/HaxeFoundation/haxe/issues/7236))
* all : fixed compiler hang related to @:arrayAccess ([#5525](https://github.com/HaxeFoundation/haxe/issues/5525))
* all : fixed Constructible not checking constraints properly ([#6714](https://github.com/HaxeFoundation/haxe/issues/6714))
* all : fixed DCE compilation server state issue ([#7805](https://github.com/HaxeFoundation/haxe/issues/7805))
* all : fixed DCE issue related to closures ([#8200](https://github.com/HaxeFoundation/haxe/issues/8200))
* all : fixed field type being lost for Int expressions on Float fields ([#7132](https://github.com/HaxeFoundation/haxe/issues/7132))
* all : fixed fields with default values for `@:structInit` classes ([#5449](https://github.com/HaxeFoundation/haxe/issues/5449))
* all : fixed handling of type parameters in local functions ([#6560](https://github.com/HaxeFoundation/haxe/issues/6560))
* all : fixed haxe.format.JsonPrinter for instances of classes to make it produce consistent result across targets ([#6801](https://github.com/HaxeFoundation/haxe/issues/6801))
* all : fixed infinite recursion on `@:generic` field access ([#6430](https://github.com/HaxeFoundation/haxe/issues/6430))
* all : fixed infinite recursion related to printing of objects with circular references ([#8113](https://github.com/HaxeFoundation/haxe/issues/8113))
* all : fixed Int64 parsing of negative numbers that end in a zero ([#5493](https://github.com/HaxeFoundation/haxe/issues/5493))
* all : fixed invalid static extension lookup on `super` ([#3607](https://github.com/HaxeFoundation/haxe/issues/3607))
* all : fixed invalid visibility unification with statics ([#7527](https://github.com/HaxeFoundation/haxe/issues/7527))
* all : fixed issue with `@:generic` type parameters not being bound to Dynamic ([#8102](https://github.com/HaxeFoundation/haxe/issues/8102))
* all : fixed issue with various functions not being displayed in macro context ([#6000](https://github.com/HaxeFoundation/haxe/issues/6000))
* all : fixed local variable type information being lost on the compilation server ([#8511](https://github.com/HaxeFoundation/haxe/issues/8511))
* all : fixed macro `@:from` methods allowing any return type ([#8463](https://github.com/HaxeFoundation/haxe/issues/8463))
* all : fixed optional status of overloaded arguments with default values ([#7794](https://github.com/HaxeFoundation/haxe/issues/7794))
* all : fixed overeager recursive inline check ([#8489](https://github.com/HaxeFoundation/haxe/issues/8489))
* all : fixed pattern matcher allowing invalid abstract unification ([#8579](https://github.com/HaxeFoundation/haxe/issues/8579))
* all : fixed pattern matcher issue with wildcards in or-patterns ([#8296](https://github.com/HaxeFoundation/haxe/issues/8296))
* all : fixed resolution order between `untyped` and type parameters ([#7113](https://github.com/HaxeFoundation/haxe/issues/7113))
* all : fixed the pattern matcher allowing inexhaustive switches in value-places ([#8277](https://github.com/HaxeFoundation/haxe/issues/8277))
* all : fixed the XML printer trimming CDATA content ([#7454](https://github.com/HaxeFoundation/haxe/issues/7454))
* all : fixed top-down inference on abstract setters ([#7674](https://github.com/HaxeFoundation/haxe/issues/7674))
* all : fixed top-down inference when constructing enums ([#6606](https://github.com/HaxeFoundation/haxe/issues/6606))
* all : fixed typing error when constructing enums with abstracts over functions ([#6609](https://github.com/HaxeFoundation/haxe/issues/6609))
* all : fixed unbound variable error in anonymous functions ([#6674](https://github.com/HaxeFoundation/haxe/issues/6674))
* all : fixed unification behavior in try/catch expressions ([#7120](https://github.com/HaxeFoundation/haxe/issues/7120))
* all : fixed unification of recursive typedefs again ([#8523](https://github.com/HaxeFoundation/haxe/issues/8523))
* all : fixed various GADT-related problems ([#7672](https://github.com/HaxeFoundation/haxe/issues/7672))
* all : fixed various hangs related to abstracts ([#8588](https://github.com/HaxeFoundation/haxe/issues/8588))
* all : fixed various issues related to `@:structInit`
* all : fixed various issues with diagnostics
* all : fixed various issues with startIndex handling on String.indexOf and String.lastIndexOf
* all : fixed various minor inlining issues
* all : fixed various pattern matching problems
* all : fixed various pattern matching problems
* all : fixed various position and replace ranges in the display API
* all : fixed various priority issues regarding loops and iterators
* all : fixed various problems related to DCE and feature-handling ([#7694](https://github.com/HaxeFoundation/haxe/issues/7694))
* all : fixed various wrong positions when encoding data to macros
* all : fixed visibility check related to private constructors of sibling classes ([#6957](https://github.com/HaxeFoundation/haxe/issues/6957))
* all : specified String.indexOf with out-of-bounds indices ([#7601](https://github.com/HaxeFoundation/haxe/issues/7601))
* all : sys.Http: fix chunked encoding handling ([#6763](https://github.com/HaxeFoundation/haxe/issues/6763))
* all: fixed regression of macro `@:from` methods on abstracts ([#8779](https://github.com/HaxeFoundation/haxe/issues/8779))
* all: fixed regression, which caused compiler to crash on enum abstracts with explicit casting ([#8765](https://github.com/HaxeFoundation/haxe/issues/8765))
* all: fixed switching on `this` ([#8781](https://github.com/HaxeFoundation/haxe/issues/8781))
* cpp : fixed Socket flags not being preserved ([#7989](https://github.com/HaxeFoundation/haxe/issues/7989))
* cpp : fixed some leftover unicode issues
* cpp : fixed various issues related to casts
* cs : fix order-dependent enum type parameter issue ([#6016](https://github.com/HaxeFoundation/haxe/issues/6016))
* cs : fixed "This expression may be invalid" false warning ([#8589](https://github.com/HaxeFoundation/haxe/issues/8589))
* cs : fixed bad evaluation order in structures ([#7531](https://github.com/HaxeFoundation/haxe/issues/7531))
* cs : fixed NativeArray casting ([#3949](https://github.com/HaxeFoundation/haxe/issues/3949))
* cs/java : fixed DCE bug that would lose toString method of thrown objects
* cs/python : fixed various issues with code generation
* display : fixed completion in packages starting with underscore ([#5417](https://github.com/HaxeFoundation/haxe/issues/5417))
* eval : don't lose dynamic function inits from parent classes ([#6660](https://github.com/HaxeFoundation/haxe/issues/6660))
* eval : fixed bad string conversions on invalid + operations
* eval : fixed bug with equality handling
* eval : fixed infinite recursion when printing arrays/vectors
* eval : fixed int switch bug related to overflows
* eval : fixed internal exception surfacing in some context calls ([#7007](https://github.com/HaxeFoundation/haxe/issues/7007))
* eval : fixed invalid override detection ([#6583](https://github.com/HaxeFoundation/haxe/issues/6583))
* eval : fixed issue with file creation not defaulting to binary
* eval : fixed Socket.setTimeout ([#7682](https://github.com/HaxeFoundation/haxe/issues/7682))
* eval : fixed Type.enumEq ([#6710](https://github.com/HaxeFoundation/haxe/issues/6710))
* eval : fixed various problems with the debugger
* eval : fixed Vector.fromArrayCopy ([#7492](https://github.com/HaxeFoundation/haxe/issues/7492))
* flash : fix various issues, including native `protected` handling and method overloading
* flash : fixed silently swallowing exceptions in getters/setters when invoked with Reflect methods (#5460, #6871)
* flash : fixed var field access on interfaces being uncast ([#7727](https://github.com/HaxeFoundation/haxe/issues/7727))
* hl : fixed sqlite connection on OSX/Linux ([#8878](https://github.com/HaxeFoundation/haxe/issues/8878))
* hl : fixed various String Unicode issues
* java : fixed backslash escaping on `EReg.replace` ([#3430](https://github.com/HaxeFoundation/haxe/issues/3430))
* java : fixed null exception in CallStack.exceptionStack ([#8322](https://github.com/HaxeFoundation/haxe/issues/8322))
* java : fixed Std.is on non-reference and unrelated types ([#5168](https://github.com/HaxeFoundation/haxe/issues/5168))
* java/jvm : fix switch on null string ([#4481](https://github.com/HaxeFoundation/haxe/issues/4481))
* java/macro : fixed null-pointer exception in Reflect.getProperty ([#4934](https://github.com/HaxeFoundation/haxe/issues/4934))
* js : fixed bad stack handling on `Map` constraint checks ([#7781](https://github.com/HaxeFoundation/haxe/issues/7781))
* js : fixed code generation issue related to negative abstract values ([#8318](https://github.com/HaxeFoundation/haxe/issues/8318))
* js : fixed DCE issues related to haxe.CallStack ([#7908](https://github.com/HaxeFoundation/haxe/issues/7908))
* js : fixed js syntax error for `value.iterator--` ([#6637](https://github.com/HaxeFoundation/haxe/issues/6637))
* js : fixed saving setter to `tmp` var before invocation ([#6672](https://github.com/HaxeFoundation/haxe/issues/6672))
* js : fixed syntax problem related to `instanceof` ([#7653](https://github.com/HaxeFoundation/haxe/issues/7653))
* js : fixed typed array APIs ([#8422](https://github.com/HaxeFoundation/haxe/issues/8422))
* jvm : fixed boxed vs. unboxed comparison ([#8577](https://github.com/HaxeFoundation/haxe/issues/8577))
* jvm : generate toplevel types to haxe.root like genjava does ([#8590](https://github.com/HaxeFoundation/haxe/issues/8590))
* jvm : improved 32bit support ([#8601](https://github.com/HaxeFoundation/haxe/issues/8601))
* lua : fix toString behavior in the case of -0 ([#6652](https://github.com/HaxeFoundation/haxe/issues/6652))
* lua : fixed `@:expose` for classes inside packages ([#7849](https://github.com/HaxeFoundation/haxe/issues/7849))
* lua : fixed `EReg.map` for unicode ([#8861](https://github.com/HaxeFoundation/haxe/issues/8861))
* lua : fixed `StringTools.fastCodeAt` with `-D lua-vanilla` ([#7589](https://github.com/HaxeFoundation/haxe/issues/7589))
* lua : fixed broken output when compiling through the compilation server ([#7851](https://github.com/HaxeFoundation/haxe/issues/7851))
* lua : fixed issue where Process output occasionally is missing some data
* lua : properly bind field functions when passed as arguments ([#6722](https://github.com/HaxeFoundation/haxe/issues/6722))
* macro : fixed Array.pop handling ([#8075](https://github.com/HaxeFoundation/haxe/issues/8075))
* macro : fixed assertion failure when throwing exception ([#8039](https://github.com/HaxeFoundation/haxe/issues/8039))
* macro : fixed Sys.programPath assertion failure ([#8466](https://github.com/HaxeFoundation/haxe/issues/8466))
* macro : fixed various uncatchable exceptions being thrown
* php : don't fail on generating import aliases for classes with the similar names ([#6680](https://github.com/HaxeFoundation/haxe/issues/6680))
* php : error on case-insensitive name clashes ([#8219](https://github.com/HaxeFoundation/haxe/issues/8219))
* php : Escape `$` in field names of anonymous objects ([#7230](https://github.com/HaxeFoundation/haxe/issues/7230))
* php : fixed `-2147483648` as init value for static vars ([#5289](https://github.com/HaxeFoundation/haxe/issues/5289))
* php : fixed `Sys.environment()` to also return variables set by `Sys.putEnv()`
* php : fixed `sys.net.Socket.bind()` ([#6693](https://github.com/HaxeFoundation/haxe/issues/6693))
* php : fixed accessing `static inline var` via reflection ([#6630](https://github.com/HaxeFoundation/haxe/issues/6630))
* php : fixed an issue with "Object" used as a class name for PHP 7.2 (it's a new keyword in php) ([#6838](https://github.com/HaxeFoundation/haxe/issues/6838))
* php : fixed appending "sqlite:" prefix to the names of files created by `sys.db.Sqlite.open()` ([#6692](https://github.com/HaxeFoundation/haxe/issues/6692))
* php : fixed class naming conflicts ([#7716](https://github.com/HaxeFoundation/haxe/issues/7716))
* php : fixed iterator fields on maps being removed ([#8851](https://github.com/HaxeFoundation/haxe/issues/8851))
* php : fixed Math.min() and Math.max() for NAN on PHP 7.1.9 and 7.1.10
* php : fixed multiple file uploads in php.Web.parseMultiPart() ([#4173](https://github.com/HaxeFoundation/haxe/issues/4173))
* php : fixed php error on parsing expressions like `a == b == c` ([#6720](https://github.com/HaxeFoundation/haxe/issues/6720))
* php : fixed Reflect.callMethod with classes as first argument ([#7106](https://github.com/HaxeFoundation/haxe/issues/7106))
* php : Generate `switch` as `if...else if...else...` to avoid loose comparison ([#7257](https://github.com/HaxeFoundation/haxe/issues/7257))
* php : made php.Lib.objectOfAssociativeArray() recursive ([#6698](https://github.com/HaxeFoundation/haxe/issues/6698))
* php: fix field access on `new MyClass()` expressions wrapped in a `cast` ([#6294](https://github.com/HaxeFoundation/haxe/issues/6294))
* php: fix invoking functions stored in dynamic static vars ([#6158](https://github.com/HaxeFoundation/haxe/issues/6158))
* php/php7: fix "cannot implement previously implemented interface" ([#6208](https://github.com/HaxeFoundation/haxe/issues/6208))
* php/php7: fixed accessing enum constructors on enum type stored to a variable ([#6159](https://github.com/HaxeFoundation/haxe/issues/6159))
* php/python : fixed some bit operators for Int32 ([#5938](https://github.com/HaxeFoundation/haxe/issues/5938))
* php7: fix `@:enum abstract` generation  without `-dce full` ([#6175](https://github.com/HaxeFoundation/haxe/issues/6175))
* php7: fix `null` property access ([#6281](https://github.com/HaxeFoundation/haxe/issues/6281))
* php7: fix haxe.io.Input.readAll() with disabled analyzer optimizations ([#6387](https://github.com/HaxeFoundation/haxe/issues/6387))
* php7: fix Reflect.field() for strings ([#6276](https://github.com/HaxeFoundation/haxe/issues/6276))
* php7: fix setting values in a map stored in another map ([#6257](https://github.com/HaxeFoundation/haxe/issues/6257))
* php7: fix using enum constructor with arguments as a call argument ([#6177](https://github.com/HaxeFoundation/haxe/issues/6177))
* python : fixed modulo by a negative number ([#8845](https://github.com/HaxeFoundation/haxe/issues/8845))
* sys : fixed various Unicode issues ([#8135](https://github.com/HaxeFoundation/haxe/issues/8135))

__Removals__:

* all : consistently disallowed metadata in lambda function arguments ([#7800](https://github.com/HaxeFoundation/haxe/issues/7800))
* all : disallowed `\x` with values > 0x7F ([#8141](https://github.com/HaxeFoundation/haxe/issues/8141))
* all : disallowed `implements Dynamic` on non-extern classes ([#6191](https://github.com/HaxeFoundation/haxe/issues/6191))
* all : disallowed default values on interface variables ([#4087](https://github.com/HaxeFoundation/haxe/issues/4087))
* all : disallowed get_x/set_x property syntax, use get/set instead ([#4699](https://github.com/HaxeFoundation/haxe/issues/4699))
* all : disallowed macro-in-macro calls ([#7496](https://github.com/HaxeFoundation/haxe/issues/7496))
* all : moved haxe.remoting to hx3compat
* all : moved haxe.unit to hx3compat
* all : moved haxe.web.Dispatch into hx3compat library (https://github.com/HaxeFoundation/hx3compat).
* all : moved haxe.web.Request to hx3compat
* all : remove support for `@:fakeEnum` enums
* all : removed --eval command line argument
* all : removed `--gen-hx-classes` ([#8237](https://github.com/HaxeFoundation/haxe/issues/8237))
* all : removed `-D use-rtti-doc`, always store documentation instead ([#7493](https://github.com/HaxeFoundation/haxe/issues/7493))
* all : removed support for `T:(A, B)` constraint syntax
* all : warn about expressions in extern non-inline fields ([#5898](https://github.com/HaxeFoundation/haxe/issues/5898))
* it's recommended to use more modern js.jquery.JQuery and js.swfobject.SWFObject classes.
* js : js.JQuery and js.SWFObject were moved into hx3compat library (https://github.com/HaxeFoundation/hx3compat),
* js : moved js.XMLSocket to hx3compat
* js : removed jQuery and swfobject externs ([#7494](https://github.com/HaxeFoundation/haxe/issues/7494))
* macro : deprecated Context.registerModuleReuseCall and onMacroContextReused ([#5746](https://github.com/HaxeFoundation/haxe/issues/5746))
* neko : moved neko.net to hx3compat
* php : deprecated support for `untyped __php__`, `untyped __call__` etc. Use `php.Syntax` instead.
* php : dropped php5 support; minimum supported php version is 7.0 now
* php : removed `php.Syntax.binop()` ([#6708](https://github.com/HaxeFoundation/haxe/issues/6708))
* sys : SPOD (sys.db.Object, sys.db.Manager and friends) was moved into a separate library `record-macros` (https://github.com/HaxeFoundation/record-macros)
