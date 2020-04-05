
import 'package:flutter/material.dart';

class DragInfo {
  DragInfo(this.downEvent);
  PointerDownEvent downEvent;

  calcVertical(PointerMoveEvent moveEvent) {}
  calcHorizontal(PointerMoveEvent moveEvent) {}
}

class Demo5 extends StatefulWidget {
  @override
  _Demo5State createState() => _Demo5State();
}

class _Demo5State extends State<Demo5> {
  DragInfo _dragInfo;
  double offsetY = 300;
  bool canScroll = true;
  ScrollController _sc = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Stack(
        // fit: StackFit.expand,
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Positioned(
              top: 0,
              child: Container(
                height: 300,
                child: GestureDetector(
                  onTap: () {
                    print('tag');
                  },
                  onHorizontalDragUpdate: (DragUpdateDetails updateDetails) {
                    print('ipdate');
                  },
                  child: Image.asset(
                    'assets/images/1.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          Listener(
            onPointerDown: (PointerDownEvent downEvent) {
              _dragInfo = DragInfo(downEvent);
            },
            onPointerMove: (PointerMoveEvent moveEvent) {
              offsetY -= moveEvent.delta.dy;
              offsetY  = offsetY >= 600 ? 600 : offsetY;
              if (offsetY < 600) {
                _sc.jumpTo(0);
              }
              setState(() {
               
              });
            },
            child: Container(
              height: offsetY,
              color: Colors.red,
              child: ListView(
                controller: _sc,
                children: List.generate(50, (index) {
                  return ListTile(
                    title: Text('$index'),
                  );
                }),
              ),
            ),
          )

        ],
      ),
      ),
    );
  }
}
