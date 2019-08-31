title: The New Haxe Target: HashLink InDepth - Part 1
author: nicolas
description: Find out more about HashLink, the newest Haxe target, a virtual machine used to develop system/server/desktop applications.
background: NVIDIA-Tegra-K1-Chip.jpg
published: true
tags: tech
disqusID: 22
---

*This is first post of a series of articles covering the new [HashLink](http://hashlink.haxe.org) target for Haxe, read [Part 2](https://haxe.org/blog/hashlink-in-depth-p2/)*

[HashLink](http://hashlink.haxe.org) is a new Haxe target that was announced a few weeks ago which I have worked on for the past year and thought about for even longer.

It can be considered the successor of [NekoVM](http://nekovm.org) since it is also a virtual machine mainly used to develop system/server/desktop applications. However, it has a different approach in terms of core technology, which mean it is not compatible with Neko and cannot be simply named "Neko 3.0".

Here are the common points shared by both HashLink and Neko:

 - A virtual machine with garbage collector
 - Small memory footprint
 - Just-In-Time compilation (actually Ahead-of-Time) 
 - A small core easily extensible with additional C libraries
 - No crash - only catchable exceptions with full stack traces

And here are some points that are unique to HashLink:

 - A strictly-typed register-based bytecode
 - Ability to compile both to bytecode and native C
 - Full interoperability with C (respect `__cdecl`) in both x86 and x86-64

## Beyond Neko

First, let me explain the reasons for writing another virtual machine in replacement of Neko.

Neko was my first complete virtual machine. It was designed before Haxe was even created and was meant to run various programming languages. In the end only two languages ended up targeting Neko: NekoML, the language of the Neko compiler, and of course Haxe.

Back then, the Neko virtual machine was not especially designed to run Haxe and suffered from some limitations, the main one being performance.

Compared to other dynamically typed virtual machines which Neko can be compared to (Python, PHP, Lua, etc.) NekoVM offers some pretty good performance. However, when compared to any state-of-the-art tracing VM such as V8 or statically typed VMs such as .NET CLR or JVM, Neko is very slow.

The main reason for this is that it's dynamically typed. So every "value" in the VM can be either an Int, a Float, a Bool, some Bytes, an Array, a Function or Object, etc. And because this value needs to be recognized at run-time, its type together with its data need to be stored in the memory. 

This causes two kind of problems:

### 1. Boxing

For each Haxe Float (same as `double` in C), NekoVM needs to allocate a block of memory storing both the type of the value and the double value, for example `[ TYPE_FLOAT ; 1.3 ]` (this takes 4 + 8 = 12 bytes). This means every time NekoVM adds two Float together, it must allocate a new "box" to store the result. This is very slow compared to storing the value on the stack and using CPU/FPU registers to perform operations like a C compiler would do. 

NekoVM is optimized for Int calculations. If the Int only needs 31 bits (between -0x3FFFFFFF and +0x3FFFFFFF), then instead of allocating a "box" for it, we will simply shift it by one bit on the left and add 1. For instance, the Int 58 would be stored as a Neko value equal to 117 (58 x 2 + 1). Since all boxes are always aligned on even memory addresses, we can distinguish between an Int value and a boxed value by looking at its lowest address bit.

In HashLink there would be no occurrence of boxing because I'm using strictly typed registers, unless of course you would store basic types into either `Dynamic` (in which case you need to store the type anyway) or `Null<Int or Float or Bool>`. In that case we need to distinguish between `null` and `0`, which requires a "box"

### 2. Polymorphism

Because NekoVM uses "values", it needs to check the type of the values before performing each operation. For instance in the case of the `+` operator, it needs to check if both operands are Int, Float, String, or Objects... every time it performs an addition!

Some JS virtual machines such as V8 have popularized the using of *tracing* which consists at guessing the types to produce an optimized version of the function, then only doing a fallback on polymorphic (slower) version of it if the assumptions it made are wrong. But this is quite complex technology, and Haxe - being strictly typed from the start - does not need this level of complexity.

Because HashLink uses strictly typed registers, the JIT compiler knows already if we are adding two Int, two Float or two Strings together and will only generate the code necessary for this particular operation.

## HashLink Byte Code

Now that we talked about how HashLink differs from NekoVM in terms of its potential for performances, let's have an in-depth look at the byte code used for HashLink.

In case you are new to virtual machines, you might wonder a byte code actually is.

Byte code is similar to some assembler except that it is not related to any specific CPU. It is a "virtual assembler" meant to be run on the "virtual CPU" represented by the virtual machine. Of course, this virtual assembler will be translated to a real assembler by the JIT so it can be run on the CPU. However, when stored on hard drive (in a `.hl` file) it is not CPU-specific and could be translated to any CPU assembler (x86, x86-64, ARM, etc.).

If you want to look at the HL byte code ouput of the Haxe compiler, simply add `-D dump` to your Haxe parameters, for example:

```haxe
// haxe -D dump -hl main.hl -main Main
class Main {
    static function main() {
        trace("Hello World!");
    }
}
```

This will output the following file:

```
// dump/hlcode.txt
hl v1
entry @322
220 strings
	@0 : 
	@1 : hl.types.Class
	@2 : hl.types.BaseType
	@3 : __type__
        ....
40 ints
	@0 : 11
	@1 : 0
	@2 : 10
	@3 : 1
	@4 : 6
        ....
1 floats
	@0 : 0.
38 globals
	@0 : #hl.types.$BaseType
	@1 : #$String
	@2 : #hl.types.Class
        ....
36 natives
	@202 native std@alloc_array (type,i32):array
	@214 native std@sys_utf8_path ():bool
	@30 native std@bytes_blit (bytes,i32,bytes,i32,i32):void
        ...
287 functions
	fun@14(Eh) ():void
	; Main.hx:3 (Main.main)
		r0 void
		r1 bytes
		r2 #String
		r3 i32
		.3     @0 new 2
		.3     @1 string 1,@33
		.3     @2 setfield 2[0],1
		.3     @3 int 3,@0
		.3     @4 setfield 2[1],3
		.3     @5 call 0, Sys.println(2)
		.3     @6 ret 0
        ...
54 objects protos
	hl.types.ArrayBase @4
		extends hl.types.ArrayAccess
		1 fields
		  @0 length i32
		14 methods
		  @0 pushDyn fun@38[3]
		  @1 popDyn fun@39[4]
		  @2 shiftDyn fun@40[5]
		  @3 unshiftDyn fun@41[6]
        ....
```

As you can see, the HL byte code is decomposed into several sections:

 - the Strings table
 - the Ints table
 - the Floats table
 - the Globals table
 - the Natives table
 - the Functions table
 - the Objects table

### The String, Int and Float Tables

These are quite simple, they only store the list of constant Strings, Integers and Floats used in the program. Strings only contain objects, methods and field names. Each constant is only stored once and will then always be referenced by an index into this table in all other sections of the byte code.

Strings in HL are UCS2 (16 bits code points) but are stored as UTF8 into the byte code and then expanded to UCS2 when loading it.

### The Globals Table

The Globals table contains one entry per class, each class storing its own static variables, in addition to some extra global constants such as enum values. there is no name stored for the global, only its type is known in the byte code. The Globals names will become necessary if I want to add support for an interactive debugger later.

### The Natives Table

Natives are a list of C functions that are used inside the program. Some of them are located in the HL run time, some of them are stored in extension libraries. Before performing the JIT, the HL VM will resolve all the natives and check their signature to make sure there is no version mismatch.

Each native function has an index into the "whole-functions-table" (consisting of all natives + all functions), which is prefixed by a `@` in the byte code output.

### The Functions Table

This is where your Haxe code actually is. Each lambda, each member and static method creates an entry into the function table. Each function has a strictly typed signature and an index into the "whole-functions-table". For instance, the following method represents the `String.fromCharCode` method :

```
fun@21(15h) (i32):#String
; D:\Projects\haxe\std/hl/_std/String.hx:158 (String.fromCharCode)
```

 - @21 is the index of the method (15h in hexadecimal)
 - the method takes an `i32` (Haxe Int) as parameter and returns a `#String` (Haxe String object)
 - the debug information stored in the method gives us the file, line it's been declared in and the full method name

### The Objects Table

In this table, we list all objects (Haxe Classes) with their full prototype containing their fields and methods. Each field has a name and a type so we know exactly how much memory to allocate for this particular object storage. Each method references a function index in the functions table as well as an override slot in case the method is overridden.

Because HL knows the complete list of overridden methods, it will compile a static call to the method when there is no override for this method on the current class' sub classes, instead of using prototype fetching and dispatch which would be slower. 

### Deciphering the Byte Code

If we take another look at our `Main.main` method, we can see the following byte code:


	fun@14(Eh) ():void
	; Main.hx:3 (Main.main)
		r0 void
		r1 bytes
		r2 #String
		r3 i32
		.3     @0 new 2
		.3     @1 string 1,@33
		.3     @2 setfield 2[0],1
		.3     @3 int 3,@0
		.3     @4 setfield 2[1],3
		.3     @5 call 0, Sys.println(2)
		.3     @6 ret 0

Before the function code, a list of *registers* is declared to store the results of all operations. Each register has a type. In our case we have 4 registers with the types `void`, `bytes`, `string` and `i32`. 

The `void` register does not take any space but can be used to store/return a `void` value as we will see below.

Following the list of registers, the actual function byte code is displayed. The byte code consists in a list of *opcodes*. Each *opcode* performs a single instruction and eventually stores its result into a register. All integer values in opcodes must be read as register indexes. The opcode notation is similar to the Intel assembler, which means that the leftmost operand is used to store the result of the operation.

Each opcode line is prefixed by the line number in Haxe code (in this case our `Sys.println("Hello World")` is on line 3 of our hx file) and an index in hexadecimal which can be used to follow jumps when there are any.

Let's start deciphering the byte code!

`@0 new 2`

This will create a `new` value for the register 2, which is a `String` object, and store it into this register.

`@1 string 1, @33`

This will store the `bytes` for the string at index 33 of the String table into the register 1, the String 33 is of course `Hello World!` 

`@2 setfield 2[0], 1`

This will store the register 1 (rightmost operand) into the field 0 of the register 2. If you look at the String object definition at the bottom of the hl bytecode, you will find the following definition:

```
String @1
	2 fields
	  @0 bytes bytes
	  @1 length i32
	13 methods
	  @0 toUpperCase fun@1
	  @1 toLowerCase fun@2
	  @2 charAt fun@3
          ....
```

So the field 0 is the String `bytes` field which is used by HL to store the string bytes. In HL, bytes are like a C `char*` , they don't have a specified size or encoding so we need to store the length of the String they represent as well.

This is done in the following opcodes:

```
@3 int 3, @0
@4 setfield 2[1],3
```

We first store the integer at index 0 in our Int table (which is equal 11) into the register 3 then we store the register 3 into the field 1 of the register 2.

At this point, our String object is fully initialized since it doesn't have any more fields to store data.

We will then perform a direct call to the `Sys.println` function by using:

`@5 call 0, Sys.println(2)`

Here we pass our register 2 as parameter and store the result into our `void` register 0 
Once the call is finished, we have reached the end of the function so we can return Void:

`@6 ret 0`

 I think that you get the general idea of how the byte code works. I will detail more *opcodes* that are used by HL virtual machine later on.

### Byte Code Tools

By default, the Haxe HL compiler can be trusted to generate "well formed" byte code, which means that:

- registers are used correctly
- we don't use things like mistaking an `i32` as a String (which would crash the VM)
- casting from/to `Dynamic` correctly inserts the necessary checks.

However, it is possible that some bugs happen here and there. There are several tools that I have developed in order to help me with HashLink byte code debugging:

 - compiling with `-D hl-check` will perform a full byte code check at the end of compilation, which will check that registers are used correctly and that byte code type safety is respected

 - when using `-D dump` you will also get a `dump/hlopt.txt` file that shows the optimizations that are performed on the byte code before saving it to HL or C. Optimizations can be disabled by using `-D hl-no-opt`. This should result in bigger/slower byte code.

 - in order to check if optimizations are not introducing changes in the code evaluation, I have added `-D hl-dump-spec` which outputs a `dump/hlspec.txt` file that consists of a "specification" of what is evaluated for each function. Usually the specification should not change with or without optimization.

 - before writing the HL VM, I wrote a byte code interpreter into the Haxe compiler which can execute your program once it's been compiled by adding `-D interp`. It does a lot of run-time checks to ensure that we respect the byte code safety so it is not intended for production usage, but successfully passed Haxe unit tests.

### To be continued

That's all for now, in the next part we will discuss about HashLink runtime and type system.

*Continue reading the [Part 2](https://haxe.org/blog/hashlink-in-depth-p2/) of this technical presentation of HashLink*
