2017-03-14: 3.4.1

__New features__:

* php7 : added source maps generation with `-D source_map` flag.

__Bugfixes__:

* all : fixed compilation server issue with two identical @:native paths on extern abstracts ([#5993](https://github.com/HaxeFoundation/haxe/issues/5993))
* all : fixed invalid inling in a specific case ([#6067](https://github.com/HaxeFoundation/haxe/issues/6067))
* all : fixed various display related issues
* cpp : improved typing of some Function/Callable-related types
* hl : various fixes and improvements
* php : fixed FileSystem.stat() for directories on Windows ([#6057](https://github.com/HaxeFoundation/haxe/issues/6057))
* php/php7 : fixed invalid result of Web.getPostData() ([#6033](https://github.com/HaxeFoundation/haxe/issues/6033))
* php7 : fixed invalid access to length of string in some cases ([#6055](https://github.com/HaxeFoundation/haxe/issues/6055))
* php7 : fixed infinite recursion on MysqlConnection.close() ([#6056](https://github.com/HaxeFoundation/haxe/issues/6056))