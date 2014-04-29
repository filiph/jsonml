library html2jsonml;

import 'package:html5lib/parser.dart' show parseFragment;
import 'html5lib2jsonml.dart' as html5lib show encodeToJsonML;
import 'package:html5lib/dom.dart';

/**
 * Takes a valid HTML5 [String], parses it (via the html5lib library) and
 * encodes the resulting tree as JsonML. Returns the JsonML [Object] (usually
 * a [List]). This object is guaranteed to be a valid input for 
 * [:JSON.encode():].
 */
List encodeToJsonML(String html) {
  DocumentFragment tree = parseFragment(html);
  return html5lib.encodeToJsonML(tree);
}