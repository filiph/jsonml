import 'package:benchmark_harness/benchmark_harness.dart';
import "dart:html";

import "package:jsonml/html2jsonml.dart";
import "package:jsonml/jsonml2dom.dart";

class JsonML2DOMBenchmark extends BenchmarkBase {
  JsonML2DOMBenchmark(this.htmlToConvert) : super("JsonML2DOM");
  String htmlToConvert;
  
  // The benchmark code.
  void run() {
    destination.append(decodeToDom(jsonml));
  }

  DivElement destination;
  List jsonml;
  
  // Not measured setup code executed prior to the benchmark runs.
  void setup() { 
    destination = querySelector("div#destination");
    
    jsonml = encodeToJsonML(SHORT_HTML);
  }

  // Not measures teardown code executed after the benchark runs.
  void teardown() {
    destination.nodes.clear();
  }
}

class InnerHtmlBenchmark extends BenchmarkBase {
  InnerHtmlBenchmark(this.htmlToConvert) : super("InnerHtml");
  String htmlToConvert;

  // The benchmark code.
  void run() {
    destination.innerHtml = html;
  }

  DivElement destination;
  String html;
  
  // Not measured setup code executed prior to the benchmark runs.
  void setup() { 
    destination = querySelector("div#destination");
    html = SHORT_HTML;
  }

  // Not measures teardown code executed after the benchark runs.
  void teardown() {
    destination.nodes.clear();
  }
}

main() {
  // Run TemplateBenchmark
  print("Short HTML");
  new JsonML2DOMBenchmark(SHORT_HTML).report();
  new InnerHtmlBenchmark(SHORT_HTML).report();
  
  print("Long HTML");
  new JsonML2DOMBenchmark(LONG_HTML).report();
  new InnerHtmlBenchmark(LONG_HTML).report();
}

String SHORT_HTML = "<p id='main'><a href='#'>This</a> is <em>"
    "<strong>very</strong></em> interesting.</p>";

String LONG_HTML = """
<div class="navbar navbar-fixed-top navbar-inverse" role="navigation">
      <div class="container">

        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/"><i class="sprite-icon-dart-logo"></i></a>
        </div>

        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
           <li class="dropdown">
              <a href="/codelabs/darrrt/" title="Learn Dart in this short code lab.">
                Get Started
              </a>
            </li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    Docs <span class="caret"></span>
              </a>
              <ul class="dropdown-menu">

                <i class="sprite-icon-dd-tip"></i>
                <li><a href="/docs/tutorials/">Tutorials</a></li>

                <i class="sprite-icon-dd-tip"></i>
                <li><a href="/dart-by-example/">Dart by Example</a></li>

                <li class="divider"></li>
                <li><a href="/docs/">Programmer's Guide</a></li>
                <li><a href="http://api.dartlang.org">API Reference</a></li>
                <li><a href="/docs/spec/">Language Specification</a></li>

                <li class="divider"></li>
                <li><a href="/docs/dart-up-and-running/">Dart: Up and Running</a></li>
                <li><a href="/books/">More Books</a></li>

                <li class="divider"></li>
                <li><a href="/articles/">Articles</a></li>
                <li><a href="/support/faq.html">FAQ</a></li>
              </ul>
            </li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    Tools <span class="caret"></span>
              </a>
              <ul class="dropdown-menu">
                <i class="sprite-icon-dd-tip"></i>
                <li><a href="/tools/download.html">Get Dart</a></li>
                <li class="divider"></li>
                </li><li><a href="/tools/editor/">Dart Editor</a></li>
                </li><li><a href="/tools/sdk/">SDK</a></li>
                </li><li><a href="/tools/dartium/">Dartium</a></li>
                <li class="divider"></li>
                <li><a href="/tools/">Dart Tools</a></li>
                <li><a href="/tools/pub/">Pub Package and Asset Manager</a></li>
                <li><a href="/tools/faq.html">Tools FAQ</a></li>
              </ul>
            </li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    Resources <span class="caret"></span>
              </a>
              <ul class="dropdown-menu">
                <i class="sprite-icon-dd-tip"></i>
                <li><a href="/samples/">Code Samples</a></li>
                <li><a href="/docs/synonyms/">Synonyms with other languages</a></li>
                <li><a href="/performance/">Performance</a></li>

                <li class="divider"></li>
                <li><a href="/slides/">Presentations</a></li>
                <li><a href="/dart-tips/">Dart Tips Videos</a></li>

                <li class="divider"></li>
                <li><a href="/community/who-uses-dart.html">Who Uses Dart</a></li>
              </ul>
            </li>
            <li class="dropdown">
              <a href="/support/" title="Community and Support">
                    Support
              </a>
            </li>
          </ul>

          <ul class="nav navbar-nav navbar-right">
            <li>
              <form class="navbar-search" action="/search.html" id="cse-search-box">
                <input type="hidden" name="cx" value="011220921317074318178:i4mscbaxtru">
                <input type="hidden" name="ie" value="UTF-8">
                <input type="hidden" name="hl" value="en">
                <input type="search" name="q" class="search-query placeholder-position-fix form-control" id="q" autocomplete="off" placeholder="Search">
              </form>
            </li>
            <li><a href="https://twitter.com/dart_lang" class="btn"><i class="sprite-icon-social-twitter"></i></a></li>
            <li><a href="https://plus.google.com/+dartlang/posts" class="btn"><i class="sprite-icon-social-gplus"></i></a></li>
          </ul>
        </div><!-- /.nav-collapse -->

      </div><!-- /.container -->
    </div><!-- /.navbar -->




<div class="container-page">
  <div class="container">
    <div class="container col-md-10 col-md-offset-1 sub-page">
      <div>
      <div class="col-md-4">
  <div class="bs-sidebar hidden-print" data-spy="affix" data-offset-bottom="350" role="complementary">

<ol class="toc nav bs-sidenav" id="markdown-toc">
  <li><a href="#the-basics">The basics</a></li>
  <li><a href="#readme">README</a></li>
  <li><a href="#public-libraries">Public libraries</a></li>
  <li><a href="#referencing-packages">Referencing packages</a></li>
  <li><a href="#public-assets">Public assets</a></li>
  <li><a href="#implementation-files">Implementation files</a></li>
  <li><a href="#web-files">Web files</a></li>
  <li><a href="#command-line-apps">Command-line apps</a></li>
  <li><a href="#tests-and-benchmarks">Tests and benchmarks</a></li>
  <li><a href="#documentation">Documentation</a></li>
  <li><a href="#examples">Examples</a></li>
  <li><a href="#internal-tools-and-scripts">Internal tools and scripts</a></li>
</ol>

  </div>
</div>
<div class="col-md-8">
  <p><!-- Start of content -->
</p>

  <h1 id="pub-package-layout-conventions">Pub Package Layout Conventions</h1>

  <p>Part of a healthy code ecosystem is consistent conventions. When we all do the
same thing the same way, it makes it easier for us to learn our way around
each other’s work. It also makes it easier to write tools that can
automatically do things for us.</p>

  <p>When you build a <a href="/tools/pub/">pub</a> package, we have a set of conventions we encourage you to
follow. They describe how you organize the files and directories within your
package, and how to name things. You don’t have to have every single thing
these guidelines specify. If your package doesn’t have binaries, it doesn’t
need a directory for them. But if it does, you’ll make everyone’s life easier
if you call it <code>bin</code>.</p>

  <p>To give you a picture of the whole enchilada, here’s what a complete package
(conveniently named <code>enchilada</code>) that uses every corner of these guidelines
would look like:</p>

  <pre><code>enchilada/
  pubspec.yaml
  pubspec.lock *
  README.md
  LICENSE
  benchmark/
    make_lunch.dart
    packages/ **
  bin/
    enchilada
    packages/ **
  doc/
    getting_started.md
  example/
    lunch.dart
    packages/ **
  lib/
    enchilada.dart
    tortilla.dart
    guacamole.css
    src/
      beans.dart
      queso.dart
  packages/ **
  test/
    enchilada_test.dart
    tortilla_test.dart
    packages/ **
  tool/
    generate_docs.dart
  web/
    index.html
    main.dart
    style.css
</code></pre>

  <p>* The <code>pubspec.lock</code> will only be in source control if the package is an
<a href="glossary.html#application-package">application package</a>.</p>

  <p>** The <code>packages</code> directories will exist locally after you’ve run
<code>pub get</code>, but won’t be checked into source control.</p>

  <h2 id="the-basics">The basics</h2>

  <pre><code>enchilada/
  pubspec.yaml
  pubspec.lock
</code></pre>

  <p>Every package will have a <a href="pubspec.html"><em>pubspec</em></a>, a file named
<code>pubspec.yaml</code>, in the root directory of the package. That’s what <em>makes</em> it a
package.</p>

  <p>Once you’ve run <a href="cmd/pub-get.html"><code>pub get</code></a> or <a href="cmd/pub-upgrade.html"><code>pub
upgrade</code></a> on the package, you will also have a
<strong>lockfile</strong>, named <code>pubspec.lock</code>. If your package is an <a href="glossary.html#application-package">application
package</a>, this will be checked into source
control. Otherwise, it won’t be.</p>

  <pre><code>enchilada/
  packages/
    ...
</code></pre>

  <p>Running pub will also generate a <code>packages</code> directory. You will <em>not</em> check
this into source control, and you won’t need to worry too much about its
contents. Consider it pub magic, but not scary magic.</p>

  <p>The open source community has a few other files that commonly appear at the top
level of a project: <code>LICENSE</code>, <code>AUTHORS</code>, etc. If you use any of those, they can
go in the top level of the package too.</p>

  <p>For more information, see <a href="pubspec.html">Pubspec Format</a>.</p>

  <h2 id="readme">README</h2>

  <pre><code>enchilada/
  README.md
</code></pre>

  <p>One file that’s very common in open source is a README file that
describes the project. This is especially important in pub. When you upload
to <a href="http://pub.dartlang.org">pub.dartlang.org</a>, your README will be shown on
the page for your package. This is the perfect place to introduce people to
your code.</p>

  <p>If your README ends in <code>.md</code>, <code>.markdown</code>, or <code>.mdown</code>, it will be parsed as
<a href="http://daringfireball.net/projects/markdown/">Markdown</a>.</p>

  <h2 id="public-libraries">Public libraries</h2>

  <pre><code>enchilada/
  lib/
    enchilada.dart
    tortilla.dart
</code></pre>

  <p>Many packages are <a href="glossary.html#library-package"><em>library packages</em></a>: they
define Dart libraries that other packages can import and use. These public Dart
library files go inside a directory called <code>lib</code>.</p>

  <p>Most packages define a single library that users can import. In that case,
its name should usually be the same as the name of the package, like
<code>enchilada.dart</code> in the example here. But you can also define other libraries
with whatever names make sense for your package.</p>

  <p>When you do, users can import these libraries using the name of the package and
the library file, like so:</p>

  <pre class="prettyprint lang-dart">
import &quot;package:enchilada/enchilada.dart&quot;;
import &quot;package:enchilada/tortilla.dart&quot;;
</pre>

  <p>If you want to organize your public libraries, you can also create
subdirectories inside <code>lib</code>. If you do that, users will specify that path when
they import it. Say you have the following file hierarchy:</p>

  <pre><code>enchilada/
  lib/
    some/
      path/
        olives.dart
</code></pre>

  <p>Users will import <code>olives.dart</code> as follows:</p>

  <pre class="prettyprint lang-dart">
import &quot;package:enchilada/some/path/olives.dart&quot;;
</pre>

  <p>Note that only <em>libraries</em> should be in <code>lib</code>. <em>Entrypoints</em>—Dart scripts
with a <code>main()</code> function—cannot go in <code>lib</code>. If you place a Dart script
inside <code>lib</code>, you will discover that any <code>package:</code> imports it contains don’t
resolve. Instead, your entrypoints should go in the appropriate
<a href="glossary.html#entrypoint-directory">entrypoint directory</a>.</p>

  <h2 id="referencing-packages">Referencing packages</h2>

  <p>You can, of course, reference a package from within your app.
For example, say your source tree looks like this:</p>

  <pre class="prettyprint lang-lang">
myapp/
  example/
    one/
      sub/
        index.html
</pre>

  <p>The resulting build directory has the following structure:</p>

  <pre class="prettyprint lang-lang">
build/
  example/
    one/
      packages/
        myapp/
          style.css
      sub/
        index.html
</pre>

  <p>In this scenario, index.html references the stylesheet using
the relative path <code>../packages/myapp/style.css</code>. (Note the leading <code>..</code>.)</p>

  <p>You can also use a path relative to the root URL, such as
<code>/packages/myapp/style.css</code>, but you must be careful on how you
deploy your app.</p>

  <h2 id="public-assets">Public assets</h2>

  <pre><code>enchilada/
  lib/
    guacamole.css
</code></pre>

  <p>While most library packages exist to let you reuse Dart code, you can also
reuse other kinds of content. For example, a package for
<a href="http://getbootstrap.com/">Bootstrap</a> might include a number of CSS files for
consumers of the package to use.</p>

  <p>These go in the top-level <code>lib</code> directory. You can put any kind of file
in there and organize it with subdirectories however you like.</p>

  <p>Users can reference another package’s assets using URLs that contain
<code>/packages/&lt;package&gt;/&lt;path&gt;</code> where <code>&lt;package&gt;</code> is the name of the package
containing the asset and <code>&lt;path&gt;</code> is the relative path to the asset within that
package’s <code>lib</code> directory.</p>

  <aside class="alert alert-info">
    <p>Prior to Dart 1.4, assets were also placed in the top-level
<tt>asset</tt> directory. The <tt>asset</tt> directory is being deprecated
and will be removed from 1.4.</p>
  </aside>

  <p>For example, let’s say your package wanted to use enchilada’s <code>guacamole.css</code>
styles. In an HTML file in your package, you can add:</p>

  <pre class="prettyprint lang-html">
&lt;link href=&quot;packages/enchilada/guacamole.css&quot; rel=&quot;stylesheet&quot;&gt;
</pre>

  <p>When you run your application using <a href="cmd/pub-serve.html"><code>pub serve</code></a>, or build
it to something deployable using <a href="cmd/pub-build.html"><code>pub build</code></a>, pub will
copy over any referenced assets that your package depends on.</p>

  <h2 id="implementation-files">Implementation files</h2>

  <pre><code>enchilada/
  lib/
    src/
      beans.dart
      queso.dart
</code></pre>

  <p>The libraries inside “lib” are publicly visible: other packages are free to
import them. But much of a package’s code is internal implementation libraries
that should only be imported and used by the package itself. Those go inside a
subdirectory of <code>lib</code> called <code>src</code>. You can create subdirectories in there if
it helps you organize things.</p>

  <p>You are free to import libraries that live in <code>lib/src</code> from within other Dart
code in the <em>same</em> package (like other libraries in <code>lib</code>, scripts in <code>bin</code>, and
tests) but you should never import from another package’s <code>lib/src</code> directory.
Those files are not part of the package’s public API, and they might change in
ways that could break your code.</p>

  <p>When you use libraries from within your own package, even code in <code>src</code>, you
can (and should) still use <code>"package:"</code> to import them. This is perfectly
legit:</p>

  <pre class="prettyprint lang-dart">
import &quot;package:enchilada/src/beans.dart&quot;;
</pre>

  <p>The name you use here (in this case <code>enchilada</code>) is the name you specify for
your package in its <a href="pubspec.html">pubspec</a>.</p>

  <h2 id="web-files">Web files</h2>

  <pre><code>enchilada/
  web/
    index.html
    main.dart
    style.css
</code></pre>

  <p>Dart is a web language, so many pub packages will be doing web stuff. That
means HTML, CSS, images, and, heck, probably even some JavaScript. All of that
goes into your package’s <code>web</code> directory. You’re free to organize the contents
of that to your heart’s content. Go crazy with subdirectories if that makes you
happy.</p>

  <p>Also, and this is important, any Dart web entrypoints (in other words, Dart
scripts that are referred to in a <code>&lt;script&gt;</code> tag) go under <code>web</code> and not <code>lib</code>.
That ensures that a <code>packages</code> directory is created nearby so that <code>package:</code>
imports can be resolved correctly.</p>

  <p>(You may be asking whether you should put your web-based example programs
in <code>example</code> or <code>web</code>?” Put those in <code>example</code>.)</p>

  <h2 id="command-line-apps">Command-line apps</h2>

  <pre><code>enchilada/
  bin/
    enchilada
</code></pre>

  <p>Some packages define programs that can be run directly from the command line.
These can be shell scripts or any other scripting language, including Dart.
The <code>pub</code> application itself is one example: it’s a simple shell script that
invokes <code>pub.dart</code>.</p>

  <p>If your package defines code like this, put it in a directory named <code>bin</code>.</p>

  <aside class="alert alert-note">
    <p>At some point, pub will support automatically adding that directory to your
system path so that these scripts can be easily invoked.</p>
  </aside>

  <h2 id="tests-and-benchmarks">Tests and benchmarks</h2>

  <pre><code>enchilada/
  test/
    enchilada_test.dart
    tortilla_test.dart
</code></pre>

  <p>Every package should have tests. With pub, the convention is
that these go in a <code>test</code> directory (or some directory inside it if you like)
and have <code>_test</code> at the end of their file names.</p>

  <p>Typically, these use the <a href="http://api.dartlang.org/unittest.html">unittest</a>
package.</p>

  <pre><code>enchilada/
  benchmark/
    make_lunch.dart
</code></pre>

  <p>Packages that have performance critical code may also include <em>benchmarks</em>.
These test the API not for correctness but for speed (or memory use, or maybe
other empirical metrics).</p>

  <h2 id="documentation">Documentation</h2>

  <pre><code>enchilada/
  doc/
    getting_started.md
</code></pre>

  <p>If you’ve got code and tests, the next piece you might want
is good documentation. That goes inside a directory named <code>doc</code>. We don’t
currently have any guidelines about format or organization within that. Use
whatever markup format that you prefer.</p>

  <p>This directory should <em>not</em> just contain docs generated automatically
from your source code using <a href="/tools/docgen/">docgen</a>. Since that’s
pulled directly from the code already in the package, putting those docs in
here would be redundant. Instead, this is for tutorials, guides, and other
hand-authored documentation <em>in addition to</em> generated API references.</p>

  <h2 id="examples">Examples</h2>

  <pre><code>enchilada/
  example/
    lunch.dart
</code></pre>

  <p>Code, tests, docs, what else
could your users want? Standalone example programs that use your package, of
course! Those go inside the <code>example</code> directory. If the examples are complex
and use multiple files, consider making a directory for each example. Otherwise,
you can place each one right inside <code>example</code>.</p>

  <p>This is an important place to consider using <code>package:</code> to import files from
your own package. That ensures the example code in your package looks exactly
like code outside of your package would look.</p>

  <h2 id="internal-tools-and-scripts">Internal tools and scripts</h2>

  <pre><code>enchilada/
  tool/
    generate_docs.dart
</code></pre>

  <p>Mature packages often have little helper scripts and programs that people
run while developing the package itself. Think things like test runners,
documentation generators, or other bits of automation.</p>

  <p>Unlike the scripts in <code>bin</code>, these are <em>not</em> for external users of the package.
If you have any of these, place them in a directory called <code>tool</code>.</p>
</div>

      </div>
    </div>
  </div>
</div>


  <footer class="footer container-full">
    <div class="container">
      <div class="row">
        <div class="col-md-5">
          <h3>A new language, with tools and libraries, for SCALABLE web app engineering</h3>
          <p>Dart is an <a href="https://code.google.com/p/dart/">open-source project</a> with contributors from Google and elsewhere.</p>
          <p class="sm">Except as otherwise noted, the content of this page is licensed under the Creative Commons Attribution 3.0 License, and code samples are licensed under the BSD License.</p>
        </div>
        <div class="col-md-2 col-md-offset-1">
          <h4>Popular Topics</h4>
          <ul>
            <li><a href="/polymer-dart/?utm_source=site&amp;utm_medium=footer&amp;utm_campaign=homepage">Polymer.dart</a></li>
            <li><a href="/performance/">Performance</a></li>
            <li><a href="/docs/dart-up-and-running/contents/ch02.html?utm_source=site&amp;utm_medium=footer&amp;utm_campaign=homepage">Language tour</a> &amp;
            <a href="/docs/dart-up-and-running/contents/ch03.html?utm_source=site&amp;utm_medium=footer&amp;utm_campaign=homepage">library tour</a></li>
            <li><a href="/samples/?utm_source=site&amp;utm_medium=footer&amp;utm_campaign=homepage">Code samples</a></li>
            <li><a href="/docs/tutorials/?utm_source=site&amp;utm_medium=footer&amp;utm_campaign=homepage">Tutorials</a> &amp;
                <a href="/codelabs/darrrt/?utm_source=site&amp;utm_medium=footer&amp;utm_campaign=homepage">code lab</a></li>
          </ul>
        </div>
        <div class="col-md-2">
          <h4>Resources</h4>
          <ul>
            <li><a href="http://pub.dartlang.org/">Pub packages</a></li>
            <li><a href="/docs/synonyms/">Synonyms with other languages</a></li>
            <li><a href="http://code.google.com/p/dart/issues/list">Dart bugs and feature requests</a></li>
          </ul>
        </div>
        <div class="col-md-2">
          <h4>Community</h4>
          <ul>
            <li><a href="/support/">Mailing lists</a></li>
            <li><a href="https://plus.google.com/communities/114566943291919232850">G+ community</a></li>
            <li><a href="https://plus.google.com/+dartlang/posts">G+ announcement group</a></li>
            <li><a href="http://stackoverflow.com/questions/tagged/dart">Stack Overflow</a></li>
          </ul>
        </div>
      </div>
    </div>
  </footer> <!-- End footer -->
""";