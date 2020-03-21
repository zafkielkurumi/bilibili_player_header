import 'dart:async';

import 'package:bilibili_player_header/util/pointHelper.dart';
import 'package:bilibili_player_header/widget/Spermcloud/rotateView.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BeatMelody extends StatelessWidget {
  final double size = 200;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        
        Transform.rotate(angle: -math.pi/ 10, child: BeatPaint(size: size),),
        RotateView(
          size: size,
        ),
      ],
    );
  }
}

class BeatPaint extends StatefulWidget {
  const BeatPaint({
    Key key,
    @required this.size,
  }) : super(key: key);

  final double size;

  @override
  _BeatPaintState createState() => _BeatPaintState();
}

class _BeatPaintState extends State<BeatPaint> with TickerProviderStateMixin {
  double get r1 => widget.size / 2;
  AnimationController _animationController;

  /// 贝塞尔曲线画圆。分成n等分进行
  int n = 16;

  /// 网易云的跳动旋律的圆大约3-4条左右
  List<Path> paths = [];
  DateTime _preTime = DateTime.now();
  DateTime _now = DateTime.now();
  Timer _timer;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 200));
    Tween(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuart)
        ..addListener(() {
            updatePaths();
          setState(() {});
        })
        ..addStatusListener((AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            _animationController.repeat();
          }
        }),
    );
    _animationController.forward();
    // _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
    //     updatePaths();
    //     setState(() {});
    // });
    super.initState();
  }

  /// 根据等分得到圆上的点，这些点组合成多个贝塞尔曲线的起始点
  /// 排序后第一个点为圆的右下
  initPoint() {
    var r = r1 + 10;
    var angles = List.generate(n, (index) {
      return math.pi * 2 * (index + 1) / n;
    });
    angles.sort();
    return angles.map((angle) {
      return PointHelper.getPoint(r1: r1, r: r, angle: angle);
    }).toList();
  }

  /// 根据起始点生成贝塞尔曲线
  Path randomPath() {
    Path path = Path();
    List points = initPoint();
    var first = points.first;
    path.moveTo(first.x, first.y);

    for (var i = 0; i < points.length; i++) {
      var point = points[i];
      var nextPoint;
      if (i == points.length - 1) {
        nextPoint = points.first;
      } else {
        nextPoint = points[i + 1];
      }
      updateNextPoint(nextPoint, i);
      var control = PointHelper.getCubicControlPoint(
          x: r1,
          y: r1,
          radians: 2 * math.pi / n,
          x0: point.x,
          y0: point.y,
          x3: nextPoint.x,
          y3: nextPoint.y);
      path.cubicTo(control['x1'], control['y1'], control['x2'], control['y2'],
          nextPoint.x, nextPoint.y);
    }

    return path;
  }
    /// n4|1,  n 8|3  n 16|7
    /// 有部分的变化频繁，变化大，
  updateNextPoint(nextPoint, int i) {

    if (i > (n / 2 - 2) && i < math.Random().nextInt((n * 3 / 4 - 2).toInt()) +1) {
       double distX = (math.Random().nextDouble() + 0.1)* 15;
    double distY = (math.Random().nextDouble() + 0.1)* 15;
      if (nextPoint.x > r1) {
        nextPoint.x += distX;
      } else {
        nextPoint.x -= distX;
      }
      if (nextPoint.y < r1) {
        nextPoint.y -= distY;
      } else {
        nextPoint.y += distY;
      }
    } else {
      ///    变化的不大的部分添加间隔
        Duration inteval = Duration(milliseconds: math.Random().nextInt(300) + 500);
      if (_now.difference(_preTime) > inteval && i != n - 1) {
        bool b = math.Random().nextDouble() > 0.9 ? true :false;
        double distx = math.Random().nextDouble() * 10;
        double disty = math.Random().nextDouble() * 10;
        if (nextPoint.x > r1) {
          nextPoint.x += b ? distx : 0;
        } else {
          nextPoint.x -= b ? distx : 0;
        }
        if (nextPoint.y < r1) {
          nextPoint.y -= b ? disty : 0;
        } else {
          nextPoint.y += b ? disty : 0;
        }
      }
      
    }
  }

  updatePaths() {
    _now = DateTime.now();
    paths = List.generate(3, (index) {
      return randomPath();
    });
    if (_now.difference(_preTime) > Duration(milliseconds: 800)) {
      _preTime = _now;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size(widget.size, widget.size),
        painter: Beatainter(
          paths: paths,
        ),
      );
  }
}

class Beatainter extends CustomPainter {
  final List<Path> paths;
  final double r;
  final Paint _paint;
  final List<Color> colors = [
    Colors.blue,
    Colors.pink,
    Colors.red,
  ];
  Beatainter({this.paths, this.r = 120})
      : _paint = Paint()..style=PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < paths.length; i++) {
      var path = paths[i];
      var color = colors[i];
      if (i == paths.length - 1) {
        _paint..strokeWidth = 2;
      } else {
        _paint..strokeWidth = 1;
      }
      canvas.drawPath(path, _paint..color = color);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
