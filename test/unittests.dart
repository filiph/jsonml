
import "package:unittest/unittest.dart";
import "package:jsonml/html2jsonml.dart";
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
  });
}