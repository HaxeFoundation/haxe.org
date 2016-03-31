Building Haxe from source
=======

Obtaining the source
-------

The Haxe compiler sources are hosted on GitHub under the [HaxeFoundation account](http://github.com/HaxeFoundation). The [Haxe repository](http://github.com/HaxeFoundation/haxe) has several submodules, so cloning it should be done with the `--recursive` flag like so:

```
git clone --recursive https://github.com/HaxeFoundation/haxe.git
```

Alternatively, source .zip archives or tarballs can be obtained from the [GitHub Haxe release overview](https://github.com/HaxeFoundation/haxe/releases). However, the git submodules are not included, so you will have to manually place the source code of [submodules](https://github.com/HaxeFoundation/haxe/blob/development/.gitmodules) into appropreate sub-folders.

Building on OS X
-------

The dependencies can be easily installed by [Homebrew](http://brew.sh/). In fact, if you only want to use the latest development branch of Haxe, without modifying the source, simply run:

```shell
brew install haxe --HEAD
```

Use `brew reinstall haxe --HEAD` to upgrade in the future.

If you want to start hacking the Haxe compiler, it is better to clone manually and use the Makefile:

1. Install XQuartz (required by OCaml): `brew cask install xquartz`
2. Install OCaml: `brew install ocaml`
3. Install Camlp4: `brew install camlp4`
3. Navigate to where the Haxe sources are and build Haxe using `make`:

```
make
make install
```

Building on Linux
-------

1. Install OCaml: <http://ocaml.org/docs/install.html>
2. Navigate to where the Haxe sources are and build Haxe using `make`:

```
make
make install
```

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

Building on Windows (Cygwin)
-------

1. Install a Cygwin version of OCaml: <http://protz.github.io/ocaml-installer/>

	* To build Haxe you only need to choose `OCaml` and `Cygwin` in the install menu.
	* In the cygwin package selection window, select `mingw64-i686-zlib` in addition to pre-selected packages. This is required to build Haxe.

2. Add the `bin` directory from Cygwin installation (e.g. `C:\cygwin\bin`) to your `PATH` environment variable. This will make Unix commands, like `make` available.

3. Add the `usr\i686-w64-mingw32\sys-root\mingw\bin` directory from the Cygwin installation (e.g. `C:\cygwin\usr\i686-w64-mingw32\sys-root\mingw\bin`) to your `PATH` environment variable. This makes required dynamically linked libraries, like `zlib` available for the compiled `haxe.exe` executable.


Navigate to where the Haxe sources are and build Haxe using:

```
make -f Makefile.win libs haxe haxelib
```

For subsequent compilations it is usually enough to recompile the Haxe sources without its libraries:

```
make -f Makefile.win haxe
```

Building on FreeBSD
-------

1. Become root to install packages: `su -`
2. Install ocaml, gmake, git: `pkg install ocaml ocaml-camlp4 gmake git`
3. As your unprivileged user, check out the project: `cd ~ && git clone --recursive https://github.com/HaxeFoundation/haxe.git`
4. Build your sources: `cd haxe && gmake`
5. Optionally install it to the system: `su -` followed by `cd /home/username/haxe && gmake install`

If you want to update, it's usually enough to just recompile the compiler by updating your checkout using `git pull` followed by issueing the command `gmake haxe`.
