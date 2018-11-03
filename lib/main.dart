import 'package:artifact_shop_phase/content.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

// Given an amount of gold your opponent used during the shopping phase and how many cards were added to their hand,
// display possible item combinations that sum up to the amount of gold
// used (Be aware the opponent can hold their secret shop item for a single gold coin)

// yea like a shop tool that shows all the possibilities your opponent could have done with his gold !

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => ThemeData(
              primarySwatch: Colors.blueGrey,
              fontFamily: 'Radiance',
              brightness: brightness,
            ),
        themedWidgetBuilder: (context, theme) {
          return new MaterialApp(
            title: 'Flutter Demo',
            theme: theme,
            home: MyHomePage(),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Content(),
    );
  }
}
