Building Haxe from source
=======

Obtaining the source
-------

The Haxe compiler sources are hosted on GitHub under the [HaxeFoundation account](https://github.com/HaxeFoundation). The [Haxe repository](https://github.com/HaxeFoundation/haxe) has several submodules, so cloning it should be done with the `--recursive` flag like so:

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
2. Install dependencies: `brew install ocaml camlp4 pcre neko`
3. Navigate to where the Haxe sources are and build Haxe using `make`:

```
make
make install
```

Building on Linux
-------

1. Install Neko, which is available in the repositories of many Linux distributions. e.g. On Ubuntu, just `sudo apt-get neko`.
2. Install OCaml (4.02 or above), camlp4, pcre, and zlib. Again, try to find such packages in the Linux repositories.
3. Navigate to where the Haxe sources are and build Haxe using `make`:

```
make
make install
```

Building on Windows (mingw)
-------

### Installation

  - Download 32-bit installer from the fdopen's fork: <https://fdopen.github.io/opam-repository-mingw/installation/>
  - Install it, in Cygwin package selection also check `mingw64-i686-zlib` and `mingw64-i686-pcre` (used by Haxe).
    You might need to switch "View" in top-right corner to "Not Installed" to see it in the list.
  - Run OCaml32 terminal from the desktop shortcut, from it:
  
    - Install camlp4 with `opam install camlp4`
    - Install merlin with `opam install merlin`

### Running from cmd/powershell

  - Add these to your PATH (actual paths may differ depending on your install path and username):
  
    - cygwin tools: `C:\OCaml32\bin`
    - runtime dlls: `C:\OCaml32\usr\i686-w64-mingw32\sys-root\mingw\bin`
    - ocaml bin: `C:\OCaml32\home\nadako\.opam\4.02.3+mingw32c\bin`
    - flexlink bin: `C:\OCaml32\usr\local\bin`
    
  - Add new env variables (actual paths may differ depending on your install path and username):
  
    - `OCAML_TOPLEVEL_PATH=C:\OCaml32\home\nadako\.opam\4.02.3+mingw32c\lib\toplevel`
    - `OCAMLLIB=C:\OCaml32\home\nadako\.opam\4.02.3+mingw32c\lib\ocaml`
    
  - I couldn't get `opam` itself running through cmd/powershell because it needs some more environment that's inited in `.bashrc`, but I think installing opam packages from within Cygwin terminal is acceptable.

### Testing

  - Haxe should compile: `make ADD_REVISION=1 -f Makefile.win`
  - VSCode OCaml extension features should work: <https://marketplace.visualstudio.com/items?itemName=hackwaly.ocaml>

### Troubleshoot

 - If you have issues compiling in cmd.exe (worked fine in ocaml32) and get `Interrupt/Exception caught (code = 0xc00000fd, addr = 0x4227d3`, this helps: <http://hdrlab.org.nz/articles/windows-development/make-interrupt-exception-caught-code-0xc00000fd-addr-0x4217b/>
TL;DR: put the environment variables at the start of your PATH, not at the end.

Building on FreeBSD
-------

1. Become root to install packages: `su -`
2. Install the build dependencies: `pkg install ocaml ocaml-camlp4 ocaml-findlib pcre gmake git neko`
3. As your unprivileged user, check out the project: `cd ~ && git clone --recursive https://github.com/HaxeFoundation/haxe.git`
4. Build your sources: `cd haxe && gmake "CFLAGS=-I /usr/local/include/"`
5. Optionally install it to the system: `su -` followed by `cd /home/username/haxe && gmake install`

If you want to update, it's usually enough to just recompile the compiler by updating your checkout using `git pull` followed by issueing the command `gmake haxe`.
