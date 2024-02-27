import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonAnimation extends StatelessWidget {
  /// A widget that displays a skeleton animation effect.
  ///
  /// The [backgroundColor] parameter is the color of the skeleton animation's background.
  ///
  /// The [baseColor] parameter is the base color of the shimmer effect.
  ///
  /// The [highlightColor] parameter is the highlight color of the shimmer effect.
  ///
  /// The [width] parameter is the width of the skeleton animation.
  ///
  /// The [height] parameter is the height of the skeleton animation.
  ///
  /// The [radius] parameter is the border radius of the skeleton animation.
  ///
  /// The [child] parameter is an optional child widget to display within the skeleton animation.
  const SkeletonAnimation({
    Key? key,
    this.backgroundColor,
    this.isLight = true,
    this.width,
    this.height,
    this.radius,
    this.child,
  }) : super(key: key);

  /// The color of the skeleton animation's background.
  final Color? backgroundColor;

  final bool isLight;

  /// The width of the skeleton animation.
  final double? width;

  /// The height of the skeleton animation.
  final double? height;

  /// The border radius of the skeleton animation.
  final double? radius;

  /// An optional child widget to display within the skeleton animation.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: isLight
          ? Colors.grey.withOpacity(.1)
          : Colors.grey.shade100,
      child: child ??
          Container(
            width: width ?? double.infinity,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor ??
                  Colors.grey.withOpacity(.5),
              borderRadius: BorderRadius.circular(radius ?? 4),
            ),
          ),
    );
  }
}
