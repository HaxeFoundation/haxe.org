import haxe.io.Path;
import haxe.macro.Context;
import haxe.macro.Expr.ComplexType;
import haxe.macro.Expr.Field;
import sys.FileSystem;
import sys.io.File;

using StringTools;

class ViewBuilder {

	macro public static function build () : Array<Field> {
		for (view in FileSystem.readDirectory(Config.viewsPath)) {
			buildView(view);
		}

		return Context.getBuildFields();
	}

	static var BOOL_TYPE : ComplexType = TPath({
		name: "Bool",
		pack: [],
		params: null,
		sub: null
	});

	static var STRING_TYPE : ComplexType = TPath({
		name: "String",
		pack: [],
		params: null,
		sub: null
	});

	static var ARRAY_DYNAMIC_TYPE : ComplexType = TPath({
		name: "Array",
		pack: [],
		params: [TPType(TPath({
			name: "Dynamic",
			pack: [],
			params: null,
			sub: null
		}))],
		sub: null
	});

	static function makeVar (name:String, type:ComplexType) : Field {
		return {
			access: null,
			doc: null,
			kind: FVar(type, null),
			meta: null,
			name: name,
			pos: Context.currentPos()
		};
	}

	static function getFields (content:String) : Array<Field> {
		var argumentsRegex = ~/::(.*?)::/g;
		var arguments = new Map<String, Array<String>>();
		var bools = [];

		argumentsRegex.map(content, function (f:EReg):String {
			var v = f.matched(1);
			if (!v.startsWith("if (") && v != "end") {
				var tmp = v.split(".");
				if (!arguments.exists(tmp[0])) {
					arguments.set(tmp[0], []);
				}
				if (tmp[1] != null) {
					var a = arguments.get(tmp[0]);
					if (a.indexOf(tmp[1]) == -1) {
						a.push(tmp[1]);
					}
				}
			}
			else if (v.startsWith("if (") && v.indexOf("=") == -1) {
				var ifl = "if (".length;
				var argument = "bool " + v.substr(ifl, v.length - ifl - 1);
				if (!arguments.exists(argument)) {
					arguments.set(argument, []);
				}

				bools.push(argument);
			}
			return f.matched(0);
		});

		var fields:Array<Field> = [];

		function makeArgField (argument:String):Field {
			if (argument.startsWith("foreach ")) {
				return makeVar(argument.substr("foreach ".length), ARRAY_DYNAMIC_TYPE);
			}
			else if (argument.startsWith("bool ")) {
				return makeVar(argument.substr("bool ".length), BOOL_TYPE);
			}
			else {
				return makeVar(argument, STRING_TYPE);
			}
		}

		function addField (field:Field) {
			var duplicate = false;

			for (f in fields) {
				if (f.name == field.name) {
					duplicate = true;
					break;
				}
			}

			if (!duplicate) {
				fields.push(field);
			}
		}

		for (argument in bools.concat([for (k in arguments.keys()) k])) { // give priority to bool
			var subs = arguments.get(argument);

			if (subs.length == 0) {
				addField(makeArgField(argument));
			}
			else {
				var subfields = subs.map(function (f:String):Field return makeArgField(f));
				addField(makeVar(argument, TAnonymous(subfields)));
			}
		}

		return fields;
	}

	static function buildView (view:String) {
		if (Path.extension(view) != "html") {
			return;
		}

		var name = Path.withoutExtension(view);
		var content = File.getContent(Path.join([Config.viewsPath, view]));
		var fields = getFields(content);

		var execute:Field = {
			access: [APublic, AStatic],
			doc: null,
			kind: FFun({
				args: [{
					meta: null,
					name: "variables",
					opt: false,
					type: TAnonymous(fields),
					value: null
				}],
				expr: macro { return new haxe.Template($v{content}).execute(variables); },
				params: null,
				ret: STRING_TYPE,
			}),
			meta: null,
			name: "execute",
			pos: Context.currentPos()
		}

		Context.defineType({
			fields: [execute],
			isExtern: false,
			kind: TDClass(null, [], false),
			meta: null,
			name: name,
			pack: [Config.viewsPath],
			params: null,
			pos: Context.currentPos()
		});
	}

}
