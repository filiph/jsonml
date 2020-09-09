library html5lib2jsonml;

import 'package:html/dom.dart';

/// Takes a [Document], a [Node] or an [Element] and returns the JSON object.
Object encodeToJsonML(Node node) {
  if (node is Document || node is DocumentFragment) {
    if (node.nodes.length > 1) {
      // We got a document fragment with multiple children.
      var nodes = List<Object>(node.nodes.length + 1);
      nodes[0] = "";
      for (var i = 1; i < node.nodes.length + 1; i++) {
        nodes[i] = encodeToJsonML(node.nodes[i - 1]);
      }
      return nodes;
    } else {
      // We got a document fragment with just one child.
      return encodeToJsonML(node.nodes[0]);
    }
  }

  if (node is Text /* TEXT_NODE */) {
    return node.data;
  } else if (node is Element) {
    final output = List<Object>(
        1 + (node.attributes.isNotEmpty ? 1 : 0) + node.nodes.length);
    output[0] = node.localName;
    var i = 1;
    if (node.attributes.isNotEmpty) {
      // The following code ensures that the attribute map is <String,String>.
      // Otherwise, we could just assign output[i] = node.attributes;
      var attr = <String, String>{};
      for (final key in node.attributes.keys) {
        attr["$key"] = node.attributes[key];
      }
      output[i] = attr;
      i++;
    }
    for (var nodeIndex = 0; nodeIndex < node.nodes.length; i++, nodeIndex++) {
      output[i] = encodeToJsonML(node.nodes[nodeIndex]);
    }
    return output;
  } else {
    throw Exception("Couldn't encode node: $node");
  }
}
