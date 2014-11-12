library jsonml2dom;

import "dart:html";
import "dart:svg";
import "dart:convert";
import "src/exception.dart";
import 'src/constants.dart';

part 'src/jsonml2dom/create_node.dart';

/**
 * Takes an JsonML object (not [String] JSON, but the decoded object, most 
 * often a [List]) and returns the DOM [Node] it specifies. This works 
 * recursively, so a whole page structure can be created this way.
 * 
 * Example usage:
 * 
 *     var content = JSON.decode(jsonString);
 *     querySelector("#content").append(jsonml2dom(content, unsafe: true));
 *    
 * When the [unsafe] optional argument is [:true:], the JsonML object will be
 * copied to the DOM verbatim, including potentially insecure tags like
 * [:<script>:] and attributes like [:href:]. In safe mode ([:unsafe == false:])
 * the potentially dangerous content would be stripped before creating the DOM
 * nodes. This is not implemented yet, so **the user must currently always
 * specify [:unsafe: true:]**. This is to ensure that the unsafeness is explicit
 * in the code.
 * 
 * The other optional argument, [customTags], allows the user to specify custom
 * handlers. When a tag is found in the input [jsonml] that is specified (as a
 * key) in [customTags], the provided function will be called. For example,
 * if [:customTags = {"myElement": (el) => new PElement()}:], then every
 * occurenct of [:myElement:] as a tag would produce an empty [:<p>:] element.
 */
Node decodeToDom(Object jsonml, 
                {bool unsafe: false, 
                 Map<String,CustomTagHandler> customTags: null}) {
  return _createNode(jsonml, unsafe: unsafe, customTags: customTags);
}

/**
 * Utility function that takes a JSON [String], decodes it and then calls
 * [decodeToDom] on the resulting object.
 */
Node decodeStringToDom(String jsonml, 
                      {bool unsafe: false, 
                       Map<String,CustomTagHandler> customTags: null}) => 
      decodeToDom(JSON.decode(jsonml), unsafe: unsafe, customTags: customTags);

/**
 * Function definition for custom tag handlers.
 */
typedef Node CustomTagHandler(Object jsonMLObject);
