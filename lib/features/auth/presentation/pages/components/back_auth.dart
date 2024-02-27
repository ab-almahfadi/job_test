import 'package:flutter/material.dart';
import 'package:youapp_test/core/core.dart';

class BackAuth extends StatelessWidget {
  const BackAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            Icon(
              Icons.chevron_left,
              size: 25,
              color: AppColors().hWhite,
            ),
            Text('Back', style: AppTextStyle.bold())
          ],
        ),
      ),
    );
  }
}
