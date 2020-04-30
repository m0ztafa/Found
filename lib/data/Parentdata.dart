import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart'as http;

class ParentsData extends StatefulWidget {
  String _location;
  String _phone;
  ParentsData(this._location,this._phone);
  @override
  _ParentsData createState() => _ParentsData(_location,_phone);
}

class _ParentsData extends State<ParentsData> {

  // person who found child has location and phone
  String _location="";
  String _phone="";

  // parent data
  String _pName="";
  String _pID="";
  String _pAddress="";

  Future<File> file;

  _ParentsData(this._location,this._phone);
  sendParent(String name,String id, String address) async {
    {
      String _ip="192.168.1.7:5000";
      var url=Uri.http(_ip,"/sendParent");
      String url2="?name=$name&id=$id&address=$address";
      http.Response response;
      response = await http.get(url.toString()+url2);
//      print(response);
    }
  }

  imageCamera() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.camera);
    });
  }

  imageGallery() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      // APP BAR
      appBar: AppBar(
        elevation: 10.0,
        title: Text(
          'found',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // BODY
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              "your Info",
              style: TextStyle(
                fontSize: 40,
                color: Colors.red,
              ),
            ),
          ),

          // ............Name..............
          Padding(
            padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: TextField(
              style: textStyle,
              decoration: InputDecoration(
                labelText: " Name :",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _pName=value;
                });
              },
            ),
          ),


          //...............ID Number.............
          Padding(
            padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: TextField(
              style: textStyle,
              decoration: InputDecoration(
                labelText: " ID Number :",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onChanged: (value) {
                _pID=value;
              },
            ),
          ),


          //................Address............

          Padding(
            padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: TextField(
              style: textStyle,
              decoration: InputDecoration(
                labelText: " address :",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onChanged: (value) {
                _pAddress=value;
              },
            ),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
//              // ................Id photo.............
//              Row(
//                children: <Widget>[
//                  Padding(
//                    padding: EdgeInsets.only(top: 30.0, bottom: 30.0, left: 30),
//                    child: Text(
//                      "  Id photo",
//                      style: TextStyle(
//                        fontSize: 20,
//                        fontWeight: FontWeight.w600,
//                      ),
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(left: 30),
//                    child: IconButton(
//                      iconSize: 30,
//                      icon: Icon(
//                        Icons.camera_enhance,
//                      ),
//                      onPressed: () {
//                        imageCamera();
//                      },
//                    ),
//                  )
//                ],
//              ),
//

              //............send parent data to server .......
              Padding(
                padding: EdgeInsets.only(right: 30),
                child: RaisedButton(
                  child: Text(
                    "Send",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                  onPressed: () {
                    sendParent(_pName,_pID,_pAddress);
                    // send id photo please don't forget code it
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => TheWayToChild(_location,_phone)),
                    );
                  },
                  color: Colors.redAccent,
                  colorBrightness: Brightness.dark,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class TheWayToChild extends StatefulWidget {
  String _location;
  String _phone;
  TheWayToChild(this._location,this._phone);
  @override
  _TheWayToChildState createState() => _TheWayToChildState(_location,_phone);
}

class _TheWayToChildState extends State<TheWayToChild> {

  Future<void> _launched;
  String _phone ;
  String _location;

  _TheWayToChildState(this._location,this._phone);

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        title: Text(
          'found',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(children: <Widget>[
        Image.asset('images\\messi 3.jpg'),
        Container(
          child: Text('Location is $_location'),
        ),
        IconButton(
          icon: Icon(Icons.phone,size: 50,),
          onPressed: () => setState(() {
            _launched = _makePhoneCall('tel:$_phone');
          }),),
      ],)

    );
  }
}
