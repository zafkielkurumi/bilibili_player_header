class Point {
  double x;
  double y;
  double angle;
  Point({this.x, this.y, this.angle});

  Point.formMap(map) {
     Point(x: map['x'], y: map['y'], angle: map['angle']);
  }
}