* genneko : remove big array error (fixed in neko 1.7.1)
* fixed neko.net.ThreadRemotingServer.onXML
* genswf9 : fixed verify error with `Null<Class>` (was using dynamic access)
* small patch for jsfl support
* added .cca for faster string operations on Flash9/Flash/JS
* bugfix with inlined local variables
* upgraded flash9 api to flex3/player 9.0.115
* override is now mandatory, no more --override
* dynamic is now a keyword
* f9dynamic is now dynamic and is mandatory on all platforms
* public/private/dynamic are inherited by default when overriding a method
* removed Reflect.empty() : use {} instead
* changed #else by #elseif, added #else
* flash9 : optimized Hash,IntHash,StringBuf (use typed value)
* Reflect.field/setField/callMethod , Type.enumIndex and StringBuf methods are now inlined
* optimized haxe.Md5 : don't use statics
* allow up to 8 parameters in Reflect.createInstance
* flash9 : some minor optimizations in haxe.Serializer
* added haxe.io package (removed things from neko.io)
* __resolve becomes resolve (and should be documented)
* added haxe.Int32
* removed neko.Int32
* removed neko.io.Input/Output/Eof/Error/Logger/Multiple/StringInput/StringOutput
* removed neko.net.RemotingServer
* changed neko apis to use haxe.io and Bytes instead of String buffers
* fixed big bug in js/flash8 debug stack handling
* complete rewrite of haxe.remoting package
* haxe.io.Bytes serialization support* (replace deprecated string support)
* removed === and !==
* removed Std.bool
* fixed : Reflect.field(null) in flash9 doesn't throw an error anymore
* removed Type.toClass and Type.toEnum
* Dynamic type is now a class and not an enum
* moved reflection support for core types from Boot to Std
* fixed Type.getClassName/getEnumName/resolve for core flash9 types
* renamed haxe.rtti.Type to haxe.rtti.CType (with changes in prefix)
* added haxe.TimerQueue, added haxe.Timer.delay, remove haxe.Timer.delayed
* flash9 : bugfix, generated interfaces were empty
* fixed bug while writing block-vars in flash/js
* added parameters default value (constants)
* removed Std.resource, Std.ord, Std.chr
* added haxe.Resource, allow binary data in resources
* added Type.createEnum
* check that local variables get correctly initialized before usage
* haxe.Stack support for flash9
