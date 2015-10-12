### 2015-10-11: __3.2.1__

__Bugfixes__:

* cs/java : fixed `-dce no` issues
* cs/java : fixed how KExpr type parameters are generated
* cs : fixed enum creation by reflection problem
* cpp : do not rely in reflection to make interfaces work for non-first interface parents
* cpp : fixed setting of static variables via reflection when class has no member variables* *
* cpp : make sure StringMap's h field is kept if we use StringMap* 
* js : Avoid the use of `eval`/`Function` to get the top-level defined type/var to not break ContentSecurityPolicy
