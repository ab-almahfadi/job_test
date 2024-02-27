import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:remove_emoji_input_formatter/remove_emoji_input_formatter.dart';
import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/features/auth/auth.dart';
import 'package:youapp_test/features/home/home.dart';

part 'sections/form_section.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.loading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state.status == AuthStatus.authorized) {
          context.read<AuthBloc>().add(ProfileAuthEvent());
          EasyLoading.dismiss();
          // Route ke Home Page
          Navigator.pushNamedAndRemoveUntil(
              context, HomePage.routeName, (route) => false);
        } else if (state.status == AuthStatus.unAuthorized) {
          EasyLoading.showError(
              state.failure?.message ?? 'An unknown error occurred!');
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  AppColors().hPrimary1,
                  AppColors().hPrimary2,
                  AppColors().hPrimary3
                ],
                radius: 2,
                center: Alignment.topRight,
                focal: Alignment.topRight,
                focalRadius: 0.25,
              ),
            ),
            child: ListView(
              children: [
                const SizedBox(height: 37),
                const BackAuth(),
                const SizedBox(height: 60),
                const TextHeaderAuth(text: 'Login'),
                const SizedBox(height: 25),
                _FormLoginSection(),
                const SizedBox(height: 52),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No account? ',
                      style: AppTextStyle.medium(
                          fontSize: 13, color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Route ke Register Page
                        Navigator.pushNamed(context, RegisterPage.routeName);
                      },
                      child: Image.asset(
                        MainAssets.register,
                        height: 11,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
