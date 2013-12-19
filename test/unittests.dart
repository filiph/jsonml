
import "package:unittest/unittest.dart";
import "package:hson/hson.dart";
import "dart:convert" show JSON;

main() {
  group("Encode", () {
    test("basic html", () {
      var json = encode("<p class='blue'><a href='http://www.example.com/'>This</a> is <strong>very</strong> interesting.</p>");
      print(json);
      List contents = JSON.decode(json);
      print(contents);
    });
  });
}