import 'package:flutter/material.dart';
import 'package:youapp_test/core/core.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(32.0),
                width: MediaQuery.of(context).size.width,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Are you sure to Exit?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2.0,
                height: 2.0,
                color: Colors.grey.shade300,
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: const Center(
                            child: Text(
                              "No",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        onTap: () => Navigator.pop(context, false),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2.0,
                      color: Colors.grey.shade300,
                    ),
                    Expanded(
                      child: InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors().hSecond2,
                              ),
                            ),
                          ),
                        ),
                        onTap: () => Navigator.pop(context, true),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future openExitDialog(BuildContext context) {
  return showGeneralDialog(
    barrierLabel: "Exit Dialog Dialog",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return const ExitDialog();
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
