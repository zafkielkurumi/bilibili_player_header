import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:ui';

class RouteConfig {
  Offset orgin;
  double circleRadius;
  RouteConfig.formOrigin(this.orgin) {
    Size size = MediaQueryData.fromWindow(window).size;
    double topLeft = sqrt(pow(orgin.dx, 2) + pow(orgin.dy, 2));
    double topRight = sqrt(pow(orgin.dx - size.width, 2) + pow(orgin.dy, 2));
    double bottomLeft = sqrt(pow(orgin.dx, 2) + pow(orgin.dy - size.height, 2));
    double bottomRight =
        sqrt(pow(orgin.dx - size.width, 2) + pow(orgin.dy - size.height, 2));
    circleRadius = ([topLeft, topRight, bottomLeft, bottomRight]..sort()).last;
  }
  RouteConfig.fromContext(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject();
    orgin = renderBox.localToGlobal(renderBox.size.center(Offset.zero));
    Size size = MediaQuery.of(context).size;
    double topLeft = sqrt(pow(orgin.dx, 2) + pow(orgin.dy, 2));
    double topRight = sqrt(pow(orgin.dx - size.width, 2) + pow(orgin.dy, 2));
    double bottomLeft = sqrt(pow(orgin.dx, 2) + pow(orgin.dy - size.height, 2));
    double bottomRight =
        sqrt(pow(orgin.dx - size.width, 2) + pow(orgin.dy - size.height, 2));
    circleRadius = ([topLeft, topRight, bottomLeft, bottomRight]..sort()).last;
  }
}

class CircleClipper extends CustomClipper<Rect> {
  final Offset orgin;
  final double circleRaidus;
  CircleClipper({@required this.circleRaidus, @required this.orgin});
  @override
  getClip(Size size) {
    Rect rect = Rect.fromCircle(center: orgin, radius: circleRaidus);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class RippleRoute extends PageRouteBuilder {
  RippleRoute(Widget widget, Offset origin)
      : super(
            pageBuilder: (BuildContext _context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: Duration(milliseconds: 500),
            transitionsBuilder: (
              BuildContext _context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              RouteConfig routeConfig = RouteConfig.formOrigin(origin);
              return ClipOval(
                clipper: CircleClipper(
                    orgin: routeConfig.orgin,
                    circleRaidus: routeConfig.circleRadius * animation.value),
                child: child,
              );
            });
  RippleRoute.fromContext(BuildContext context, Widget widget)
      : super(
            pageBuilder: (BuildContext _context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: Duration(milliseconds: 500),
            transitionsBuilder: (
              BuildContext _context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              RouteConfig routeConfig = RouteConfig.fromContext(context);
              return ClipOval(
                clipper: CircleClipper(
                    orgin: routeConfig.orgin,
                    circleRaidus: routeConfig.circleRadius * animation.value),
                child: child,
              );
            });
}

class RipperContainer extends StatelessWidget {
  final Widget widget;
  final Widget child;
  RipperContainer({this.child, this.widget});
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent downEvent) {
        print(downEvent.localPosition);
        Offset origin = (context.findRenderObject() as RenderBox)
            .localToGlobal(downEvent.localPosition);
        Navigator.of(context).push(RippleRoute(widget, origin));
      },
      child: child,
    );
  }
}
