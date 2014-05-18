
import "package:unittest/unittest.dart";
import "package:jsonml/html2jsonml.dart";
import "package:jsonml/jsonml2html5lib.dart";
import "dart:convert" show JSON;

main() {
  group("Encode", () {
    test("basic html", () {
      var list = encodeToJsonML("<p class='blue'><a "
          "href='http://www.example.com/'>This</a> is <strong id=\"very\">very"
          "</strong> interesting.</p>");
      expect(list, JSON.decode("""
        ["p", {"class":"blue"},
          ["a",{"href":"http://www.example.com/"},
            "This"],
          " is ",
          ["strong",{"id":"very"},
            "very"],
          " interesting."]"""));      
    });
    
    test("DocumentFragment", () {
      var list = encodeToJsonML("<h1>Title</h1><p>First paragraph.</p><p>Second paragraph.</p>");
      expect(JSON.encode(list), r"""["",["h1","Title"],["p","First paragraph."],["p","Second paragraph."]]""");
    });
    
    test("HTML + SVG", () {
      var list = encodeToJsonML("""<svg width="100" height="100"><circle cx="50" cy="50" r="40" stroke="green" stroke-width="4" fill="yellow" /></svg>""");
      expect(JSON.encode(list), """["svg",{"width":"100","height":"100"},["circle",{"cx":"50","cy":"50","r":"40","stroke":"green","stroke-width":"4","fill":"yellow"}]]""");
    });
    
    test("throws on unknown tag, undefined with customtags", () {
      expect(() => decodeToHtml5Lib(JSON.decode(r"""["",["NON_EXISTENT_TAG","Title"],["p","First paragraph."],["p","Second paragraph."]]"""), unsafe: true),
          throwsA(new isInstanceOf<JsonMLFormatException>()));
    });
    
    test("CustomTags", () {
      var list = encodeToJsonML(r"""<h1>A normal tag</h1><p>Followed by a paragraph with a <special>custom tag</special>.""");
      bool customTagRan = false;
      var output = decodeToHtml5Lib(list, unsafe: true, 
          customTags: { "special" : (jsonObject) {
            customTagRan = true;
          }
        }
      );
      expect(customTagRan, true);
    });
  });
}