part of '../page.dart';

class _FormSection extends StatefulWidget {
  @override
  State<_FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<_FormSection> {
  late TextEditingController _cEmail;
  late TextEditingController _cUsername;
  late TextEditingController _cPassword;
  late TextEditingController _cConfirmPassword;
  late bool _obscure;
  late bool _cObscure;
  late GlobalKey<FormState> _formKey;
  String? _password;
  late bool _isLoading;
  late AuthBloc _authBloc;

  @override
  void initState() {
    _cEmail = TextEditingController();
    _cEmail.addListener(() {
      setState(() {
        _cEmail.text.isNotEmpty;
      });
    });
    _cUsername = TextEditingController();
    _cUsername.addListener(() {
      setState(() {
        _cUsername.text.isNotEmpty;
      });
    });
    _cPassword = TextEditingController();
    _cPassword.addListener(() {
      setState(() {
        _cPassword.text.isNotEmpty;
      });
    });
    _cConfirmPassword = TextEditingController();
    _cConfirmPassword.addListener(() {
      setState(() {
        _cConfirmPassword.text.isNotEmpty;
      });
    });
    _obscure = true;
    _cObscure = true;
    _formKey = GlobalKey();
    _isLoading = false;
    _authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: _authBloc,
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                formField(
                  controller: _cEmail,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 17,
                    horizontal: 18,
                  ),
                  inputType: TextInputType.emailAddress,
                  hintText: 'Enter Email',
                  inputFormatter: [RemoveEmojiInputFormatter()],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 11),
                formField(
                  controller: _cUsername,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 17,
                    horizontal: 18,
                  ),
                  inputType: TextInputType.text,
                  hintText: 'Create Username',
                  inputFormatter: [RemoveEmojiInputFormatter()],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    if (value.trim().length < 4) {
                      return 'Username must be at least 4 characters in length';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 11),
                formField(
                  controller: _cPassword,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 17,
                    horizontal: 18,
                  ),
                  inputType: TextInputType.text,
                  inputFormatter: [RemoveEmojiInputFormatter()],
                  hintText: 'Create Password',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    if (value.trim().length < 8) {
                      return 'Password must be at least 8 characters in length';
                    }
                    return null;
                  },
                  obscure: _obscure,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColors().hGolden.last,
                      size: 20,
                    ),
                  ),
                  onChanged: (value) => _password = value,
                ),
                const SizedBox(height: 11),
                formField(
                  controller: _cConfirmPassword,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 17,
                    horizontal: 18,
                  ),
                  inputType: TextInputType.text,
                  hintText: 'Confirm Password',
                  inputFormatter: [RemoveEmojiInputFormatter()],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }

                    if (value != _password) {
                      return 'Confimation password does not match the entered password';
                    }

                    return null;
                  },
                  obscure: _cObscure,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _cObscure = !_cObscure;
                      });
                    },
                    icon: Icon(
                      _cObscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColors().hGolden.last,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                ButtonAuth(
                  onPressed: _cEmail.text.isNotEmpty &&
                          _cUsername.text.isNotEmpty &&
                          _cPassword.text.isNotEmpty &&
                          _cConfirmPassword.text.isNotEmpty
                      ? () {
                          if (!_isLoading) {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(RegisterAuthEvent(
                                      params: RegisterParams(
                                    email: _cEmail.text,
                                    username: _cUsername.text,
                                    password: _cPassword.text,
                                  )));
                              _cEmail.clear();
                              _cUsername.clear();
                              _cPassword.clear();
                              _cConfirmPassword.clear();
                            }
                          }
                        }
                      : null,
                  text: 'Register',
                  loading: _isLoading,
                  textColor: _cEmail.text.isNotEmpty &&
                          _cUsername.text.isNotEmpty &&
                          _cPassword.text.isNotEmpty &&
                          _cConfirmPassword.text.isNotEmpty
                      ? Colors.white
                      : Colors.white.withOpacity(.3),
                  height: 48,
                  radius: 8,
                  gradient: LinearGradient(
                    colors: [
                      _cEmail.text.isNotEmpty &&
                              _cUsername.text.isNotEmpty &&
                              _cPassword.text.isNotEmpty &&
                              _cConfirmPassword.text.isNotEmpty
                          ? AppColors().hSecond1
                          : AppColors().hSecond1.withOpacity(.3),
                      _cEmail.text.isNotEmpty &&
                              _cUsername.text.isNotEmpty &&
                              _cPassword.text.isNotEmpty &&
                              _cConfirmPassword.text.isNotEmpty
                          ? AppColors().hSecond2
                          : AppColors().hSecond2.withOpacity(.3),
                    ],
                  ),
                  shadow: _cEmail.text.isNotEmpty &&
                          _cUsername.text.isNotEmpty &&
                          _cPassword.text.isNotEmpty &&
                          _cConfirmPassword.text.isNotEmpty
                      ? [
                          BoxShadow(
                            offset: const Offset(0, 10),
                            color: AppColors().hSecond1.withOpacity(.5),
                            blurRadius: 18.0,
                          ),
                          BoxShadow(
                            offset: const Offset(0, 10),
                            color: AppColors().hSecond2.withOpacity(.5),
                            blurRadius: 18.0,
                          ),
                        ]
                      : [],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
