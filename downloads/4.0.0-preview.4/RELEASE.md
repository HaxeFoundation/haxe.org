Dear Community,

On behalf of the Haxe Foundation, we are proud to announce the official release of the Haxe 4.0.0-preview.4! It is available along with the changelog at https://haxe.org/download.

As a preview release, it should not be considered stable. However, we appreciate anyone testing this version which will help us with the real Haxe 4 release. Please report any issues here:

https://github.com/HaxeFoundation/haxe/issues.

Thank you very much for your help!

## Improved compiler display services

Our focus for this release has been compiler display services. We implemented a new, JSON-RPC-based protocol which is utilized by the [vshaxe Visual Studio Code Extension](https://marketplace.visualstudio.com/items?itemName=nadako.vshaxe) to provide a variety of new features:

* Support for auto-import
* Completion on `override |`
* Completion for structure field names
* Support for auto-generating structure declarations, functions, switches and more
* Context-aware, sorted toplevel completion
* Reference finding which explores modules that are not necessarily part of the compilation

## Improved enum abstracts

Enum abstracts now get the treatment they deserve with a proper `enum abstract` syntax. Furthermore, values can now be omitted if the enum abstract is defined over Int or String:

```haxe
enum abstract MyEnum(String) {
	var MyValue; // implicit = "MyValue"
}

enum abstract MyOtherEnum(Int) {
	var MyValue0; // implicit = 0
	var MyValue1; // implicit = 1
	var MyValue5 = 5;
	var MyValue6; // implicit = 6
}
```

## Various syntactic improvements

* `extern` is now recognized as a field-level modifier and can be used instead of `@:extern`
* Metadata names can now use dots, e.g. `@:haxe.json` becomes a metadata entry named "haxe.json"
* Structure fields now consistently allow `var ?x` and `final ?x`, meaning the same as `@:optional var x`
* `Type1 & Type2` is now a recognized syntax for intersection types. For the time being, it is only supported to merge structures (replacing the `{ >Type1, >Type2, }` syntax) and for type parameter constraints (replacing `T:(Type1, Type2)` which has been removed from the language).

## Lots of bugfixes

See the changelog for more!