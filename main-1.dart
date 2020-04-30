import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Launcher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'URL Launcher'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _launched;
  String _phone = '01157686224';


  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "phono number",
          ),
          ),

        body: Center(
          child: Container(
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.phone,size: 50,),
                  onPressed: () => setState(() {
                    _launched = _makePhoneCall('tel:$_phone');
                  }),),

                Text('$_phone'
                  ,style: TextStyle(
                      fontSize: 50
                  ),


                )

              ],
            ),

          ),
        ),
      ),
    );
  }}