import 'package:flutter/material.dart';
import 'package:youapp_test/core/core.dart';

class AppAlertDialog extends StatefulWidget {
  final String title;
  final String message;
  final String? leftButtonText;
  final String rightButtonText;
  final Color? rightButtonColor;
  final Function(BuildContext context)? onLeftButtonClick;
  final Function(BuildContext context) onRightButtonClick;

  const AppAlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.leftButtonText,
    this.rightButtonColor,
    this.onLeftButtonClick,
    required this.rightButtonText,
    required this.onRightButtonClick,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AppAlertDialogState createState() => _AppAlertDialogState();
}

class _AppAlertDialogState extends State<AppAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        widget.title,
        style: const TextStyle(fontSize: 16.0),
      ),
      content: Text(widget.message, style: const TextStyle(fontSize: 14.0)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      actions: <Widget>[
        if (widget.leftButtonText != null)
          MaterialButton(
            child: Text(
              widget.leftButtonText!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            onPressed: () => widget.onLeftButtonClick!(context),
          ),
        MaterialButton(
          child: Text(
            widget.rightButtonText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: widget.rightButtonColor ?? AppColors().hSecond1,
            ),
          ),
          onPressed: () => widget.onRightButtonClick(context),
        ),
      ],
    );
  }
}

Future openAppAlertDialog(
    BuildContext context, {
      required String title,
      required String message,
      String? leftButtonText,
      Color? rightButtonColor,
      Function(BuildContext context)? onLeftButtonClick,
      required String rightButtonText,
      required Function(BuildContext context) onRightButtonClick,
      bool dismissible = true,
    }) {
  return showGeneralDialog(
    barrierLabel: "App Alert Dialog",
    barrierDismissible: dismissible,
    barrierColor: Colors.black.withOpacity(0.5),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Theme(
        data: defaultTheme(context),
        child: AppAlertDialog(
          title: title,
          message: message,
          leftButtonText: leftButtonText,
          rightButtonColor: rightButtonColor,
          onLeftButtonClick: onLeftButtonClick,
          rightButtonText: rightButtonText,
          onRightButtonClick: onRightButtonClick,
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, anim1, anim2, child) {
      return Transform.scale(
        scale: anim1.value,
        child: child,
      );
    },
  );
}

