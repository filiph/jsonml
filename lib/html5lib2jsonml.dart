library html5lib2jsonml;

import 'package:html5lib/dom.dart';

/**
 * Takes a [Document], a [Node] or an [Element] and returns the JSON object.  
 */
Object encodeToJsonML(Node node) {
  if (node is Document) {
    // We got the document fragment.
    assert(node.nodes.length == 1);
    return encodeToJsonML(node.nodes[0]);
  }
  
  if (node is Text /* TEXT_NODE */) {
    return node.value;
  } else if (node is Element) {
    List output = new List(1 + (node.attributes.isNotEmpty ? 1 : 0) +
        node.nodes.length);
    output[0] = node.tagName;
    int i = 1;
    if (node.attributes.isNotEmpty) {
      // The following code ensures that the attribute map is <String,String>.
      // Otherwise, we could just assign output[i] = node.attributes;
      Map<String,String> attr = new Map<String,String>();
      node.attributes.forEach((key, value) {
        attr["$key"] = value;
      });
      output[i] = attr;
      i++;
    }
    for (int nodeIndex = 0; nodeIndex < node.nodes.length; i++, nodeIndex++) {
      output[i] = encodeToJsonML(node.nodes[nodeIndex]);
    }
    return output;
  } else {
    throw new Exception("Couldn't encode node: $node");
  }
}