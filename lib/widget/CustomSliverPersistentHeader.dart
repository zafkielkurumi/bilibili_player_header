import 'package:flutter/material.dart';

class CustomSliverPersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeigth;
  CustomSliverPersistentHeader(
      {@required this.child, this.maxHeight, @required this.minHeigth});


   @override
  double get maxExtent => maxHeight ?? minHeigth;

  @override
  double get minExtent => minHeigth;

    @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }
  
  @override
   bool shouldRebuild(CustomSliverPersistentHeader oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        maxHeight != oldDelegate.maxHeight ||
        child != oldDelegate.child;
  }
}
