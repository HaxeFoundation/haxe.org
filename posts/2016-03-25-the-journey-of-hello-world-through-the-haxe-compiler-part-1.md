title: The Journey of Hello World through the Haxe Compiler
author: simn
description: Part 1 of an introduction to what the Haxe compiler does with your code.
background: macro-compilation-role.png
published: true
tags: tech
disqusID: 5
---

One nice aspect of Haxe is that it allows you to look behind the scenes through its macro system. It is not unusual to be introduced to some compiler internals this way, and one often wonders what lies beyond. In the terms of game design, Haxe is easy to learn and hard to master: You can get going very quickly but the compiler still holds pleasant surprises even for seasoned developers. In this article we follow a Hello World program on its journey through the compiler.

A compiler is a complex system. Looking at it in its entirety can be daunting and overwhelming. Yet, like most complex systems, its complexity arises from a combination of smaller parts. Exploring these parts individually then becomes much easier and suddenly the combined system doesn't seem that terrifying anymore.

Granted, most people are not compiler developers and don't plan to become compiler developers either. However, even then, having a better understanding of the tool you are using can be beneficial:

* Error messages make more sense.
* Knowing the stages of compilation reduces the search space when hunting for bugs.
* It's easier to write optimized (and optimizing) code.
* It's very satisfying to understand what's going on.

## The journey of Hello World

Our subject for this is the standard Haxe Hello World program:

```haxe
class Main {
	static function main() {
		trace("Hello World");
	}
}
```

What does it take for this piece of code to be output to one of Haxe's target languages? Let's assume compilation to JavaScript; then we have something like this:

1. Haxe code
2. Compile
3. ????
4. JavaScript code

Contrary to popular belief, step 3 of this is not magic. It is, in fact, very un-magical and deterministic. But enough buildup, here's the outline of what happens if you ask Haxe to compile this Hello World program:

1. Read in the source file.
2. Turn the words and characters into tokens (*lexing*).
3. Walk these tokens and build an abstract syntax tree (AST, *parsing*).
4. Traverse the AST, considering type information (*typing*).
5. Optimize the result.
6. Translate the optimized result to the target representation (*generating*).

Reading the source file is boring to talk about, so let's start with step 2 and look at the lexing!

## Lexing: "Words" that make sense to a computer

In English we have words that form a sentence when combined. We also have punctuation, like this comma just now and the full stop that's ahead. There's usually no reason to think about this because we do it all automatically. However, when we want a computer to make sense of it things have to be formalized in some way.

First, we need a term that subsumes words and punctuation: We call these *tokens*. Let's be a bit geeky and define a Haxe enum for some English tokens:

```haxe
enum EnglishToken {
    Word(s:String);
    Dot;
    Comma;
    QuestionMark;
}
```

Now, who can make sense of what the following Array translates to?

```haxe
[Word("Hello"), Comma, Word("how"), Word("are"), Word("you"), QuestionMark]
```

Indeed, it would spell out "Hello, how are you?" when interpreted. It looks like this is all that we need in order to form basic sentences. Mapping this concept to programming languages is very straightforward. The main difference is that programming languages typically know more punctuation than natural languages, but that only means that we have to define a few more tokens.

Going back to our Hello World program, this is what we get after lexing:

```
Kwd(KwdClass)
Const(CIdent(Main))
BrOpen
Kwd(KwdStatic)
Kwd(KwdFunction)
Const(CIdent(main))
POpen
PClose
BrOpen
Const(CIdent(trace))
POpen
Const(CString(Hello World))
PClose
Semicolon
BrClose
BrClose
```

That's really all there is to it. If you go through this list while looking at the Hello World source code, the connection should be obvious. The names might be a bit cryptic but that's just because programmers are lazy. Feel free to check out the [official Haxe token type](https://github.com/HaxeFoundation/haxe/blob/development/src/syntax/ast.ml#L276). Yes, that's OCaml, but you can just pretend that it's a Haxe enum.

By the way, lexing is sometimes called *tokenization*.

## Parsing: Understanding the meaning

At the moment, all we have is a list of tokens. We don't know yet what they "mean" and if they make sense at all. It's easy to to see that there are many ways to construct nonsense this way. Did you notice the duplicate "to" in the previous sentence? Grammatically, that's nonsense, but at least it's nonsense constructed using valid parts of the language.

Making sense of a list of tokens is the job of a *parser*. It defines a *grammar* and interprets tokens according to that grammar. We can again use English as an initial, simplified example (this notation is called [Backus-Naur Form](https://en.wikipedia.org/wiki/Backus%E2%80%93Naur_Form), but don't worry about that):

```
<sentence>    ::= <subject> <predicate> <object> <sentenceEnd>
<sentenceEnd> ::= "." | "!"
```

Assuming that everyone has an understanding what subject, predicate and object are, we can confirm that a sentence like "I like Haxe!" conforms to this grammar. Likewise, we can see that "I Haxe Haxe" does not conform to the grammar because "Haxe" is not a predicate (yet) and also because there's a missing "." or "!" at the end.

Parsers for programming languages are quite similar but there's one more thing we have to consider: We not only want to check if a list of tokens matches the grammar defined by the parser, we also want to define what should happen if it does. For our purpose, this means constructing the *abstract syntax tree* (AST).

Let us assume that Haxe only had classes and enums. Then we could define a Haxe enum representing this like so:

```haxe
enum TypeDef {
    EClass(name:String);
    EEnum(name:String);
}
```

What determines if we get a class or an enum? Well, it's whether we say `class` or `enum` in our type definition, so we could define the grammar accordingly:

```
<typeDefinition>  ::= <classDefinition> | <enumDefinition>
<classDefinition> ::= "Kwd(class)" "Const(CIdent(name))"   -> EClass(name)
<enumDefinition>  ::= "Kwd(enum)"  "Const(CIdent(name))"   -> EEnum(name)
```

This is simplified, of course, but the real Haxe parser follows the same principle. In the end, we get our abstract syntax tree (or a parser error if there was something wrong). Here's the AST of our Hello World program in all its ASCII-art glory:

```
{
  pack => [],
  decls => [{
    decl => EClass({
      name => Main,
      flags => [],
      data => [{
        name => main,
        access => [AStatic],
        kind => FFun({
          args => [],
          expr => { expr => EBlock([
            { expr => ECall(
              { expr => EConst(CIdent(trace)) },
              [{ expr => EConst(CString(Hello World))}]
            )}]
          )},
          ret => null
        })
      }]
    })
  }]
}
```

To be frank, tree structures like this are not very easy to read for humans. However, there's nothing inherently complex about them.

## Half-time conclusion

We have seen that the text in an input file is lexed and parsed. We started with the string content of the file and arrived at an abstract syntax tree representation. In part 2 we will see what the compiler does with this information and how it ultimately leads to JavaScript code being output.

For the curious, the following files of the Haxe implementation are related to this:

* [ast.ml](https://github.com/HaxeFoundation/haxe/blob/development/src/syntax/ast.ml): Definition of data structures such as `token` and `expr` and `definition`.
* [lexer.mll](https://github.com/HaxeFoundation/haxe/blob/development/src/syntax/lexer.mll): The lexer implementation. Most of it involves dealing with various literals (strings, comments, regular expressions).
* [parser.ml](https://github.com/HaxeFoundation/haxe/blob/development/src/syntax/parser.ml): Everything related to the parser, including conditional compilation.
