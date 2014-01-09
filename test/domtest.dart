import "dart:html";
import "package:jsonml/jsonml2dom.dart";
import "package:jsonml/html2jsonml.dart";

main() {
  var destination = querySelector("div#destination");
  var jsonml = encode("<p id='main'><a href='http://www.example.com/'>This</a> is <em><strong>very</strong></em> interesting.</p>");
  destination.append(jsonml2dom(jsonml));
}