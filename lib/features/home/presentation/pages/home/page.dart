import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youapp_test/app/locator.dart';
import 'package:youapp_test/dialog/app_alert_dialog.dart';
import 'package:youapp_test/dialog/exit_dialog.dart';
import 'package:youapp_test/features/auth/auth.dart';
import 'package:youapp_test/features/home/home.dart';
import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/tool/skeleton_animation.dart';
import 'package:youapp_test/tool/time_helper.dart';
import 'package:youapp_test/widget/gradient_text.dart';

part 'sections/about_section.dart';
part 'sections/form_section.dart';
part 'sections/header_section.dart';
part 'sections/interest_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<bool> _onWillPop() async {
    bool exit = await openExitDialog(context) ?? false;
    if (exit) {
      setState(() {
        exit = true;
      });
    }
    return Future(() => exit);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.loading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state.status == AuthStatus.authorized) {
          EasyLoading.dismiss();
        } else if (state.status == AuthStatus.unAuthorized) {
          EasyLoading.showError(
              state.failure?.message ?? 'An unknown error occurred!');
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            backgroundColor: AppColors().hPrimary3,
            appBar: AppBar(
              backgroundColor: AppColors().hPrimary3,
              title: state.status != AuthStatus.loading
                  ? Text(
                      '@${state.user?.username ?? ''}',
                      style: AppTextStyle.bold(),
                    )
                  : const SkeletonAnimation(
                      width: 111,
                      height: 19,
                      radius: 0,
                    ),
              centerTitle: true,
              leading: BackLeading(onTap: _onWillPop),
              leadingWidth: 100,
              elevation: 0.0,
            ),
            floatingActionButton: CircleAvatar(
              backgroundColor: AppColors().hWhite,
              child: IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: AppColors().hPrimary3,
                ),
                onPressed: () => openAppAlertDialog(
                  context,
                  title: "Exit",
                  message: "Are you sure to logout?",
                  leftButtonText: "No",
                  rightButtonText: "Yes",
                  rightButtonColor: Colors.red,
                  onLeftButtonClick: (c) => Navigator.pop(c),
                  onRightButtonClick: (c) async {
                    await AuthLocalDataSourceImpl(getIt()).clearCache();
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginPage.routeName, (route) => false);
                  },
                ),
              ),
            ),
            body: ListView(
              children: [
                state.status != AuthStatus.loading
                    ? _HeaderSections(user: state.user!)
                    : const HeaderShimmer(),
                const SizedBox(height: 24),
                state.status != AuthStatus.loading
                    ? _About()
                    : const AboutShimmer(),
                const SizedBox(height: 18),
                state.status != AuthStatus.loading
                    ? _InterestSections(user: state.user!)
                    : const InterestShimmer(),
                const SizedBox(height: 18),
              ],
            ),
          ),
        );
      },
    );
  }
}
