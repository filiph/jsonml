library jsonml2dom;

import "dart:html";
import "dart:svg";
import "dart:convert";

Node jsonmlString2dom(String jsonml) => jsonml2dom(JSON.decode(jsonml));

Node jsonml2dom(List jsonmlList) {
  return _createNode(jsonmlList);
}

Node _createNode(Object jsonMLObject, {bool svg: false}) {
  Node node;
  if (jsonMLObject is String) {
    node = new Text(jsonMLObject);
  } else if (jsonMLObject is List) {
    assert(jsonMLObject[0] is String || jsonMLObject[0] == null);
    String tagName = jsonMLObject[0];
    Element element;
    DocumentFragment documentFragment;
    if (tagName == "svg" || svg) {
      // SVG elements are different, need another constructor.
      element = new SvgElement.tag(tagName);
      svg = true;
    } else if (tagName == null) {
      documentFragment = document.createDocumentFragment();
    } else {
      element = new Element.tag(tagName);
    }
    if (jsonMLObject.length > 1) {
      int i = 1;
      if (jsonMLObject[1] is Map) {
        if (element != null) {
          element.attributes = jsonMLObject[1];
        }
        i++;
      }
      for (; i < jsonMLObject.length; i++) {
        if (element != null) {
          element.append(_createNode(jsonMLObject[i], svg: svg));
        } else if (documentFragment != null) {
          documentFragment.append(_createNode(jsonMLObject[i], svg: svg));
        }
      }
    }
    if (element != null) {
      node = element;
    } else if (documentFragment != null) {
      node = documentFragment;
    }
  } else {
    throw new JsonMLFormatException("Bad HSON");
  }
  return node;
}

class JsonMLFormatException implements Exception {
  String message;
  JsonMLFormatException(this.message);
}