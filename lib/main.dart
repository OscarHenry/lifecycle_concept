import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with GlobalRefreshMixin<MyHomePage> {
  late int _counter;
  late int rebuild;

  @override
  void initState() {
    _counter = 0;
    rebuild = 0;
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void onResume() {
    /// Here you reset the counter to 0 and increment the rebuild counter
    if (mounted) {
      setState(() {
        _counter = 0;
        rebuild++;
      });
    }
    super.onResume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lifecycle App')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'When app is resumed,the widget will rebuild, the counter will be reset to 0 and the rebuild counter will be incremented ($rebuild)',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              const Text('You have pushed the button this many times:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

mixin GlobalRefreshMixin<T extends StatefulWidget> on State<T>
    implements WidgetsBindingObserver {
  /// This method will be called when the app is resumed
  ///
  /// You can override this method to do something when the app is resumed
  void onResume() {}

  @override
  void initState() {
    super.initState();

    /// Add this line to your initState method
    ///
    /// This will register the observer to the widget binding
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    /// Add this line to your dispose method
    ///
    /// This will unregister the observer from the widget binding
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      /// This is where you can trigger a global refresh of your app
      onResume();
    }
  }

  @override
  void didChangeAccessibilityFeatures() {
    log('$runtimeType didChangeAccessibilityFeatures');
    // TODO: implement didChangeAccessibilityFeatures
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    log('$runtimeType didChangeLocales');
    // TODO: implement didChangeLocales
  }

  @override
  void didChangeMetrics() {
    log('$runtimeType didChangeMetrics');
    // TODO: implement didChangeMetrics
  }

  @override
  void didChangePlatformBrightness() {
    log('$runtimeType didChangePlatformBrightness');
    // TODO: implement didChangePlatformBrightness
  }

  @override
  void didChangeTextScaleFactor() {
    log('$runtimeType didChangeTextScaleFactor');
    // TODO: implement didChangeTextScaleFactor
  }

  @override
  void didHaveMemoryPressure() {
    log('$runtimeType didHaveMemoryPressure');
    // TODO: implement didHaveMemoryPressure
  }

  @override
  Future<bool> didPopRoute() {
    log('$runtimeType didPopRoute');
    // TODO: implement didPopRoute
    throw UnimplementedError();
  }

  @override
  Future<bool> didPushRoute(String route) {
    log('$runtimeType didPushRoute');
    // TODO: implement didPushRoute
    throw UnimplementedError();
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    log('$runtimeType didPushRouteInformation');
    // TODO: implement didPushRouteInformation
    throw UnimplementedError();
  }
}
