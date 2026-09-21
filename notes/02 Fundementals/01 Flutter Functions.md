# Entry Point Function
main.dart -> main(){...} is the entry point, must be the file and function name combination
```
import 'package:flutter/material.dart';

void main(){
	runApp(const MaterialApp(home: Text()));
}

```

`runApp` is responsible for what is being drawn on the screen
see [[02 Widgets]] and [[03 Imports]]

`MaterialApp` is a child of `Widget`
`MaterialApp` is a constructor and is a core widget which is used in many apps and does a lot of back-end work for the app

Nested in `MaterialApp` has a long list of named parameters, `home` named argument is the main parameter to indicate which widget to display on screen
## Parameters
 

`const` keyword optimises widgets and app, better re-use and makes app more memory efficient. Best practice to use if where possible

## Hot Reload

Hot reload re-runs `build()` methods on the existing widget tree, it does **not** re-run `main()`

If the widget tree is built directly inside `main()` (e.g. `runApp(MaterialApp(home: Scaffold(body: Text('Hello'))))` with no separate widget class), editing that code and hot reloading will report success but the screen won't change — nothing in the tree has a `build()` method that re-executes the edited line

Fix: wrap the app in a widget class with its own `build()` method, so hot reload has something to re-invoke
```
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: Text('Hello')));
  }
}
```
This is also why almost every real Flutter app has a root widget class instead of building the tree inline — see [[../misc/custom settings|Custom Settings]] (Mobile Workarounds section) for the debugging story that surfaced this