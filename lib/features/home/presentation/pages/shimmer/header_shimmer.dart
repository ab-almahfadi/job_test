import 'package:flutter/material.dart';
import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/tool/skeleton_animation.dart';

class HeaderShimmer extends StatelessWidget {
  const HeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 17,
      ),
      height: 190,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: AppColors().hCard,
      ),
      child: const Align(
        alignment: Alignment.bottomLeft,
        child: SkeletonAnimation(
          width: 111,
          height: 19,
          radius: 0,
        ),
      ),
    );
  }
}