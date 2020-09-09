import "dart:html";
import "package:jsonml/jsonml2dom.dart";
import "package:jsonml/html2jsonml.dart";

void main() {
  var destination = querySelector("div#destination");
  var jsonml = encodeToJsonML(
      """<svg width="100" height="100"> <circle cx="50" cy="50" r="40" stroke="green" stroke-width="4" fill="yellow" /> </svg>""");
  destination.append(decodeToDom(jsonml, unsafe: true));
}
