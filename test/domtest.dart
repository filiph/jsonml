import "dart:html";
import "package:jsonml/jsonml2dom.dart";

main() {
  var destination = querySelector("div#destination");
//  var json = encode("<p id='main'><a href='http://www.example.com/'>This</a> is <em><strong>very</strong></em> interesting.</p>");
  //var jsonml = ["ul", ["li", { "style" : "color:red" }, "First Item" ], ["li", { "title" : "Some hover text.", "style" : "color:green" }, "Second Item" ], ["li", ["span", { "class" : "code-example-third" }, "Third" ], " Item" ] ];
  var jsonml = [null, ["p", {"class": "blue"}, ["a", {"href": "http://www.example.com/"}, "This"],  "is" , ["strong", {"id": "very"}, "very"],  "interesting."]];
  destination.append(jsonml2dom(jsonml));
}