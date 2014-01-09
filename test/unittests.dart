
import "package:unittest/unittest.dart";
import "package:jsonml/html2jsonml.dart";
import "dart:convert" show JSON;

main() {
  group("Encode", () {
    test("basic html", () {
//      var list = encode("<p class='blue'><a href='http://www.example.com/'>This</a> is <strong id=\"very\">very</strong> interesting.</p>");
      var list = encode("<p class='hi'>Hi</p>");
      print("$list");
      print(JSON.encode(list));
    });
  });
}