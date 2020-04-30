import 'package:flutter/material.dart';
import 'package:found/data/addchild.dart';
import 'package:found/screens/home_screen.dart';
import 'screens/search.dart';
import 'package:found/screens/splash_sreen.dart';


var routes = <String, WidgetBuilder>{
  "/search": (BuildContext context) => Sreach(),
  "/HomeScreen":(BuildContext context)=>HomeScreen(),
  "/addchild":(BuildContext context)=>AddChild(),
  "/SomeOneInfo":(BuildContext context)=>SomeOneInfo(),
//  "/ParentData":(BuildContext context)=>ParentsData(),
//  "/login":(BuildContext context)=>login(),
};

void main() => runApp(MaterialApp(home:MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Found',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.red,
          accentColor: Color(0xFFFEF9EB),
        ),
        home:SplashScreen(),
        routes: routes
    );
  }
}
