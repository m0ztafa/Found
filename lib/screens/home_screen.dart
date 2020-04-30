import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:found/screens/NotFound.dart';
import 'package:found/screens/Found.dart';
//import 'package:found/screens/onlineSearch.dart';

//import 'package:foundchildren/screens/form.dart';
//import 'package:foundchildren/screens/login.dart';
//import 'package:foundchildren/screens/search.dart';
//import 'package:foundchildren/screens/search2.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//..................AppBar.....................
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
//...................AppBar...................
    return WillPopScope(
      onWillPop: () {
        debugPrint("WillPopScope Button");
        Navigator.pop(context, false);
      },
      child: Scaffold(
        body: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              elevation: 5.0,
              title: Text(
                'found',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //Search Button
              actions: <Widget>
              [
                IconButton(
                  icon: Icon(Icons.search),
                  iconSize: 30.0,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pushNamed("/search");
                  },
                ),
              ],

              bottom: TabBar(
                tabs: [
                  Text("Found",style: TextStyle(fontSize: 18)),
                  Text("NOT Found",style: TextStyle(fontSize: 18),),
                  Text("online search",style: TextStyle(fontSize: 18),),
                ],
              ),
            ),
            body: Builder(
              builder: (BuildContext context) {
                return OfflineBuilder(
                  connectivityBuilder: (BuildContext context,
                      ConnectivityResult connectivity, Widget child) {
                    final bool connected =
                        connectivity != ConnectivityResult.none;
                    if(connectivity!=ConnectivityResult.none){
                      return TabBarView(children: [
                        FoundScreen(),
                        _Home(),
                        Container(),
                        //OnlineSearch(),
                         ],
                      );
                    }
                    else{
                      Widget wid=Stack(
                        fit: StackFit.expand,
                        children: [
                          child,
                          Positioned(
                            left: 0.0,
                            right: 0.0,
                            height: 35.0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              color: Colors.black26,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Offline",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  SizedBox(
                                    width: 12.0,
                                    height: 12.0,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      valueColor:
                                      AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                      return  TabBarView(children: <Widget>
                      [
                        wid,
                        wid,
                        wid
                      ],
                      );
                    }
                  },
                  child: Center(
                    child: Text("check your network "),
                  ),
                );
              },
            ),
            drawer: Drawer(
              elevation: 12,
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Icon(Icons.search),
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                  ),
                  ListTile(
                    title: Text('Sreach'),
                    onTap: () {
//                        Navigator.of(context)
//                            .push(MaterialPageRoute(builder: (context) => Sreach2()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('AddChildren'),
                    onTap: () {
//                        Navigator.of(context)
//                            .push(MaterialPageRoute(builder: (context) => StudentDetail()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('login'),
                    onTap: () {
//                        Navigator.of(context)
//                            .push(MaterialPageRoute(builder: (context) => login()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//................Body...................
class _Home extends StatelessWidget {
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
                children: <Widget>[NotFound()],
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

