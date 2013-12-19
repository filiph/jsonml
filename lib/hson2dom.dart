library hson2dom;

import "dart:html";
import "dart:convert";

Node hson2dom(String hson, [Node existingNode]) =>
    hsonList2dom(JSON.decode(hson), existingNode);

Node hsonList2dom(List hsonList, [Node existingNode]) {
  Node container = existingNode != null ? existingNode : new DocumentFragment();
  assert(hsonList[0] == "HSON0.1");
  assert(hsonList.length > 1);
  
  for (int i = 1; i < hsonList.length; i++) {
    _decodeHsonNode(hsonList[i], container);
  }
  
  return container;
}

Node _decodeHsonNode(Object hsonObject, Node container) {
  Node node;
  if (hsonObject is String) {
    node = new Text(hsonObject);
  } else if (hsonObject is List) {
    assert(hsonObject[0] is List);
    List descriptor = hsonObject[0];
    String tagName = descriptor[0];
    if (tagName == "p") {
      node = new ParagraphElement();
    } else if (tagName == "a") {
      assert(descriptor.length >= 2);
      node = new AnchorElement(href: descriptor[1]);
    } else {
      node = new Element.tag(tagName);
    }
    if (hsonObject.length > 1) {
      for (int i = 1; i < hsonObject.length; i++) {
        _decodeHsonNode(hsonObject[i], node);
      }
    }
  } else {
    throw new HSONFormatException("Bad HSON");
  }
  container.append(node);
  return node;
}

class HSONFormatException implements Exception {
  String message;
  HSONFormatException(this.message);
}