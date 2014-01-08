library html2jsonml;

import 'package:html5lib/parser.dart' show parseFragment;
import 'package:html5lib/dom.dart';

/**
 * Default encoder.
 */
List encode(String html) {
  DocumentFragment tree = parseFragment(html);
  return _encodeNode(tree);
}

Object _encodeNode(Node node) {
  if (node is Text /* TEXT_NODE */) {
    return node.value;
  } else if (node is Element || node is Document) {
    List output = new List(1 + (node.attributes.isNotEmpty ? 1 : 0) +
        node.nodes.length);
    
    output[0] = node.tagName;
    int i = 1;
    if (node.attributes.isNotEmpty) {
      output[i] = node.attributes;
      i++;
    }
    for (int nodeIndex = 0; nodeIndex < node.nodes.length; i++, nodeIndex++) {
      output[i] = _encodeNode(node.nodes[nodeIndex]);
    }
    return output;
  } else {
    throw new Exception("Couldn't encode node: $node");
  }
}