### 2008-07-28: __2.0__

* fixed current package bug in inherited constructor type
* delayed type-parameter constraints check (allow mutual rec extends for SPOD)
* improved unclosed macro error reporting
* haXe/PHP integration
* renamed NekoSocketConnection to SyncSocketConnection (php support)
* fixes in genAs3
* fix for flash9 : always coerce call return type
* set all private+protected names from SWF lib to public (allow override+reflect)
* flash9 : use findprop instead of findpropstrict for 'this' access (allow dynamic)
* don't allow nullness changes in overrided/implemented
* prevent typing hole with overriden polymorphic methods
* added neko.vm.Mutex and neko.vm.Deque (included in neko 1.7.1)
* added package remapping using --remap
