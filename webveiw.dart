import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
void main() => runApp(WebviewDemo());

class WebviewDemo extends StatefulWidget {
  @override
  _WebviewDemoState createState() => _WebviewDemoState();
}



class _WebviewDemoState extends State<WebviewDemo> {
  String search ="https%3A%2F%2Fwww.bing.com%2Frs%2F3P%2Fk5%2Fic%2FjDa30LF7gwGTZzTjhxnXrsluokg.jpg";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home:
      DefaultTabController(
        length: 3,
        child: Scaffold(


          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('Tabs Demo'),
          ),




          body: TabBarView(
            children: [
              Scaffold(
                body: Builder(builder: (BuildContext context){
                  return WebView(
                    initialUrl: 'https://www.google.com/searchbyimage?image_url='+search,
                    javascriptMode: JavascriptMode.unrestricted,
                  );
                }),
              ),

              Scaffold(
                body: Builder(builder: (BuildContext context){
                  return WebView(


                    initialUrl: 'https://www.bing.com/images/search?view=detailv2&iss=sbi&form=SBIHMP&q=imgurl:'+search+'&idpbck=1&selectedindex=0&id='+search+'&ccid=TpYbjbUv&mediaurl='+search+'&exph=800&expw=533&vt=2&sim=11',
                    javascriptMode: JavascriptMode.unrestricted,
                  );
                }),
              ),
              Scaffold(
                body: Builder(builder: (BuildContext context){
                  return WebView(
                    initialUrl: 'https://yandex.com/images/search?source=collections&&url='+search+'&rpt=imageview',
                    javascriptMode: JavascriptMode.unrestricted,
                  );
                }),
              ),
            ],
          ),
        ),
      ),);

  }
}
