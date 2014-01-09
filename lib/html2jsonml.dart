library html2jsonml;

import 'package:html5lib/parser.dart' show parseFragment;
import 'package:html5lib/dom.dart';

part 'src/html2jsonml/encode.dart';

/**
 * Takes a valid HTML5 string, parses it (via the html5lib library) and
 * encodes the resulting tree as JsonML. Returns the JsonML [Object] (usually
 * a [List]). This object is guaranteed to be a valid input for 
 * [:JSON.encode():].
 */
Object encode(String html) {
  DocumentFragment tree = parseFragment(html);
  return _encodeNode(tree);
}