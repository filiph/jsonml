
import "package:unittest/unittest.dart";
import "package:jsonml/html2jsonml.dart";

main() {
  group("Encode", () {
    test("basic html", () {
      var list = encode("<p class='blue'><a href='http://www.example.com/'>This</a> is <strong id=\"very\">very</strong> interesting.</p>");
      print("$list");
    });
  });
}