part of html2jsonml;

/**
 * Recursively encodes the [node] (and its child nodes) into a JsonML object.
 */
Object _encodeNode(Node node) {
  if (node is DocumentFragment && node.nodes.length == 1) {
    // Skip encoding DocumentFragment if all it has is one child node.
    node = node.nodes[0];
  }
  
  if (node is Text /* TEXT_NODE */) {
    return node.value;
  } else if (node is Element || node is DocumentFragment) {
    List output = new List(1 + (node.attributes.isNotEmpty ? 1 : 0) +
        node.nodes.length);
    if (node is Element) {
      output[0] = node.tagName;
    } else {
      // DocumentFragment is represented with an empty string 'tag name'.
      // See http://blog.livedoor.jp/aki_mana/archives/6814310.html.
      output[0] = "";
    }
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
      output[i] = _encodeNode(node.nodes[nodeIndex]);
    }
    return output;
  } else {
    throw new Exception("Couldn't encode node: $node");
  }
}