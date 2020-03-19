import 'package:bilibili_player_header/model/ball.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class Shimmer extends StatefulWidget {
  final Widget child;
  final Color color;
  Shimmer({this.child, this.color: Colors.red});
  @override
  _ShimmerState createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with TickerProviderStateMixin {
  AnimationController _scaleController;
  Animation<double> _scaleAnimation;
  AnimationController _ballController;
  Animation<double> _ballAnimation;
  bool isDown = false;
  List<Ball> balls = [];
  @override
  void initState() {
    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..value = 1;
    _ballController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1).animate(
        CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut));
    // cubic-bezier(0.42, 0, 0.62, 1.01)
    _ballAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(curve: Curves.easeInOut, parent: _ballController)
        ..addListener(() {
          updateBalls();
          setState(() {});
        })
        ..addStatusListener((AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            balls = [];
            setState(() {});
          }
        }),
    );
    super.initState();
  }

  updateBalls() {
    balls.forEach((ball) {
      ball.x += ball.vX;
      ball.vX += ball.aX;
      ball.y += ball.vY;
      ball.vY += ball.aY;
      ball.r -= 0.1;
    });
  }

  initBalls() {
    double width  = context.size.width;
    double height  = context.size.height;
    var horizontalMax = width ~/ 20;
    var verticalMax = height ~/ 20;
    var topBalls = List.generate(horizontalMax, (index) {
      return Ball(
        x: (0 + index * 20).toDouble(),
        y: 5,
        r: 5 * math.Random().nextDouble(),
        vX: math.Random().nextDouble() - 0.5,
        vY: -math.Random().nextDouble() * 1.5,
        style: math.Random().nextBool() ? PaintingStyle.stroke : PaintingStyle.fill
      );
    });
    var bottmBalls = List.generate(horizontalMax, (index) {
      return Ball(
        x: (0 + index * 20).toDouble(),
        y: height - 5,
        r: 5 * math.Random().nextDouble(),
        vX: math.Random().nextDouble() - 0.5,
        vY: math.Random().nextDouble() * 1.5,
        style: math.Random().nextBool() ? PaintingStyle.stroke : PaintingStyle.fill
      );
    });
    var leftBalls = List.generate(verticalMax, (index) {
      return Ball(
        x: 5,
        y: (0 + index * 20).toDouble(),
        r: 5 * math.Random().nextDouble(),
        vX: -math.Random().nextDouble(),
        vY: -math.Random().nextDouble() + 0.5,
        style: math.Random().nextBool() ? PaintingStyle.stroke : PaintingStyle.fill
      );
    });
    var rightBalls = List.generate(verticalMax, (index) {
      return Ball(
        x: width - 5,
        y: (0 + index * 20).toDouble(),
        r: 5 * math.Random().nextDouble(),
        vX: math.Random().nextDouble(),
        vY: -math.Random().nextDouble() + 0.5,
        style: math.Random().nextBool() ? PaintingStyle.stroke : PaintingStyle.fill
      );
    });
    balls = [...topBalls, ...bottmBalls, ...rightBalls, ...leftBalls];
    _ballController.value = 0;
    _ballController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _ballController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _scaleController.value = 0;
        initBalls();
      },
      onTapUp: (TapUpDetails upDetails) {
        Future.delayed(Duration(milliseconds: 100)).then((d) {
          _scaleController.forward();
        });
      },
      child: Stack(
        children: <Widget>[
          CustomPaint(
            painter: CiclePainter(balls: balls),
          ),
          AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (_, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: widget.child,
                );
              })
        ],
      ),
    );
  }
}




// Paint
//  color: 画笔颜色
//  strokeWIdth:线的宽度
//  style 填充模式

class CiclePainter extends CustomPainter {
  final List<Ball> balls;
  CiclePainter({this.balls});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    balls.forEach((ball) {
      canvas.drawCircle(Offset(ball.x, ball.y), ball.r, paint..style=ball.style);
    });
    // canvas.drawCircle(Offset(0, 0), 3, paint);
    // canvas.drawCircle(Offset(-5, 0), 3, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

