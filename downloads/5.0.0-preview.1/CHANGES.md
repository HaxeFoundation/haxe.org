
## 2025-07-04 5.0.0-preview.1

__Removal__:

* all : remove 32 bit windows builds ([#11541](https://github.com/HaxeFoundation/haxe/issues/11541))
* all : move `sys.db`, `php.Web` and `neko.Web` to `hx4compat` lib ([#11385](https://github.com/HaxeFoundation/haxe/issues/11385))
* all : move `haxe.remoting` to `hx4compat` lib ([#11387](https://github.com/HaxeFoundation/haxe/issues/11387))
* all : remove haxe.Ucs2 ([#12103](https://github.com/HaxeFoundation/haxe/issues/12103))
* hl : move some hl.Format into lib format/heaps ([#11869](https://github.com/HaxeFoundation/haxe/issues/11869))
* js : remove previously deprecated `untyped __js__` and friends ([#11471](https://github.com/HaxeFoundation/haxe/issues/11471))
* java/cs : remove C# and Java targets ([#11551](https://github.com/HaxeFoundation/haxe/issues/11551))
* macro : remove some API from haxe.macro.Compiler ([#11540](https://github.com/HaxeFoundation/haxe/issues/11540))
* macro : remove CompilationServer.setModuleCheckPolicy options ([#11615](https://github.com/HaxeFoundation/haxe/issues/11615))

__Breaking changes__:

* all : rework module resolution ([#11168](https://github.com/HaxeFoundation/haxe/issues/11168))
* all : don't infer string on concat ([#11318](https://github.com/HaxeFoundation/haxe/issues/11318))
* all : delay typer creation to after init macros ([#11323](https://github.com/HaxeFoundation/haxe/issues/11323))
* all : disallow partial resolution (pack.SubType access when module is imported) ([#11338](https://github.com/HaxeFoundation/haxe/issues/11338))
* all : don't create a class field for every enum field ([#11452](https://github.com/HaxeFoundation/haxe/issues/11452))
* all : only set cf_expr_unoptimized if we think we need it ([#11462](https://github.com/HaxeFoundation/haxe/issues/11462))
* all : fix the way optional arguments are handled when using `bind` ([#11533](https://github.com/HaxeFoundation/haxe/issues/11533))
* all : don't bind foreign type parameters in definition mode ([#11658](https://github.com/HaxeFoundation/haxe/issues/11658))
* all : disallow duplicate argument name ([#11978](https://github.com/HaxeFoundation/haxe/issues/11978))
* all :  fix types in null coal null check ([#11726](https://github.com/HaxeFoundation/haxe/issues/11726))
* macro : Build macro order vs inheritance ([#11582](https://github.com/HaxeFoundation/haxe/issues/11582))
* macro : disallow defining types into existing modules ([#11845](https://github.com/HaxeFoundation/haxe/issues/11845))

__General improvements__:

* all : hxb (new server cache + pre compilation) ([#11504](https://github.com/HaxeFoundation/haxe/issues/11504))
* all : rework module resolution ([#11168](https://github.com/HaxeFoundation/haxe/issues/11168))
* all : add "Custom" target ([#11128](https://github.com/HaxeFoundation/haxe/issues/11128))
* all : private getters/setters ([#12204](https://github.com/HaxeFoundation/haxe/issues/12204))
* all : allow boolean operators in patterns ([#11157](https://github.com/HaxeFoundation/haxe/issues/11157))
* all : explicitly apply default type parameter ([#12002](https://github.com/HaxeFoundation/haxe/issues/12002))
* all : allow modification of loop var in IntIterator loop ([#8581](https://github.com/HaxeFoundation/haxe/issues/8581))
* all : support overloading true extern constructors ([#11979](https://github.com/HaxeFoundation/haxe/issues/11979))
* all : support f?.bind() ([#11571](https://github.com/HaxeFoundation/haxe/issues/11571))
* all : rework defines ([#12130](https://github.com/HaxeFoundation/haxe/issues/12130), [#12251](https://github.com/HaxeFoundation/haxe/issues/12251))
* all : abort compilation on first error with -D fail-fast ([#11609](https://github.com/HaxeFoundation/haxe/issues/11609))
* all : add position and error message to decode_error.txt ([#12128](https://github.com/HaxeFoundation/haxe/issues/12128))
* all : add configuration options for -D dump, set -D dump-ignore-var-ids by default ([#12150](https://github.com/HaxeFoundation/haxe/issues/12150), [#12130](https://github.com/HaxeFoundation/haxe/issues/12130))
* all : add support for binary literal ([#11627](https://github.com/HaxeFoundation/haxe/issues/11627))
* all : add support for --undefine to remove define ([#11400](https://github.com/HaxeFoundation/haxe/issues/11400))
* all : add optional WUnsafeEnumEquality ([#11813](https://github.com/HaxeFoundation/haxe/issues/11813))
* all : build macOS universal binaries ([#11572](https://github.com/HaxeFoundation/haxe/issues/11572))
* all : [experiments] run parts of the compiler in parallel with `-D enable-parallelism` ([#12070](https://github.com/HaxeFoundation/haxe/issues/12070), [#12134](https://github.com/HaxeFoundation/haxe/issues/12134), [#12081](https://github.com/HaxeFoundation/haxe/issues/12081), [#12252](https://github.com/HaxeFoundation/haxe/issues/12252))
* all : [std] add enum as haxe.Unit ([#11563](https://github.com/HaxeFoundation/haxe/issues/11563))
* all : [std] add BigInteger type ([#10750](https://github.com/HaxeFoundation/haxe/issues/10750))
* all : [std] add haxe.runtime.Copy ([#11863](https://github.com/HaxeFoundation/haxe/issues/11863))
* all : [std] haxe.Timer.milliseconds ([#12260](https://github.com/HaxeFoundation/haxe/issues/12260))
* all : [std] String.indexOf ([#7402](https://github.com/HaxeFoundation/haxe/issues/7402), [#11569](https://github.com/HaxeFoundation/haxe/issues/11569))
* all : [std] add StringBuf.clear() ([#11848](https://github.com/HaxeFoundation/haxe/issues/11848))
* all : [std] allow setting haxe.Exception.stack ([#12213](https://github.com/HaxeFoundation/haxe/issues/12213))
* all : [std] Serializer: implement reset method ([#12068](https://github.com/HaxeFoundation/haxe/issues/12068))
* all : [std] use Vectors in haxe.zip ([#11034](https://github.com/HaxeFoundation/haxe/issues/11034))
* all : [messageReparting] pretty errors as default message reporting ([#11587](https://github.com/HaxeFoundation/haxe/issues/11587))
* all : [messageReporting] add config to use absolute positions ([#11439](https://github.com/HaxeFoundation/haxe/issues/11439))
* all : [display] diagnostics as json rpc ([#11412](https://github.com/HaxeFoundation/haxe/issues/11412))
* all : [display] report null safety errors in diagnostics ([#11729](https://github.com/HaxeFoundation/haxe/issues/11729))
* all : [display] add server/resetCache ([#11482](https://github.com/HaxeFoundation/haxe/issues/11482))
* all : [server] add support for ipv6 addresses for --wait/--connect ([#11310](https://github.com/HaxeFoundation/haxe/issues/11310))
* all : [server] improve GC stats tracking ([#12246](https://github.com/HaxeFoundation/haxe/issues/12246))
* all : [server] remove custom ocaml GC handling ([#12287](https://github.com/HaxeFoundation/haxe/issues/12287))
* hl : bump default hl_version to 1.15 for haxe 5 ([#12065](https://github.com/HaxeFoundation/haxe/issues/12065))
* hl : add std.hl.Gc.getLiveObjects ([#11599](https://github.com/HaxeFoundation/haxe/issues/11599))
* hl : add element type to HArray ([#11734](https://github.com/HaxeFoundation/haxe/issues/11734))
* hl : optimize single char String and adding with empty string
* hl : added guid type
* hl : hl.Profile.event give code some meaning with enum abstract ([#12262](https://github.com/HaxeFoundation/haxe/issues/12262))
* jvm : improve NativeOutput performance ([#11944](https://github.com/HaxeFoundation/haxe/issues/11944))
* jvm : functional interface support ([#11019](https://github.com/HaxeFoundation/haxe/issues/11019))
* cpp : add Tracy profiler extern ([#11772](https://github.com/HaxeFoundation/haxe/issues/11772))
* cppia : generate full debug source paths ([#12053](https://github.com/HaxeFoundation/haxe/issues/12053))
* js : use native maps when ES6 is enabled ([#11698](https://github.com/HaxeFoundation/haxe/issues/11698))
* js : remove String.fromCodePoint polyfill for es6 ([#11713](https://github.com/HaxeFoundation/haxe/issues/11713))
* js : add the canParse() and parse() static methods to URL ([#11802](https://github.com/HaxeFoundation/haxe/issues/11802))
* js : add externs for the Screen Wake Lock API ([#11421](https://github.com/HaxeFoundation/haxe/issues/11421))
* js : add externs for the Web Share API ([#11423](https://github.com/HaxeFoundation/haxe/issues/11423))
* js : update Object and Symbol externs ([#11331](https://github.com/HaxeFoundation/haxe/issues/11331))
* js : clean up ES5 implementation of StringMap.keys() ([#11895](https://github.com/HaxeFoundation/haxe/issues/11895))
* js : add new WebGLPolygonMode extension ([#12026](https://github.com/HaxeFoundation/haxe/issues/12026))
* js : add js.lib.NativeStringTools ([#12127](https://github.com/HaxeFoundation/haxe/issues/12127))
* php : add externs for some POSIX functions ([#11769](https://github.com/HaxeFoundation/haxe/issues/11769))
* macro : delay typer creation to after init macros ([#11323](https://github.com/HaxeFoundation/haxe/issues/11323))
* macro : added Context.resolveComplexType
* macro : add TypeTools.toBaseType() ([#11153](https://github.com/HaxeFoundation/haxe/issues/11153))
* macro : add TypeTools.resolveTypeParameters ([#11053](https://github.com/HaxeFoundation/haxe/issues/11053))
* macro : add PositionTools.toZeroRange(pos) to avoid messing up display requests ([#11892](https://github.com/HaxeFoundation/haxe/issues/11892))
* macro : apply @:using after build macros ([#11625](https://github.com/HaxeFoundation/haxe/issues/11625))
* macro : include module path in virtual file names ([#11852](https://github.com/HaxeFoundation/haxe/issues/11852))
* macro : respect imports on @:build ([#11373](https://github.com/HaxeFoundation/haxe/issues/11373))
* macro : [server] expose compilation server stats ([#12290](https://github.com/HaxeFoundation/haxe/issues/12290))
* macro : [server] add memory print that support details for macro interpreter ([#11644](https://github.com/HaxeFoundation/haxe/issues/11644))
* eval : atomics ([#12275](https://github.com/HaxeFoundation/haxe/issues/12275))

__Bugfixes__:

* all : fix @:wrappedException type ([#11140](https://github.com/HaxeFoundation/haxe/issues/11140))
* all : don't allow null-only switches if we need a value ([#11366](https://github.com/HaxeFoundation/haxe/issues/11366))
* all : detect recursive hxmls ([#11580](https://github.com/HaxeFoundation/haxe/issues/11580))
* all : use local name instead of temp name for ?? ([#11464](https://github.com/HaxeFoundation/haxe/issues/11464))
* all : fix local statics vs display requests ([#11849](https://github.com/HaxeFoundation/haxe/issues/11849))
* all : fix unclosed monomorphs in function signature ([#11381](https://github.com/HaxeFoundation/haxe/issues/11381))
* all : update target config after init macros ([#11985](https://github.com/HaxeFoundation/haxe/issues/11985))
* all : local static vs local functions ([#11999](https://github.com/HaxeFoundation/haxe/issues/11999))
* all : fix null coal assign ([#11980](https://github.com/HaxeFoundation/haxe/issues/11980))
* all : static extension with name `_new` resolving incorrectly to abstract new ([#11994](https://github.com/HaxeFoundation/haxe/issues/11994))
* all : allow Single div without cast to Float ([#12039](https://github.com/HaxeFoundation/haxe/issues/12039))
* all : recurse into singularly constrained monos for field collection ([#11918](https://github.com/HaxeFoundation/haxe/issues/11918))
* all : also skip mono ids if -D dump-ignore-var-ids ([#12126](https://github.com/HaxeFoundation/haxe/issues/12126))
* all : renamed `-D *-times` defines to `-D times.*` ([#12101](https://github.com/HaxeFoundation/haxe/issues/12101))
* all : apply @:haxe.warning rules to cached warnings too ([#11775](https://github.com/HaxeFoundation/haxe/issues/11775))
* all : avoid some capture variable wrapping in non-loops ([#12235](https://github.com/HaxeFoundation/haxe/issues/12235))
* all : @:noCompletion vs. static extensions ([#12254](https://github.com/HaxeFoundation/haxe/issues/12254))
* all : use available terminal columns instead of hardcoded 80 columns ([#11404](https://github.com/HaxeFoundation/haxe/issues/11404))
* all : track actual path position for `path.Path<Params>` ([#11405](https://github.com/HaxeFoundation/haxe/issues/11405))
* all : set --run args only when we're actually running ([#11524](https://github.com/HaxeFoundation/haxe/issues/11524))
* all : [std] do not close unowned socket in Http.customRequest ([#12069](https://github.com/HaxeFoundation/haxe/issues/12069))
* all : [std] fix zipfiles not having data descriptor after filedata ([#11686](https://github.com/HaxeFoundation/haxe/issues/11686))
* all : [std] implement EnumValueMap.compareArg properly ([#12139](https://github.com/HaxeFoundation/haxe/issues/12139))
* all : [std] Syntax.code: remove double curly braces escaping ([#11231](https://github.com/HaxeFoundation/haxe/issues/11231))
* all : [typer] check default type parameter constraints ([#11556](https://github.com/HaxeFoundation/haxe/issues/11556))
* all : [typer] fix custom array access temp var handling ([#11248](https://github.com/HaxeFoundation/haxe/issues/11248))
* all : [typer] valid redefinition rework ([#11657](https://github.com/HaxeFoundation/haxe/issues/11657))
* all : [typer] give better "Cannot extend by" error ([#11352](https://github.com/HaxeFoundation/haxe/issues/11352))
* all : [typer] delay unknown ident errors in overloads ([#11372](https://github.com/HaxeFoundation/haxe/issues/11372))
* all : [typer] support safe nav for assign ops ([#11379](https://github.com/HaxeFoundation/haxe/issues/11379))
* all : [typer] don't allow @:structInit to call abstract constructors ([#11342](https://github.com/HaxeFoundation/haxe/issues/11342))
* all : [typer] align null coalescing top down inference with normal if/else ([#11425](https://github.com/HaxeFoundation/haxe/issues/11425))
* all : [typer] deal with for (i in throw) ([#11403](https://github.com/HaxeFoundation/haxe/issues/11403))
* all : [typer] type operator lhs against expected type ([#11428](https://github.com/HaxeFoundation/haxe/issues/11428))
* all : [typer] consume bypass_accessor only if it's actually relevant ([#11488](https://github.com/HaxeFoundation/haxe/issues/11488))
* all : [typer] don't hide abstract type when resolving through @:forward ([#11526](https://github.com/HaxeFoundation/haxe/issues/11526))
* all : [typer] don't consider @:structInit + @:from when inferring ([#11535](https://github.com/HaxeFoundation/haxe/issues/11535))
* all : [typer] avoid lhs cast on ambiguous operators ([#12146](https://github.com/HaxeFoundation/haxe/issues/12146))
* all : [typer] abstract vs. mono hard unification error ([#12182](https://github.com/HaxeFoundation/haxe/issues/12182))
* all : [typer] follow through abstract underlying types for null-checks when matching ([#11716](https://github.com/HaxeFoundation/haxe/issues/11716))
* all : [typer] fix Monomorph vs `Null<T>` inference issue ([#11851](https://github.com/HaxeFoundation/haxe/issues/11851))
* all : [typer] fail softer on multiple read/write resolve methods ([#11757](https://github.com/HaxeFoundation/haxe/issues/11757))
* all : [typer] always allow local function type parameters ([#11520](https://github.com/HaxeFoundation/haxe/issues/11520))
* all : [typer] disallow ?.new and ?.match ([#11799](https://github.com/HaxeFoundation/haxe/issues/11799))
* all : [generics] use tclass instead of TType.t for substitution ([#11784](https://github.com/HaxeFoundation/haxe/issues/11784))
* all : [generics] ensure type substitution happens for closures too ([#12173](https://github.com/HaxeFoundation/haxe/issues/12173))
* all : [xml] fix when string ends with escape sequence ([#11883](https://github.com/HaxeFoundation/haxe/issues/11883))
* all : [xml] fixed xml cased escape sequences ([#11914](https://github.com/HaxeFoundation/haxe/issues/11914))
* all : [analyzer] inline ctors improved handling of ignored exprs ([#11356](https://github.com/HaxeFoundation/haxe/issues/11356))
* all : [analyzer] fix captured checks in constructor inliner ([#11356](https://github.com/HaxeFoundation/haxe/issues/11356))
* all : [analyzer] fix for inline constructors bug ([#12169](https://github.com/HaxeFoundation/haxe/issues/12169))
* all : [analyzer] fix stack overflow on empty TBlock ([#11393](https://github.com/HaxeFoundation/haxe/issues/11393))
* all : [analyzer] disallow Void in compound block expressions ([#11391](https://github.com/HaxeFoundation/haxe/issues/11391))
* all : [analyzer] reconstruct binops in return ([#12243](https://github.com/HaxeFoundation/haxe/issues/12243))
* all : [analyzer] send all types to analyzer for purity inference ([#12224](https://github.com/HaxeFoundation/haxe/issues/12224))
* all : [analyzer] const propagation typing fixes ([#12059](https://github.com/HaxeFoundation/haxe/issues/12059))
* all : [filters] avoid overlap work if we reserve anyway ([#11174](https://github.com/HaxeFoundation/haxe/issues/11174))
* all : [filters] recurse into expressions of local statics ([#11469](https://github.com/HaxeFoundation/haxe/issues/11469))
* all : [nullSafety] don't check return expr in assignments ([#11114](https://github.com/HaxeFoundation/haxe/issues/11114))
* all : [nullSafety] only process fields that do not have CfPostProcessed flag ([#11185](https://github.com/HaxeFoundation/haxe/issues/11185))
* all : [nullSafety] fix null arg check ([#11076](https://github.com/HaxeFoundation/haxe/issues/11076))
* all : [nullSafety] detect nulls in structs ([#11099](https://github.com/HaxeFoundation/haxe/issues/11099))
* all : [nullSafety] more nullSafety compatibility in std ([#12141](https://github.com/HaxeFoundation/haxe/issues/12141))
* all : [nullSafety] better error range for anon fields ([#12188](https://github.com/HaxeFoundation/haxe/issues/12188))
* all : [nullSafety] improve control flow in binops ([#12197](https://github.com/HaxeFoundation/haxe/issues/12197))
* all : [nullSafety] some inline api fixes ([#12210](https://github.com/HaxeFoundation/haxe/issues/12210))
* all : [nullSafety] allow statics init in main ([#12211](https://github.com/HaxeFoundation/haxe/issues/12211))
* all : [parser] fix ?? precedence ([#11144](https://github.com/HaxeFoundation/haxe/issues/11144))
* all : [parser] catch duplicate #else ([#11208](https://github.com/HaxeFoundation/haxe/issues/11208))
* all : [parser] check for Eof ([#11368](https://github.com/HaxeFoundation/haxe/issues/11368))
* all : [parser] detect trailing metadata ([#11389](https://github.com/HaxeFoundation/haxe/issues/11389))
* all : [parser] allow using anonymous functions in operator expressions ([#12015](https://github.com/HaxeFoundation/haxe/issues/12015))
* all : [parser] fix format string reentrency ([#12159](https://github.com/HaxeFoundation/haxe/issues/12159))
* all : [printer] use parentheses for arrow function with argument default value ([#12248](https://github.com/HaxeFoundation/haxe/issues/12248))
* all : [display] avoid display issues with missing fields ([#11251](https://github.com/HaxeFoundation/haxe/issues/11251))
* all : [display] don't populate cache from xml diagnostics ([#11696](https://github.com/HaxeFoundation/haxe/issues/11696))
* all : [display] run some filters in diagnostics ([#11220](https://github.com/HaxeFoundation/haxe/issues/11220))
* all : [display] insert EDisplay in the proper position when parsing a call expression. ([#11441](https://github.com/HaxeFoundation/haxe/issues/11441))
* all : [display] use correct position for alias imports ([#11516](https://github.com/HaxeFoundation/haxe/issues/11516))
* all : [display] do not silently replace missing types with Dynamic ([#11760](https://github.com/HaxeFoundation/haxe/issues/11760))
* all : [display] catch 'die' calls in diagnostics ([#11984](https://github.com/HaxeFoundation/haxe/issues/11984))
* all : [display] browse for EDisplay when calls fail ([#11422](https://github.com/HaxeFoundation/haxe/issues/11422))
* all : [server] do not crash when client exits before end of compilation
* hl : rework `Null<Int/Float/Bool>` comparison for spec/alloc ([#11612](https://github.com/HaxeFoundation/haxe/issues/11612))
* hl : fix -D hl-check error pos ([#11727](https://github.com/HaxeFoundation/haxe/issues/11727))
* hl : fix interface override function resolution ([#11723](https://github.com/HaxeFoundation/haxe/issues/11723))
* hl : fix debug info missing for catch e:String, arg with unify error ([#11717](https://github.com/HaxeFoundation/haxe/issues/11717))
* hl : fix debug pos in assign when reg reuse arg ([#11808](https://github.com/HaxeFoundation/haxe/issues/11808))
* hl : use HDyn instead of erroring on recursive types ([#11844](https://github.com/HaxeFoundation/haxe/issues/11844))
* hl : fix array pos check, force UInt ([#11810](https://github.com/HaxeFoundation/haxe/issues/11810))
* hl : fix debug assigns not sorted when not optimize ([#12006](https://github.com/HaxeFoundation/haxe/issues/12006))
* hl : allow assign struct to packed ([#12043](https://github.com/HaxeFoundation/haxe/issues/12043))
* hl : consider _ prefix when checking reserved keywords ([#12090](https://github.com/HaxeFoundation/haxe/issues/12090))
* hl : fix no analyzer-optimize ([#12107](https://github.com/HaxeFoundation/haxe/issues/12107))
* hl : make Reflect.field work with enums ([#12117](https://github.com/HaxeFoundation/haxe/issues/12117))
* hl : CArray add blit, fix unsafeSet ([#12118](https://github.com/HaxeFoundation/haxe/issues/12118))
* hl : fix `__string` null access when toString return null ([#12143](https://github.com/HaxeFoundation/haxe/issues/12143))
* hl : fix debug function pos in wrapper, enum, init ([#12207](https://github.com/HaxeFoundation/haxe/issues/12207))
* hl : use classpaths relative_path for get_relative_path ([#12219](https://github.com/HaxeFoundation/haxe/issues/12219))
* hl : fix Type.typeof(HI64) to return TInt ([#12264](https://github.com/HaxeFoundation/haxe/issues/12264))
* hl : `haxe.io.BytesBuffer.__expand` check overflow ([#12267](https://github.com/HaxeFoundation/haxe/issues/12267))
* hl : added hl.Api.unsafeCast, allow CArray unsafe set
* hl : hlopt rework try-catch control flow ([#11581](https://github.com/HaxeFoundation/haxe/issues/11581))
* hl : make sure -dce full will not remove @:struct fields as they match native code
* hl : fix do-while loop in genhl+hlopt ([#11461](https://github.com/HaxeFoundation/haxe/issues/11461))
* hl/c: fix reserved keywords ([#11408](https://github.com/HaxeFoundation/haxe/issues/11408))
* hl/c : fix SMOD/SDIV overflow exception when INT_MIN / -1 ([#11917](https://github.com/HaxeFoundation/haxe/issues/11917))
* hl/c : split hl_init_roots to prevent out of heap in msvc ([#11988](https://github.com/HaxeFoundation/haxe/issues/11988))
* jvm : allow - in resource names ([#11275](https://github.com/HaxeFoundation/haxe/issues/11275))
* jvm : function arguments with type parameters not generating correctly ([#11362](https://github.com/HaxeFoundation/haxe/issues/11362))
* jvm : refer to static instance methods correctly ([#11023](https://github.com/HaxeFoundation/haxe/issues/11023))
* jvm : annotation rework ([#11398](https://github.com/HaxeFoundation/haxe/issues/11398))
* jvm : deal with complex static inits ([#11998](https://github.com/HaxeFoundation/haxe/issues/11998))
* jvm : deal with local function default arguments ([#12094](https://github.com/HaxeFoundation/haxe/issues/12094))
* jvm : assign dynamic method only if it's null ([#11530](https://github.com/HaxeFoundation/haxe/issues/11530))
* jvm : fix invokeDynamic arity
* jvm : use HashMap for IntMap too
* jvm : remove redundant ordinal comparison on enums ([#11591](https://github.com/HaxeFoundation/haxe/issues/11591))
* cpp : enum Type Checking ([#11444](https://github.com/HaxeFoundation/haxe/issues/11444))
* cpp : fix abstract class functions with default values ([#11667](https://github.com/HaxeFoundation/haxe/issues/11667))
* cpp : absolute paths with -D absolute-path ([#11763](https://github.com/HaxeFoundation/haxe/issues/11763))
* cpp : fix mismatching type and getter return on pointer ([#12055](https://github.com/HaxeFoundation/haxe/issues/12055))
* cpp : allow setting callback for cppia script load ([#12051](https://github.com/HaxeFoundation/haxe/issues/12051))
* cpp : prevent use of AtomicObject ([#11674](https://github.com/HaxeFoundation/haxe/issues/11674))
* cpp : do not store AtomicInt Gc memory in cpp.Pointer ([#12236](https://github.com/HaxeFoundation/haxe/issues/12236))
* js : fix wrong calculation for Int64 (ushr / add) methods ([#11868](https://github.com/HaxeFoundation/haxe/issues/11868))
* js : avoid optimizing Std.is away in api_inline ([#12133](https://github.com/HaxeFoundation/haxe/issues/12133))
* js : avoid crash in HttpNodeJs when no connection ([#12137](https://github.com/HaxeFoundation/haxe/issues/12137))
* js : remove weird class name omission ([#11071](https://github.com/HaxeFoundation/haxe/issues/11071))
* js : fix enums parameters generation to make it compatible with advanced JS minification tools ([#11328](https://github.com/HaxeFoundation/haxe/issues/11328))
* lua : emit class name even if not required ([#11112](https://github.com/HaxeFoundation/haxe/issues/11112))
* lua : fix do while loops ([#11807](https://github.com/HaxeFoundation/haxe/issues/11807))
* lua : fix for wrong left shift with -1 ([#11889](https://github.com/HaxeFoundation/haxe/issues/11889))
* lua : fix internal loop var updates ([#12193](https://github.com/HaxeFoundation/haxe/issues/12193))
* lua : fix unnecessary `_hx_do_first` ([#11453](https://github.com/HaxeFoundation/haxe/issues/11453))
* lua : allow generating sourcemaps for Lua in the same format as JS ([#11454](https://github.com/HaxeFoundation/haxe/issues/11454))
* lua : share metatables with other class instances ([#11103](https://github.com/HaxeFoundation/haxe/issues/11103))
* neko : optimise BytesBuffer length field ([#11090](https://github.com/HaxeFoundation/haxe/issues/11090))
* python : mark threads as daemon threads ([#12096](https://github.com/HaxeFoundation/haxe/issues/12096))
* hl/neko/eval : don't avoid exception wrapping ([#12049](https://github.com/HaxeFoundation/haxe/issues/12049))
* macro : catch eval runtime failures when decoding ([#11633](https://github.com/HaxeFoundation/haxe/issues/11633))
* macro : skip abstract impl classes when applying addGlobalMetadata ([#11546](https://github.com/HaxeFoundation/haxe/issues/11546))
* macro : don't exception-wrap every API function ([#11374](https://github.com/HaxeFoundation/haxe/issues/11374))
* macro : don't apply @:native names ([#11481](https://github.com/HaxeFoundation/haxe/issues/11481))
* macro : display failing macro for "Build failure" errors ([#11635](https://github.com/HaxeFoundation/haxe/issues/11635))
* macro : delay exclude macro turning types into externs until filters ([#11685](https://github.com/HaxeFoundation/haxe/issues/11685))
* macro : use better error position for null_pos uncaught exceptions ([#11788](https://github.com/HaxeFoundation/haxe/issues/11788))
* macro : fail nicer if we can't find a macro function ([#11776](https://github.com/HaxeFoundation/haxe/issues/11776))
* macro : deal with module fields in Compiler.exclude ([#11688](https://github.com/HaxeFoundation/haxe/issues/11688))
* macro : avoid polluting lexer cache with Context.parseInlineString ([#11920](https://github.com/HaxeFoundation/haxe/issues/11920))
* macro : account for sub-types in ComplexTypeTools.toComplex() ([#11273](https://github.com/HaxeFoundation/haxe/issues/11273))
* macro : build metadata with basic types from current context ([#11336](https://github.com/HaxeFoundation/haxe/issues/11336))
* macro : fix TVar resolution ([#11339](https://github.com/HaxeFoundation/haxe/issues/11339))
* macro : don't lose static modifier in ExprTools.map ([#12030](https://github.com/HaxeFoundation/haxe/issues/12030))
* eval : fix ssl cert verification failures on clean windows environments ([#11838](https://github.com/HaxeFoundation/haxe/issues/11838))
* eval : fix field typo in haxe.zip.Compress ([#11143](https://github.com/HaxeFoundation/haxe/issues/11143))
