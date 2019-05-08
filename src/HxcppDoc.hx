import generators.Manual;
import generators.Manual.Section;

class HxcppDoc {

	public static function patchSections () : Array<Section> {
		var sections = Manual.getDefaultSections();

		// Locate Target Details/C++
		var cppSection = findCppSection(sections);

		var newDoc = [
			"../../../../hxcpp/docs/CompileCache" => "The Hxcpp Cache",
			"../../../../hxcpp/docs/ThreadsAndStacks" => "Threads And Stacks",
			"../../../../hxcpp/docs/build_xml/Defines" => "Defines",
			"../../../../hxcpp/docs/build_xml/README" => "Build.xml",
			"../../../../hxcpp/docs/build_xml/TopLevel" => "Build.xml - Structure of the top-level",
			"../../../../hxcpp/docs/build_xml/Files" => "Build.xml - Files",
			"../../../../hxcpp/docs/build_xml/Tags" => "Build.xml - Tags",
			"../../../../hxcpp/docs/build_xml/Targets" => "Build.xml - Targets",
			"../../../../hxcpp/docs/build_xml/Compiler" => "Build.xml - Compiler",
			"../../../../hxcpp/docs/build_xml/Linker" => "Build.xml - Linker",
			"../../../../hxcpp/docs/build_xml/Stripper" => "Build.xml - Stripper",
			"../../../../hxcpp/docs/build_xml/HaxeTarget" => "The Haxe Target",
			"../../../../hxcpp/docs/build_xml/XmlInjection" => "Xml Injection",
		];

		for (path in newDoc.keys()) {
			var label = newDoc[path];

			cppSection.sub.push({
				label: path,
				id : path,
				sub: [],
				flags: { folded: false },
				state: 1, //TODO actually find out what this is
				title: label,
				source: null,
				index: 0
			});
		}

		return sections;
	}

	static function findCppSection (inSections:Array<Section>) : Section {
		for (section in inSections) {
			if (section.label == "target-cpp") {
				return section;
			} else {
				var sub = findCppSection(section.sub);
				if (sub != null) {
					return sub;
				}
			}
		}

		return null;
	}

}
