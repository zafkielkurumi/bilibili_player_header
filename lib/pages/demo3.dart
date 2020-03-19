import 'package:bilibili_player_header/widget/Spermcloud/LonelyPlanet.dart';
import 'package:flutter/material.dart';

class Demo3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('孤单星球'),),
      body: Center(
        child: LonelyPlanet(),
      ),
    );
  }
}
