import 'package:bilibili_player_header/pages/demo1.dart';
import 'package:bilibili_player_header/pages/demo2.dart';
import 'package:bilibili_player_header/pages/demo4.dart';
import 'package:bilibili_player_header/pages/demo6.dart';
import 'package:bilibili_player_header/pages/demo7.dart';
import 'package:bilibili_player_header/widget/rippleRoute.dart';
import 'package:flutter/material.dart';

import 'pages/demo3.dart';
import 'pages/demo5.dart';
// import 'package:bilibili_player_header/widget/rippleRoute.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        pageTransitionsTheme:  const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return FloatingActionButton(onPressed: () {
          Navigator.of(context).push(RippleRoute.fromContext(context, Demo6()));
        });
      }),
      body: ListView(
        children: <Widget>[
          ListTile(
              title: Text('B站播放器效果'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Demo1()));
              },
            ),
          Builder(builder: (BuildContext context) {
            return ListTile(
              title: Text('扩散波纹路由动画'),
              onTap: () {
                Navigator.of(context)
                    .push(RippleRoute.fromContext(context, Demo6()));
              },
            );
          }),
          RipperContainer(
            widget: Demo6(),
            child: ListTile(
              title: Text('扩散波纹路由动画2'),
            ),
          ),
          ListTile(
            title: Text('点击粒子'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Demo2()));
            },
          ),
          ListTile(
            title: Text(
              '孤单星球3',
            ),
            onTap: () {
              Navigator.of(context)
                  .push(RippleRoute.fromContext(context, Demo3()));
            },
          ),
          ListTile(
            title: Text('跳动旋律'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Demo4()));
            },
          ),
          ListTile(
            title: Text('demo5'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Demo5()));
            },
          ),
          ListTile(
            title: Text('demo7下拉'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Demo7()));
            },
          ),
        ],
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
