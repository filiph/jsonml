import "dart:html";
import "package:jsonml/jsonml2dom.dart";
import "package:jsonml/html2jsonml.dart";

void main() {
  var destination = querySelector("div#destination");
  var jsonml = encodeToJsonML(
      "<p id='main'><a href='http://www.example.com/'>This</a> is <em><strong>very</strong></em> interesting.</p>");
  destination.append(decodeToDom(jsonml, unsafe: true));
}
