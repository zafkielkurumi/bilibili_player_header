
import 'package:bilibili_player_header/widget/ClickParticle.dart';
import 'package:flutter/material.dart';

class Demo2 extends StatefulWidget {
  @override
  _Demo2State createState() => _Demo2State();
}

class _Demo2State extends State<Demo2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: Text('点击粒子'),),
      body: Center(
        child: ClickParticle(
        child: Container(
          color: Colors.white,
          height: 50,
          width: 200,
          child: Text('按钮'),
        ),
      ),
      ),
    );
  }
}



