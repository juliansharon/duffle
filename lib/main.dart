import 'package:flutter/material.dart';
import 'package:duffle/pages/MyHomePage.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/services.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      home: SplashScreen.navigate(name: 'assets/duffle.flr', next: (context)=>MyHomePage(),
        until: () => Future.delayed(Duration(seconds: 1)),
        backgroundColor: Color(0xffF9FF26),
        startAnimation: 'start',
      )
    );
  }
}
