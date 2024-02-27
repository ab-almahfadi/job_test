import 'package:flutter/material.dart';
import 'package:youapp_test/core/core.dart';

class TextHeaderAuth extends StatelessWidget {
  final String text;
  const TextHeaderAuth({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 41),
      child: Text(
        text,
        style: AppTextStyle.bold(fontSize: 24),
      ),
    );
  }
}
