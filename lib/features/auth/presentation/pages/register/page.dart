import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:remove_emoji_input_formatter/remove_emoji_input_formatter.dart';
import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/features/auth/auth.dart';

part 'sections/form_section.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static const String routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state){
        if(state.status == AuthStatus.loading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state.status == AuthStatus.success) {
          EasyLoading.dismiss();
          // Route ke Home Page
          EasyLoading.showToast('Success register!');

        } else if (state.status == AuthStatus.failure) {
          EasyLoading.showError(state.failure?.message ?? 'An unknown error occurred!');
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [AppColors().hPrimary1, AppColors().hPrimary2, AppColors().hPrimary3],
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
                const TextHeaderAuth(text: 'Register'),
                const SizedBox(height: 25),
                _FormSection(),
                const SizedBox(height: 46),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an account? ',
                      style:
                      AppTextStyle.medium(fontSize: 13, color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        MainAssets.login,
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
