part of '../page.dart';

class _FormLoginSection extends StatefulWidget {
  @override
  State<_FormLoginSection> createState() => _FormLoginSectionState();
}

class _FormLoginSectionState extends State<_FormLoginSection> {
  late TextEditingController _cEmail;
  late TextEditingController _cUsername;
  late TextEditingController _cPassword;
  late bool _obscure;
  late GlobalKey<FormState> _formKey;
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
    _obscure = true;
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
                const SizedBox(height: 15),
                formField(
                  controller: _cUsername,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 17,
                    horizontal: 18,
                  ),
                  inputType: TextInputType.text,
                  hintText: 'Enter Username',
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
                const SizedBox(height: 15),
                formField(
                  controller: _cPassword,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 17,
                    horizontal: 18,
                  ),
                  inputType: TextInputType.text,
                  hintText: 'Enter Password',
                  inputFormatter: [RemoveEmojiInputFormatter()],
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
                ),
                const SizedBox(height: 25),
                ButtonAuth(
                  onPressed:
                      _cEmail.text.isNotEmpty && _cPassword.text.isNotEmpty
                          ? () {
                              if (!_isLoading) {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(LoginAuthEvent(
                                          params: LoginParams(
                                        email: _cEmail.text,
                                        username: _cUsername.text,
                                        password: _cPassword.text,
                                      )));
                                }
                              }
                            }
                          : null,
                  text: 'Login',
                  loading: _isLoading,
                  textColor:
                      _cEmail.text.isNotEmpty && _cPassword.text.isNotEmpty
                          ? Colors.white
                          : Colors.white.withOpacity(.3),
                  height: 48,
                  radius: 8,
                  gradient: LinearGradient(
                    colors: [
                      _cEmail.text.isNotEmpty && _cPassword.text.isNotEmpty
                          ? AppColors().hSecond1
                          : AppColors().hSecond1.withOpacity(.3),
                      _cEmail.text.isNotEmpty && _cPassword.text.isNotEmpty
                          ? AppColors().hSecond2
                          : AppColors().hSecond2.withOpacity(.3),
                    ],
                  ),
                  shadow: _cEmail.text.isNotEmpty && _cPassword.text.isNotEmpty
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

  @override
  void dispose() {
    _cEmail.dispose();
    _cUsername.dispose();
    _cPassword.dispose();
    super.dispose();
  }
}
