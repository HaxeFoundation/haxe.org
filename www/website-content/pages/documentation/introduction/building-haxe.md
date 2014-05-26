Building Haxe from source
=======

Obtaining the source
-------

The Haxe compiler sources are hosted on GitHub under the [HaxeFoundation account](http://github.com/HaxeFoundation). The [Haxe repository](http://github.com/HaxeFoundation/haxe) has several submodules, so cloning it should be done with the `--recursive` flag like so:

```
git clone --recursive git://github.com/HaxeFoundation/haxe.git
```

Alternatively, source .zip archives or tarballs can be obtained from the [GitHub Haxe release overview](https://github.com/HaxeFoundation/haxe/releases).

Building on OSX and Linux
-------

Building on Windows (MSVC)
-------

1. Install a MSVC version of OCaml: <http://caml.inria.fr/pub/distrib/>
2. Install any version of Visual C++ (Express): <http://www.visualstudio.com/downloads/download-visual-studio-vs>
3. Install [GNU make for Windows](http://gnuwin32.sourceforge.net/packages/make.htm) and [GNU CoreUtils for Windows] (http://gnuwin32.sourceforge.net/packages/coreutils.htm) and add GnuWin32/bin to your `PATH` environment variable.
4. Install [Flexlink](http://alain.frisch.fr/flexdll.html) and add it to your `PATH` environment variable.
 
After this, open a Visual Studio command prompt or start a normal command prompt and run `vcvarsall.bat` in your `Microsoft Visual Studio X/VC/` directory. The command `cl` should be available afterwards.

Navigate to where the Haxe sources are and build Haxe using:

```
make -f Makefile.win MSVC=1
```

For subsequent compilations it is usually enough to recompile the Haxe sources without its libraries:

```
make -f Makefile.win MSVC=1 haxe
```
