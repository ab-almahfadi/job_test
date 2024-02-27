import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/tool/skeleton_animation.dart';

class InterestShimmer extends StatelessWidget {
  const InterestShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 27,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        color: AppColors().hCard2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Interest',
                style: AppTextStyle.bold(),
              ),
              SvgPicture.asset(
                MainAssets.editIcon,
                width: 17,
                height: 17,
              )
            ],
          ),
          const SizedBox(height: 33),
          const SkeletonAnimation(
            width: 275,
            height: 34,
            radius: 0,
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}