import 'package:flutter/material.dart';
import 'package:advanced_splashscreen/advanced_splashscreen.dart';

void main(){

  runApp(MaterialApp(
    home: AdvancedSplashScreen(
      child: ExampleApp(),
      seconds: 2,
      colorList: [
        Color(0xff9bcebb),
        Color(0xff9bceff),
        Color(0xff9bcfff),
      ],
      appIcon: "images/flutter_social.png",
    ),
  ));
}

class ExampleApp extends StatefulWidget {

  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Flutter Social by ajax8732@gmail.com"),
        ),
      ),
    );
  }
}
