import 'package:benchmark_harness/benchmark_harness.dart';
import "dart:html";
import "dart:convert" show JSON;

import "package:jsonml/html2jsonml.dart";
import "package:jsonml/jsonml2dom.dart";

class JsonML2DOMBenchmark extends BenchmarkBase {
  JsonML2DOMBenchmark() : super("JsonML2DOM");

  static void main() {
    new JsonML2DOMBenchmark().report();
  }

  // The benchmark code.
  void run() {
    destination.append(jsonml2dom(jsonml, unsafe: true));
  }

  DivElement destination;
  List jsonml;
  
  // Not measured setup code executed prior to the benchmark runs.
  void setup() { 
    destination = querySelector("div#destination");
    jsonml = encode("<p id='main'><a href='#'>This</a> is <em><strong>very</strong></em> interesting.</p>");
  }

  // Not measures teardown code executed after the benchark runs.
  void teardown() {
    destination.nodes.clear();
  }
}

class JsonML2DOMWithJsonDecodeBenchmark extends BenchmarkBase {
  JsonML2DOMWithJsonDecodeBenchmark() : super("JsonML2DOMWithJsonDecode");
  
  static void main() {
    new JsonML2DOMWithJsonDecodeBenchmark().report();
  }
  
  void run() {
    destination.append(jsonmlString2dom(jsonmlJson, unsafe: true));
  }
  
  DivElement destination;
  String jsonmlJson;
  
  void setup() { 
    destination = querySelector("div#destination");
    var jsonml = encode("<p id='main'><a href='#'>This</a> is <em><strong>very</strong></em> interesting.</p>");
    jsonmlJson = JSON.encode(jsonml);
  }
  
  void teardown() {
    destination.nodes.clear();
  }
}

class InnerHtmlBenchmark extends BenchmarkBase {
  InnerHtmlBenchmark() : super("InnerHtml");

  static void main() {
    new InnerHtmlBenchmark().report();
  }

  // The benchmark code.
  void run() {
    destination.innerHtml = html;
  }

  DivElement destination;
  String html;
  
  // Not measured setup code executed prior to the benchmark runs.
  void setup() { 
    destination = querySelector("div#destination");
    html = "<p id='main'><a href='#'>This</a> is <em><strong>very</strong></em> interesting.</p>";
  }

  // Not measures teardown code executed after the benchark runs.
  void teardown() {
    destination.nodes.clear();
  }
}

main() {
  // Run TemplateBenchmark
  JsonML2DOMBenchmark.main();
  JsonML2DOMWithJsonDecodeBenchmark.main();
  InnerHtmlBenchmark.main();
}