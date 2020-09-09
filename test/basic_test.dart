import "dart:convert" show json;

import "package:html/dom.dart" as html5lib;
import "package:jsonml/html2jsonml.dart";
import "package:jsonml/jsonml2html5lib.dart";
import "package:test/test.dart";

void main() {
  group("Encode", () {
    test("basic html", () {
      var list = encodeToJsonML("<p class='blue'><a "
          "href='http://www.example.com/'>This</a> is <strong id=\"very\">very"
          "</strong> interesting.</p>");
      expect(list, json.decode("""
        ["p", {"class":"blue"},
          ["a",{"href":"http://www.example.com/"},
            "This"],
          " is ",
          ["strong",{"id":"very"},
            "very"],
          " interesting."]"""));
    });

    test("DocumentFragment", () {
      var list = encodeToJsonML(
          "<h1>Title</h1><p>First paragraph.</p><p>Second paragraph.</p>");
      expect(json.encode(list),
          r"""["",["h1","Title"],["p","First paragraph."],["p","Second paragraph."]]""");
    });

    test("HTML + SVG", () {
      var list = encodeToJsonML(
          """<svg width="100" height="100"><circle cx="50" cy="50" r="40" stroke="green" stroke-width="4" fill="yellow" /></svg>""");
      expect(json.encode(list),
          """["svg",{"width":"100","height":"100"},["circle",{"cx":"50","cy":"50","r":"40","stroke":"green","stroke-width":"4","fill":"yellow"}]]""");
    });

    test("throws on unknown tag, undefined with customtags", () {
      expect(
          () => decodeToHtml5Lib(
              json.decode(
                  r"""["",["NON_EXISTENT_TAG","Title"],["p","First paragraph."],["p","Second paragraph."]]"""),
              unsafe: true),
          throwsA(const TypeMatcher<JsonMLFormatException>()));
    });

    test("CustomTags", () {
      var list = encodeToJsonML(
          r"""<h1>A normal tag</h1><p>Followed by a paragraph with a <special>custom tag</special>.""");
      var customTagRan = false;
      var _ = decodeToHtml5Lib(list, unsafe: true, customTags: {
        "special": (jsonObject) {
          customTagRan = true;
          return html5lib.Element.tag("strong");
        }
      });
      expect(customTagRan, true);
    });
  });
}
