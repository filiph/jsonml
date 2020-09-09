library jsonml2html5lib;

import 'dart:collection';

import 'package:html/dom.dart' as html5lib;
import 'src/exception.dart';
export 'src/exception.dart';
import 'src/constants.dart';

/// Almost exact copy of jsonml2dom, but with html5lib 'virtual' DOM elements.
///
/// Takes an JsonML object (not [String] JSON, but the decoded object, most
/// often a [List]) and returns the html5lib [Node] it specifies. This works
/// recursively, so a whole virtual page structure can be created this way.
///
/// TODO: Create DomBase library with Node, Text, Element abstract classes. Share
/// code between json2html5lib and json2dom.
html5lib.Node decodeToHtml5Lib(Object jsonml,
    {bool unsafe = false, Map<String, CustomTagHandler> customTags}) {
  return _createNode(jsonml, unsafe: unsafe, customTags: customTags);
}

/// A function that takes a JSONML object and converts it to a [html5lib.Node].
typedef CustomTagHandler = html5lib.Node Function(Object jsonMLObject);

html5lib.Node _createNode(Object jsonMLObject,
    {bool unsafe = false,
    Map<String, CustomTagHandler> customTags,
    bool svg = false,
    bool allowUnknownTags = false}) {
  if (unsafe == false) {
    throw UnimplementedError("Safe operation (no script tags, etc.) is "
        "not supported yet. Currently, you _must_ specify `unsafe: true`. "
        "In the future, the default operation will be in safe mode "
        "(unsafe: false), which will strip all tags and attributes that "
        "could be exploited by malicious users. Only use unsafe mode for "
        "input which you are absolutely certain is safe (= no user input.");
  }
  html5lib.Node node;
  if (jsonMLObject is String) {
    node = html5lib.Text(jsonMLObject);
  } else if (jsonMLObject is List) {
    assert(jsonMLObject[0] is String);
    var tagName = jsonMLObject[0] as String;
    html5lib.Element element;
    html5lib.DocumentFragment documentFragment;
    if (tagName == "") {
      documentFragment = html5lib.DocumentFragment();
    } else {
      if (customTags != null && customTags.containsKey(tagName)) {
        element = customTags[tagName](jsonMLObject) as html5lib.Element;
      } else if (!allowUnknownTags &&
          !VALID_TAGS.contains(tagName.toLowerCase())) {
        throw JsonMLFormatException("Tag '$tagName' not a valid HTML5 tag "
            "nor is it defined in customTags.");
      } else {
        element = html5lib.Element.tag(tagName);
      }
    }
    if (jsonMLObject.length > 1) {
      var i = 1;
      if (jsonMLObject[1] is Map) {
        if (element != null) {
          element.attributes =
              jsonMLObject[1] as LinkedHashMap<dynamic, String>;
        } else {
          assert(documentFragment != null);
          throw JsonMLFormatException("DocumentFragment cannot have "
              "attributes. Value of currently encoded JsonML object: "
              "'$jsonMLObject'");
        }
        i++;
      }
      for (; i < jsonMLObject.length; i++) {
        var newNode = _createNode(jsonMLObject[i],
            unsafe: unsafe, svg: svg, customTags: customTags);
        if (newNode == null) {
          continue; // Some custom tag handlers can choose not to output
          // elements.
        }
        if (element != null) {
          element.append(newNode);
        } else {
          documentFragment.append(newNode);
        }
      }
    }
    if (element != null) {
      node = element;
    } else {
      assert(documentFragment != null);
      node = documentFragment;
    }
  } else {
    throw JsonMLFormatException("Unexpected JsonML object. Objects in "
        "JsonML can be either Strings, Lists, or Maps (and Maps can be only "
        "on second positions in Lists, and can be only <String,String>). "
        "The faulty object is of runtime type ${jsonMLObject.runtimeType} "
        "and its value is '$jsonMLObject'.");
  }
  return node;
}
