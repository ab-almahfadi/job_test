import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:youapp_test/core/core.dart';

class ButtonAuth extends StatelessWidget {
  final Function()? onPressed;
  final bool loading;
  final String text;
  final Color textColor;
  final double height;
  final Gradient gradient;
  final double radius;
  final List<BoxShadow>? shadow;

  const ButtonAuth({
    Key? key,
    required this.onPressed,
    required this.loading,
    required this.text,
    required this.textColor,
    required this.height,
    required this.gradient,
    required this.radius,
    this.shadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: shadow,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: loading
            ? Center(
                child: SpinKitCircle(
                  color: textColor,
                  size: 20,
                ),
              )
            : Text(
                text,
                style: AppTextStyle.semiBold(
                  color: textColor,
                  fontSize: 14,
                ),
              ),
      ),
    );
  }
}
