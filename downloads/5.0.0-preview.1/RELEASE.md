
Dear Community,

On behalf of the Haxe Foundation, we are proud to announce that Haxe
5.0.0-preview.1 is now officially released! Check out the changelog below for more information.

As a preview release, it should not be considered stable and does, in fact, have
some known issues. However, we appreciate anyone testing this version as it is
going to ultimately help with the real Haxe 5 release. If you have any suggestions or run into any problems, feel free to [open an issue on GitHub](https://github.com/HaxeFoundation/haxe/issues).

Thanks to [everyone involved](https://github.com/HaxeFoundation/haxe/graphs/contributors?from=4%2F5%2F2023&to=7%2F4%2F2025)!

---

Note: if you are getting this error:
> `Uncaught exception -  is not a valid version string`

It means that you are using an older `haxelib` version that is not compatible with haxe `5.0.0-preview.1`.

You can either update it:
```
haxelib install haxelib
```

Or remove it (and use the version shipped with Haxe):
```
haxelib remove haxelib
```

If that doesn't work, try running the command with `--global`.
