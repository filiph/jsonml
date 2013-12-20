library hson;

import 'package:html5lib/parser.dart' show parseFragment;
import 'package:html5lib/dom.dart';

/**
 * Default encoder.
 */
String encode(String html) => _defaultInstance.encode(html);

/// Default instance.
HSON _defaultInstance = new HSON();

class HSON {
  HSON();

  static const DOCSTRING = "HSON0.1";
  
  _IndentedStringBuffer out = new _IndentedStringBuffer();
  
  String encode(String html) {
    DocumentFragment tree = parseFragment(html);
    out.clear();
    out.writeln("[");
    out.indent();  
    out.writeln("\"$DOCSTRING\",");
    
    // The containing node is always a DOCUMENT_FRAGMENT_NODE. Start with its
    // child nodes from the get go.
    int length = tree.nodes.length;
    for (int i = 0; i < length; i++) {
      _encodeNode(tree.nodes[i], last: i == length - 1);
    }
    out.deindent();
    out.writeln("]");
    String result = out.toString();
    out.clear();  // Make sure we don't retain the StringBuffer in memory.
    return result;
  }
  
  void _encodeNode(Node node, {bool last: false}) {
    if (node is Text /* TEXT_NODE */) {
      out.writeln("\"${node.value}\"${last ? '' : ','}"); // TODO: guard against "
    } else if (node is Element || node is Document) {
      out.writeln("[");
      out.indent();
  
      if (node is DocumentFragment) {
        out.writeln("[\"FRAGMENT\"]${node.nodes.isEmpty ? '' : ','}");
      } else if (node is Element) {
        _outputElementDescriptor(node);
      }
      int length = node.nodes.length;
      for (int i = 0; i < length; i++) {
        _encodeNode(node.nodes[i], last: i == length - 1);
      }
      out.deindent();
      out.writeln("]${last ? '' : ','}");
    }
  }
  
  void _outputElementDescriptor(Element element) {
    out.write("[\"${element.tagName}\"");
    // Output href.
    if (element.tagName == "a" && element.attributes.containsKey("href")) {
      String href = element.attributes["href"].trim();
      if (_validUrl(href)) {
        out.writeRaw(", \"$href\"");  // XXX: watch out for "
      }
    }
    // Output src.
    if (element.tagName == "img" && element.attributes.containsKey("src")) {
      String src = element.attributes["src"].trim();
      if (_validUrl(src)) {
        out.writeRaw(", \"$src\"");  // XXX: watch out for "
      }
    }
    // Output classes, title, id.
    if (element.attributes.containsKey("class") ||
        element.attributes.containsKey("id") ||
        element.attributes.containsKey("title")) {
      Map map = new Map();
      if (element.attributes.containsKey("id")) {
        map["i"] = element.attributes["id"];
      }
      if (element.attributes.containsKey("title")) {
        map["t"] = element.attributes["title"];
      }
      if (element.attributes.containsKey("class")) {
        map["c"] = element.attributes["class"].split(" ");
      }
      if (map.isNotEmpty) {
        out.writeRaw(", {");
        List<String> attributes = new List<String>();
        map.forEach((String key, Object value) {
          if (value is List) {
            assert(key == "c");
            out.writeRaw("\"$key\": [\"${value.join("\", \"")}\"]");
          } else {
            assert(value is String);
            out.writeRaw("\"$key\": \"$value\"");
          }
        });
        out.writeRaw(attributes.join(", "));
        out.writeRaw("}");
      }
    }
    out.writeRaw("]");
    if (element.nodes.isNotEmpty) {
      out.writeRaw(",");
    }
    out.writeRaw("\n");
  }
  
  bool _validUrl(String href) {
    return href.startsWith("http://") || href.startsWith("https://") ||
        href.startsWith("#") || href.startsWith("//");  // TODO: actually validate
  }

}

class _IndentedStringBuffer extends StringBuffer {
  int indentationLevel = 0;
  final String indentationString = "  ";
  
  void clear() {
    indentationLevel = 0;
    super.clear();
  }
  
  void indent() {
    indentationLevel += 1;
  }
  
  void deindent() {
    indentationLevel -= 1;
    if (indentationLevel < 0) {
      indentationLevel = 0;
    }
  }
  
  void writeln([Object obj = ""]) {
    write(obj);
    super.write("\n");
  }
  
  void write([Object obj = ""]) {
    _addIndentString(indentationLevel);
    super.write(obj);
  }
  
  void writeRaw([Object obj = ""]) => super.write(obj);

  void _addIndentString(int level) {
    for (int i = 0; i < level; i++) {
      super.write(indentationString);
    }
  }
}


