library hson;

import 'package:html5lib/parser.dart' show parseFragment;
import 'package:html5lib/dom.dart';

const DOCSTRING = "HSON0.1";

String encode(String html) {
  DocumentFragment tree = parseFragment(html);
  _IndentedStringBuffer out = new _IndentedStringBuffer();
  out.writeln("[");
  out.indent();  
  out.writeln("\"$DOCSTRING\",");
  
  // The containing node is always a DOCUMENT_FRAGMENT_NODE. Start with its
  // child nodes from the get go.
  int length = tree.nodes.length;
  for (int i = 0; i < length; i++) {
    _encodeNode(tree.nodes[i], out, last: i == length - 1);
  }
  out.deindent();
  out.writeln("]");
  return out.toString();
}

void _encodeNode(Node node, _IndentedStringBuffer out, {bool last: false}) {
  if (node is Text /* TEXT_NODE */) {
    out.writeln("\"${node.value}\"${last ? '' : ','}"); // TODO: guard against "
  } else if (node is Element || node is Document) {
    out.writeln("[");
    out.indent();

    if (node is DocumentFragment) {
      out.writeln("[\"FRAGMENT\"]${node.nodes.isEmpty ? '' : ','}");
    } else if (node is Element) {
      _outputElementDescriptor(node, out);
    }
    int length = node.nodes.length;
    for (int i = 0; i < length; i++) {
      _encodeNode(node.nodes[i], out, last: i == length - 1);
    }
    out.deindent();
    out.writeln("]${last ? '' : ','}");
  }
}

void _outputElementDescriptor(Element element, _IndentedStringBuffer out) {
  out.write("[\"${element.tagName}\"");
  // TODO: output classes (as list), id, title as JSON map at end of descriptor.
  // Output classes.
  if (element.attributes.containsKey("class")) {
    out.writeRaw(", \"${element.attributes["class"]}\"");
  }
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

class _IndentedStringBuffer extends StringBuffer {
  int indentationLevel = 0;
  final String indentationString = "  ";
  
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


