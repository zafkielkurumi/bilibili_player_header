import 'package:bilibili_player_header/widget/Spermcloud/BeatMelody.dart';
import 'package:flutter/material.dart';
class Demo4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('跳动旋律'),),
      body: Center(
        child: BeatMelody(),
      ),
    );
  }
}