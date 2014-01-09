
import "package:unittest/unittest.dart";
import "package:jsonml/html2jsonml.dart";
import "dart:convert" show JSON;

main() {
  group("Encode", () {
    test("basic html", () {
      var list = encode("<p class='blue'><a href='http://www.example.com/'>This</a> is <strong id=\"very\">very</strong> interesting.</p>");
      expect(JSON.encode(list), """["p",{"class":"blue"},["a",{"href":"http://www.example.com/"},"This"]," is ",["strong",{"id":"very"},"very"]," interesting."]""");
    });
    
    test("DocumentFragment", () {
      var list = encode("<h1>Title</h1><p>First paragraph.</p><p>Second paragraph.</p>");
      expect(JSON.encode(list), r"""["",["h1","Title"],["p","First paragraph."],["p","Second paragraph."]]""");
    });
    
    test("HTML + SVG", () {
      var list = encode("""<svg width="100" height="100"><circle cx="50" cy="50" r="40" stroke="green" stroke-width="4" fill="yellow" /></svg>""");
      expect(JSON.encode(list), """["svg",{"width":"100","height":"100"},["circle",{"cx":"50","cy":"50","r":"40","stroke":"green","stroke-width":"4","fill":"yellow"}]]""");
    });
  });
}