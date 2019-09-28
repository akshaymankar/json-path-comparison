Results do not match other implementations

The following queries provide results that do not match those of other implementations of JSONPath
(compare https://cburgmer.github.io/json-path-comparison/):

- [ ] `$.2`
  Input:
  ```
  {"a": "first", "2": "second", "b": "third"}
  ```
  Expected output:
  ```
  ["second"]
  ```
  Error:
  ```
  Exception in thread "main" org.antlr.v4.runtime.misc.ParseCancellationException
  	at org.antlr.v4.runtime.BailErrorStrategy.recoverInline(BailErrorStrategy.java:66)
  	at org.antlr.v4.runtime.Parser.match(Parser.java:206)
  	at org.jsfr.json.compiler.JsonPathParser.childNode(JsonPathParser.java:672)
  	at org.jsfr.json.compiler.JsonPathParser.relativePath(JsonPathParser.java:272)
  	at org.jsfr.json.compiler.JsonPathParser.path(JsonPathParser.java:159)
  	at org.jsfr.json.compiler.JsonPathCompiler.compile(JsonPathCompiler.java:283)
  	at org.jsfr.json.compiler.JsonPathCompiler.compile(JsonPathCompiler.java:273)
  	at org.jsfr.json.JsonSurfer.collectAll(JsonSurfer.java:262)
  	at query.App.main(App.java:27)
  Caused by: org.antlr.v4.runtime.InputMismatchException
  	at org.antlr.v4.runtime.BailErrorStrategy.recoverInline(BailErrorStrategy.java:61)
  	... 8 more
  ```

- [ ] `$[-1:]`
  Input:
  ```
  ["first", "second", "third"]
  ```
  Expected output:
  ```
  ["third"]
  ```
  Actual output:
  ```
  ["first", "second", "third"]
  ```

- [ ] `$[0:3:2]`
  Input:
  ```
  ["first", "second", "third", "forth", "fifth"]
  ```
  Expected output:
  ```
  ["first", "third"]
  ```
  Error:
  ```
  Exception in thread "main" org.antlr.v4.runtime.misc.ParseCancellationException
  	at org.antlr.v4.runtime.BailErrorStrategy.recoverInline(BailErrorStrategy.java:66)
  	at org.antlr.v4.runtime.Parser.match(Parser.java:206)
  	at org.jsfr.json.compiler.JsonPathParser.slicing(JsonPathParser.java:636)
  	at org.jsfr.json.compiler.JsonPathParser.relativePath(JsonPathParser.java:265)
  	at org.jsfr.json.compiler.JsonPathParser.path(JsonPathParser.java:159)
  	at org.jsfr.json.compiler.JsonPathCompiler.compile(JsonPathCompiler.java:283)
  	at org.jsfr.json.compiler.JsonPathCompiler.compile(JsonPathCompiler.java:273)
  	at org.jsfr.json.JsonSurfer.collectAll(JsonSurfer.java:262)
  	at query.App.main(App.java:27)
  Caused by: org.antlr.v4.runtime.InputMismatchException
  	at org.antlr.v4.runtime.BailErrorStrategy.recoverInline(BailErrorStrategy.java:61)
  	... 8 more
  ```

- [ ] `$[0:3:1]`
  Input:
  ```
  ["first", "second", "third", "forth", "fifth"]
  ```
  Expected output:
  ```
  ["first", "second", "third"]
  ```
  Error:
  ```
  Exception in thread "main" org.antlr.v4.runtime.misc.ParseCancellationException
  	at org.antlr.v4.runtime.BailErrorStrategy.recoverInline(BailErrorStrategy.java:66)
  	at org.antlr.v4.runtime.Parser.match(Parser.java:206)
  	at org.jsfr.json.compiler.JsonPathParser.slicing(JsonPathParser.java:636)
  	at org.jsfr.json.compiler.JsonPathParser.relativePath(JsonPathParser.java:265)
  	at org.jsfr.json.compiler.JsonPathParser.path(JsonPathParser.java:159)
  	at org.jsfr.json.compiler.JsonPathCompiler.compile(JsonPathCompiler.java:283)
  	at org.jsfr.json.compiler.JsonPathCompiler.compile(JsonPathCompiler.java:273)
  	at org.jsfr.json.JsonSurfer.collectAll(JsonSurfer.java:262)
  	at query.App.main(App.java:27)
  Caused by: org.antlr.v4.runtime.InputMismatchException
  	at org.antlr.v4.runtime.BailErrorStrategy.recoverInline(BailErrorStrategy.java:61)
  	... 8 more
  ```

- [ ] `$[::2]`
  Input:
  ```
  ["first", "second", "third", "forth", "fifth"]
  ```
  Expected output:
  ```
  ["first", "third", "fifth"]
  ```
  Error:
  ```
  Exception in thread "main" org.antlr.v4.runtime.misc.ParseCancellationException
  	at org.antlr.v4.runtime.BailErrorStrategy.recoverInline(BailErrorStrategy.java:66)
  	at org.antlr.v4.runtime.Parser.match(Parser.java:206)
  	at org.jsfr.json.compiler.JsonPathParser.slicing(JsonPathParser.java:636)
  	at org.jsfr.json.compiler.JsonPathParser.relativePath(JsonPathParser.java:265)
  	at org.jsfr.json.compiler.JsonPathParser.path(JsonPathParser.java:159)
  	at org.jsfr.json.compiler.JsonPathCompiler.compile(JsonPathCompiler.java:283)
  	at org.jsfr.json.compiler.JsonPathCompiler.compile(JsonPathCompiler.java:273)
  	at org.jsfr.json.JsonSurfer.collectAll(JsonSurfer.java:262)
  	at query.App.main(App.java:27)
  Caused by: org.antlr.v4.runtime.InputMismatchException
  	at org.antlr.v4.runtime.BailErrorStrategy.recoverInline(BailErrorStrategy.java:61)
  	... 8 more
  ```

- [ ] `$.['key']`
  Input:
  ```
  {"key": "value"}
  ```
  Expected output:
  ```
  ["value"]
  ```
  Error:
  ```
  Exception in thread "main" org.antlr.v4.runtime.misc.ParseCancellationException
  	at org.antlr.v4.runtime.BailErrorStrategy.recoverInline(BailErrorStrategy.java:66)
  	at org.antlr.v4.runtime.Parser.match(Parser.java:206)
  	at org.jsfr.json.compiler.JsonPathParser.childNode(JsonPathParser.java:672)
  	at org.jsfr.json.compiler.JsonPathParser.relativePath(JsonPathParser.java:272)
  	at org.jsfr.json.compiler.JsonPathParser.path(JsonPathParser.java:159)
  	at org.jsfr.json.compiler.JsonPathCompiler.compile(JsonPathCompiler.java:283)
  	at org.jsfr.json.compiler.JsonPathCompiler.compile(JsonPathCompiler.java:273)
  	at org.jsfr.json.JsonSurfer.collectAll(JsonSurfer.java:262)
  	at query.App.main(App.java:27)
  Caused by: org.antlr.v4.runtime.InputMismatchException
  	at org.antlr.v4.runtime.BailErrorStrategy.recoverInline(BailErrorStrategy.java:61)
  	... 8 more
  ```


For reference, the output was generated by the program in https://github.com/cburgmer/json-path-comparison/tree/master/implementations/Java_com.github.jsurfer.
