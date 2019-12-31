import 'package:flutter/material.dart';
import 'package:int_toolbox_example/generated/localizations/localizations_util.dart';
import 'package:int_toolbox_example/res/string_resources.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      localizationsDelegates: StringResources
          .localizationsDelegate, // Set the localizationsDelegate
      supportedLocales: StringResources
          .supportedLocales, // Set the supportedLocales (Editable in lib/res/string_resources.dart)
      locale: Locale('en', 'US'), // Selected locale
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              S.of(context).text,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: S.of(context).tooltip,
        child: Icon(Icons.add),
      ),
    );
  }
}
