import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class Demo5 extends StatefulWidget {
  @override
  _Demo5State createState() => _Demo5State();
}

class _Demo5State extends State<Demo5> {
  double height = 500;

  getGestures() {
    final Map<Type, GestureRecognizerFactory> gestures =
        <Type, GestureRecognizerFactory>{};
    gestures[VerticalDragGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
            () => VerticalDragGestureRecognizer(debugOwner: this),
            (VerticalDragGestureRecognizer instance) {
      // instance.isFlingGesture(estimate)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GestureDetector(),
          Listener(
            
            // behavior: HitTestBehavior.translucent,
            // onVerticalDragUpdate: (DragUpdateDetails updateDetails) {
            //   // debugPrint(updateDetails.toString());
            //   height += updateDetails.delta.dy;
            //   setState(() {});
            // },
            // onVerticalDragEnd: (DragEndDetails endDetails) {
            //   print(endDetails.velocity);
            //   print('endDetails.velocity');
            //   print(endDetails.primaryVelocity);
            //   print('end');
            // },
            child: Container(
              height: height,
              color: Colors.red,
              child: ListView(
                children: List.filled(100, ListTile(title: Text('data'),)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
