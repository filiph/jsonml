import "dart:html";
import "package:jsonml/jsonml2dom.dart";
import "package:jsonml/html2jsonml.dart";

main() {
  var destination = querySelector("div#destination");
//  var jsonml = encode("<p id='main'><a href='http://www.example.com/'>This</a> is <em><strong>very</strong></em> interesting.</p>");
  var jsonml = encodeToJsonML("""<svg width="100" height="100"> <circle cx="50" cy="50" r="40" stroke="green" stroke-width="4" fill="yellow" /> </svg>""");
  destination.append(decodeToDom(jsonml, unsafe: true));
}