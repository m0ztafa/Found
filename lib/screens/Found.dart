import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:found/screens/ChildInfo1.dart';

class FoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: <Widget>[_Found()],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(bottom: 30, right: 30),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/addchild");
              },
              tooltip: "Add Children",
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class _Found extends StatefulWidget {
  @override
  _FoundState createState() => _FoundState();
}

// ...............................
// .     all coming data here    .
// ...............................

class _FoundState extends State<_Found> {
  static String ip="192.168.1.7:5000";
  var url=Uri.http(ip,"/ChildFound");
  static List _Name = [];
  static List _description = [];
  static List _age = [];
  static List _image= [];
  static List _location=[];
  static List _phone =[];

  static int _len = 0;

  static Future<List> connect(dynamic url) async {
    http.Response response;
    response = await http.get(url);
    //print(response.body);

    int numOfChar = response.body.length;

    // Get Length

    // for getting length one time
    if (_len == 0) {
      for (int i = 0; i < numOfChar; i++) {
        if (response.body[i] == '}') {
          _len++;
          //print("the _len in found is $_len");
        }
      }

      //Set Fields
      for (int i = 0; i < _len; i++) {
        _Name.add(json.decode(response.body)[i]['name']);
        _description.add(json.decode(response.body)[i]['description']);
        _age.add(json.decode(response.body)[i]['age']);
        _image.add(json.decode(response.body)[i]['image']);
        _location.add(json.decode(response.body)[i]['location']);
        _phone.add(json.decode(response.body)[i]['phone']);
      }
    }
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    connect(url);
    if (_len == 0) {
      return Expanded(
        child: Container(
          child:CircularProgressIndicator(backgroundColor: Colors.red,),
//          child: IconButton(
//            icon: Icon(
//              Icons.refresh,
//              size: 30,
//            ),
//            onPressed: () {
//              setState(() {});
//            },
//          ),
          alignment: Alignment.center,
        ),
      );
    }
    else {
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: ListView.builder(
              itemCount: _len,
              itemBuilder: (BuildContext context, int index) {
                return FoundDesign(_Name[index], _description[index],_location[index],_phone[index],base64Decode(_image[index]));
              },
            ),
          ),
        ),
      );
    }
  }
}

// .............................
//  here design for coming data.
// .............................

class FoundDesign extends StatefulWidget {
  String _name;
  String _description;
  String _location;
  String _phone;
  Uint8List img;
  FoundDesign(this._name, this._description,this._location,this._phone,this.img);
  @override
  _FoundDesignState createState() =>
      _FoundDesignState(_name,_description,_location,_phone,img);
}

class _FoundDesignState extends State<FoundDesign> {
  String _name;
  String _description;
  String _location;
  String _phone;
  Uint8List img;
//  var imgFile;
  _FoundDesignState(this._name, this._description,this._location,this._phone,this.img);

  convertImage(){
//    var imgFile1=File('image.jpg');
    setState(() {
//      imgFile=imgFile1.writeAsBytes(img);
    });
  }

  @override
  Widget build(BuildContext context) {
    convertImage();
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChildInfo1(_name, _description,_location,_phone,img),
            ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Color(0xFFFFEFEE),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 35.0,
              backgroundImage:AssetImage("images\\messi 3.jpg"),
            ),
            SizedBox(width: 15.0),
            Text(
              _name,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

