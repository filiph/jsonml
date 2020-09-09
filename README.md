[![Build Status](https://travis-ci.org/filiph/jsonml.svg?branch=master)](https://travis-ci.org/filiph/jsonml)

This is an implementation of [JsonML][] in Dart.

JsonML is useful whenever you are sending HTML to the client from a server (or from an Isolate). Instead of sending the HTML string (which needs to be parsed and, ideally, sanitized), you are sending a lossless representation of it in JSON format.

This is how a simple paragraph looks like in JsonML:

```dart
["p", 
  {"class": "example"},
  "This paragraph is ",
  ["em",
    "all"
  ],
  " about ",
  ["a",
    {"href": "http://www.jsonml.org/"},
    "JsonML"
  ],
  "."
]
```

The object above would be rendered as:

<blockquote>
    <p class="example">This paragraph is <em>all</em> about <a href="http://www.jsonml.org/">JsonML</a>.</p>
</blockquote>

Advantages over HTML:

1. It's sent as JSON, and therefore it is relatively inexpensive to parse.
2. It can exist in the memory as a simple Dart/JavaScript object --- no special class structure needed.
3. It's a list (array) of nodes, and so it's pre-formatted for fast DOM building on the client side.

For more information about the format, including formal specs and examples of use, read the [official JsonML site][JsonML].

## Example

Note: See examples in `example/` to get the full picture.

```dart
import "package:jsonml/html2jsonml.dart";

var jsonml = encodeToJsonML("<h1>Title</h1><p>First paragraph.</p><p>Second paragraph.</p>");
```

The object can be then stringified by calling `JSON.encode()` of the standard `dart:convert` library.

In the browser, here is how one can append the contents of the JsonML object to a DOM element.

```dart
import "package:jsonml/jsonml2dom.dart";

var node = decodeToDom(jsonml, unsafe: true);
querySelector("#destination").append(node);
```

The `decodeToDom` function takes an Object. For convenience, one can also use `decodeStringToDom`, which takes a String (which it then decodes using the standard JSON library).

Note the `unsafe: true` optional attribute. When the `unsafe` optional argument is `true`, the JsonML object will be copied to the DOM verbatim, including potentially insecure tags like `<script>` and attributes like `href`. In safe mode (`unsafe == false`) the potentially dangerous content would be stripped before creating the DOM nodes. This is not implemented yet, so **the user must currently always specify `unsafe: true`**. This ensures that the unsafeness is explicit in the code.

## Security

The library currently doesn't employ any stripping of potentially unsecure tags and attributes. This is made explicit by forcing the user to provide the optional argument `unsafe: true`. As ironic as it sounds (forcing an _optional_ argument), it's there for a reason. No user content should ever be sent to DOM via jsonml2dom.

In the future, when `unsafe == false`, the library will take care of stripping anything that could be malicious (in the same way as the Dart standard library's `innerHtml` does already). This isn't yet implemented.

## Speed

The repo contains a benchmark harness. It measures the speed with which the browser can go from a String representation of the DOM to the actual elements, and compares HTML+innerHtml with JsonML+this library.

Not surprisingly, JsonML fares better in terms of speed than HTML. In my limited testing, it seems that shorter structured text can easily be twice as fast (Chrome 2.8x) to parse and render with JsonML than with innerHtml. With longer and less structured text, the performance gain diminishes but is still significant. Parsing and rendering of [a longer article][benchmarkArticle] is a good 70% faster (Chrome 1.7x).

Even more performance is gained by skipping String parsing. This is not doable with HTML (there is no non-string representation of HTML in Dart/JavaScript), but easy with JsonML (JsonML object is just a list of lists, maps and strings). When working with JsonML objects (List) instead of JsonML strings, the library can easily be 3 times faster than innerHtml.

The speed of encoding from HTML to JsonML is not measured (at the moment) since performance there doesn't tend to be an issue (this is normally executed only once and on the server, not on clients).

## TODO

* dom2jsonml for sending page structure back to the server (for example when user can edit DOM elements)
* safe mode (see above)

---

## History

As an aside: this project started as "HSON" (HTML over JSON) before I realized this idea can't be original &mdash; and of course it wasn't. The original "HSON" format was a bit less verbose, but that was its only advantage. It was also much less flexible and portable, and made less sense in general. The moral of this story: whenever you have an idea, _start_ with searching the net.


[JsonML]: http://www.jsonml.org/
[html2dom]: https://blog.mozilla.org/security/2013/09/24/introducing-html2dom-an-alternative-to-setting-innerhtml/
[Dart]: https://dart.dev/
[benchmarkArticle]: https://dart.dev/tools/pub/package-layout
