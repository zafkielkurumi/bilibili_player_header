import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class Demo7 extends StatefulWidget {
  @override
  _Demo7State createState() => _Demo7State();
}

class _Demo7State extends State<Demo7> {
  CrossFadeState crossFadeState = CrossFadeState.showFirst;

  calc() {
    
    List list = List.filled(20, 'data${math.Random().nextBool()}');
    String str = list.reduce((value, element) => value + element);
    print(str);
    double width = MediaQueryData.fromWindow(ui.window).size.width;
    double w = list.length * 10 + str.length * 18.0;
    print(w > 3 *width);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('下拉1'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          crossFadeState = CrossFadeState.showFirst == crossFadeState
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst;
            calc();
          setState(() {});
        },
      ),
      body: Column(
        children: <Widget>[
          AnimatedCrossFade(
            firstChild: Wrap(
              spacing: 10,
              children: List.filled(18, Text('data')),
            ),
            secondChild: Wrap(
              spacing: 10,
              children: List.filled(20, Text('data')),
            ),
            duration: Duration(milliseconds: 500),
            crossFadeState: crossFadeState,
          ),
          CircleAvatar(
            child: Image.network('src'),
          ),
          RichText(text: WidgetSpan(child: null))
        ],
      ),
    );
  }
}
