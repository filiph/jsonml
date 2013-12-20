library hson2dom;

import "dart:html";
import "dart:convert";
import "package:hson/hson.dart";

Node hson2dom(String hson, [Node existingNode]) =>
    hsonList2dom(JSON.decode(hson), existingNode);

Node hsonList2dom(List hsonList, [Node existingNode]) {
  Node container = existingNode != null ? existingNode : new DocumentFragment();
  assert(hsonList[0] == HSON.DOCSTRING);
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
    node = _createElementNode(descriptor);
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

Node _createElementNode(List descriptor) {
  Element element;
  String tagName = descriptor[0];
  if (tagName == "p") {
    element = new ParagraphElement();
  } else if (tagName == "a") {
    assert(descriptor.length >= 2);
    element = new AnchorElement(href: descriptor[1]); // TODO guard out-of-bounds
  } else if (tagName == "img") {
    element = new ImageElement(src: descriptor[1]);
  } else {
    element = new Element.tag(tagName);
  }
  if (descriptor.last is Map) {
    Map attributes = descriptor.last;
    if (attributes.containsKey("c")) {
      element.classes.addAll(attributes["c"]);
    }
    if (attributes.containsKey("i")) {
      element.id = attributes["i"];
    }
    if (attributes.containsKey("t")) {
      element.title = attributes["t"];
    }
  }
  return element;
}

class HSONFormatException implements Exception {
  String message;
  HSONFormatException(this.message);
}