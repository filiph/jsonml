library html2jsonml;

import 'package:html5lib/parser.dart' show parseFragment;
import 'html5lib2jsonml.dart' as html5lib show encodeToJsonML;
import 'package:html5lib/dom.dart' show DocumentFragment;

/**
 * Takes an HTML string and converts it to JsonML object.
 */
List encodeToJsonML(String html) {
  DocumentFragment tree = parseFragment(html);
  return html5lib.encodeToJsonML(tree);
}

