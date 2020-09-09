library benchmark;

import 'package:benchmark_harness/benchmark_harness.dart';
import "dart:html";
import "dart:convert" show jsonEncode;

import "package:jsonml/html2jsonml.dart";
import "package:jsonml/jsonml2dom.dart";

part 'benchmark_html.dart';

class JsonML2DOMBenchmark extends BenchmarkBase {
  JsonML2DOMBenchmark(String name, this.html) : super("JsonML2DOM<$name>");

  // The benchmark code.
  @override
  void run() {
    destination.nodes.clear();
    destination.append(decodeToDom(jsonml, unsafe: true));
  }

  final String html;
  DivElement destination;
  List jsonml;

  // Not measured setup code executed prior to the benchmark runs.
  @override
  void setup() {
    destination = querySelector("div#destination") as DivElement;
    jsonml = encodeToJsonML(html) as List;
  }
}

class JsonML2DOMWithJsonDecodeBenchmark extends BenchmarkBase {
  JsonML2DOMWithJsonDecodeBenchmark(String name, this.html)
      : super("JsonML2DOMWithJsonDecode<$name>");

  @override
  void run() {
    destination.children.clear();
    destination.append(decodeStringToDom(jsonmlJson, unsafe: true));
  }

  final String html;
  DivElement destination;
  String jsonmlJson;

  @override
  void setup() {
    destination = querySelector("div#destination") as DivElement;
    var jsonml = encodeToJsonML(html);
    jsonmlJson = jsonEncode(jsonml);
  }
}

class InnerHtmlBenchmark extends BenchmarkBase {
  InnerHtmlBenchmark(String name, this.html) : super("InnerHtml<$name>");

  // The benchmark code.
  @override
  void run() {
    destination.nodes.clear();
    destination.innerHtml = html;
  }

  final String html;
  DivElement destination;

  // Not measured setup code executed prior to the benchmark runs.
  @override
  void setup() {
    destination = querySelector("div#destination") as DivElement;
  }
}

num _runAndReturnScore(BenchmarkBase benchmark) {
  num score = benchmark.measure();
  print("${benchmark.name}(RunTime): $score us.");
  return score;
}

void _runAllWithSameInput(String name, String input) {
  print("=== Running all benchmarks with input type $name. ===");
  // Unfair to really compare, since this doesn't parse anything. But still
  // good to see the speedup.
  _runAndReturnScore(JsonML2DOMBenchmark(name, input));
  var jsonmlStringScore =
      _runAndReturnScore(JsonML2DOMWithJsonDecodeBenchmark(name, input));
  var innerhtmlScore = _runAndReturnScore(InnerHtmlBenchmark(name, input));

  print("Speedup of JsonML versus innerHtml is "
      "${innerhtmlScore / jsonmlStringScore}x "
      "(${(((innerhtmlScore / jsonmlStringScore) - 1) * 100).toInt()}% "
      "faster).");
}

void main() {
  // Short and structured HTML.
  _runAllWithSameInput("Short", shortHtml);

  // Long and not so tightly structured (resembles normal web page content).
  // _runAllWithSameInput("Long", longHtml);

  // Same as above, but doesn't force innerHtml to print all the warning
  // messages (comparison is much more fair here).
  _runAllWithSameInput(
      "LongSafe", longHtml.replaceAll(RegExp(r'''http://.+?"'''), '#"'));
}
