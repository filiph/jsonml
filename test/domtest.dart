import "dart:html";
import "package:hson/hson.dart";
import "package:hson/hson2dom.dart";

main() {
  var destination = querySelector("div#destination");
  var json = encode("<p class='blue'><a href='http://www.example.com/'>This</a> is <em><strong>very</strong></em> interesting.</p>");
  print(json);
  hson2dom(json, destination);
}