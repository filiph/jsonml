
import "package:unittest/unittest.dart";
import "package:jsonml/html2jsonml.dart";
import "dart:convert" show JSON;

main() {
  group("Encode", () {
    test("basic html", () {
      var list = encode("<p class='blue'><a href='http://www.example.com/'>This</a> is <strong id=\"very\">very</strong> interesting.</p>");
      print("$list");
      print(JSON.encode(list));
    });
    
    test("HTML + SVG", () {
//      var list = encode("<p class='blue'><a href='http://www.example.com/'>This</a> is <strong id=\"very\">very</strong> interesting.</p>");
      var list = encode("""<svg width="100" height="100"> <circle cx="50" cy="50" r="40" stroke="green" stroke-width="4" fill="yellow" /> </svg>""");
      print("$list");
      print(JSON.encode(list));
    });
  });
}