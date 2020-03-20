import 'package:flutter/material.dart';
import 'dart:math' as math;
class RotateView extends StatefulWidget {
  final double size;
  RotateView({this.size});
  @override
  _RotateViewState createState() => _RotateViewState();
}

class _RotateViewState extends State<RotateView> with TickerProviderStateMixin {
  AnimationController _angleController;
  Animation<double> _angleAnimtion;
  @override
  void initState() {
    _angleController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _angleAnimtion = Tween<double>(begin: 0, end: math.pi * 2).animate(
      CurvedAnimation(curve: Curves.linear, parent: _angleController)
        ..addListener(() {})
        ..addStatusListener((AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            _angleController.repeat();
          }
        }),
    );
    _angleController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _angleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _angleAnimtion,
        builder: (_, child) {
          return Transform.rotate(
            angle: _angleAnimtion.value,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/1.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle),
            ),
          );
        });
  }
}
