Using the Haxe Compiler
=======

Basic Usage
-------

The Haxe Compiler is typically invoked from command line with several arguments which have to answer two questions:

1. What should be compiled?
2. What should the output be?

To answer the first question, it is usually sufficient to provide a class path via the `-cp path` argument, along with the main class to be compiled via the `-main dot_path` argument. The Haxe Compiler then resolves the main class file and begins compilation.

The second question usually comes down to providing an argument specifying the desired target. Each Haxe target has a dedicated command line switch, such as `-js file_name` for Javascript and `-php directory` for PHP. Depending on the nature of the target, the argument value is either a file name (for `-js`, `-swf` and `neko`) or a directory path.

Common arguments
--------

Input:

* `-cp path`: Adds a class path where `.hx` source files or packages (sub-directories) can be found.
* `-lib library_name`: Adds a [Haxelib](#) library.
* `-main dot_path`: Sets the main class.
* `-D no-compilation`: Only generates the source code without compiling it.
* `-xml output_doc.xml`: Generates a XML documentation file with the javadoc information from all sources.

Output:

* `-js file_name`: Generates Javascript source code in specified file.
* `-as3 directory`: Generates Actionscript 3 source code in specified directory.
* `-flash file_name`: Generates the specified file as Flash .swf.
* `-neko file_name`: Generates Neko binary as specified file.
* `-php directory`: Generates PHP source code in specified directory.
* `-cpp directory`: Generates C++ source code in specified directory and compiles it using native C++ compiler.
* `-cs directory`: Generates C# source code in specified directory.
* `-java directory`: Generates Java source code in specified directory and compiles it using the Java Compiler.
* `-python file_name`: Generates Python source code in the specified file.

Java Target
--------

Input:

* `-java-lib jar_file_path`: Includes a jar file with extra classes for compilation.


