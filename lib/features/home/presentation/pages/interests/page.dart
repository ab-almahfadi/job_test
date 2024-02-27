import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:youapp_test/core/core.dart';
import 'package:youapp_test/features/auth/auth.dart';
import 'package:youapp_test/features/home/home.dart';
import 'package:youapp_test/tool/skeleton_animation.dart';
import 'package:youapp_test/widget/gradient_text.dart';

class Interest extends StatelessWidget {
  const Interest({super.key});

  static const String routeName = '/interest';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return InterestPage(
        name: state.user!.name!,
        birthday: state.user!.birthday!,
        height: state.user!.height!,
        weight: state.user!.weight!,
      );
    });
  }
}

class InterestPage extends StatefulWidget {
  const InterestPage({
    super.key,
    required this.name,
    required this.birthday,
    required this.height,
    required this.weight,
  });

  final String name;
  final String birthday;
  final int height;
  final int weight;

  @override
  State<InterestPage> createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  late double _distanceToField;
  late TextfieldTagsController _controller;
  late AuthBloc _authBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void initState() {
    super.initState();
    _controller = TextfieldTagsController();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _authBloc.add(ProfileAuthEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _update() {
    setState(() {
      context.read<HomeBloc>().add(UpdateProfileEvent(
          params: UpdateProfileParams(
              name: widget.name,
              birthday: widget.birthday,
              height: widget.height,
              weight: widget.weight,
              interests: _controller.getTags)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.status == Status.loading) {
          EasyLoading.show(status: 'Loading..');
        } else if (state.status == Status.failure) {
          EasyLoading.showError(
            state.failure?.message ?? 'Update failed!',
          );
        } else if (state.status == Status.success) {
          context.read<AuthBloc>().add(ProfileAuthEvent());
          EasyLoading.showSuccess('Update success!');
          Navigator.pushNamedAndRemoveUntil(
              context, HomePage.routeName, (route) => false);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    AppColors().hPrimary1,
                    AppColors().hPrimary2,
                    AppColors().hPrimary3,
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
                  Row(
                    children: [
                      BackLeading(
                        onTap: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: GestureDetector(
                          onTap: _update,
                          child: GradientText(
                            'Save',
                            style: AppTextStyle.bold(),
                            gradient: LinearGradient(colors: AppColors().hBlue),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 73),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: GradientText(
                      'Tell everyone about yourself',
                      style: AppTextStyle.bold(fontSize: 14),
                      gradient: LinearGradient(colors: AppColors().hGolden),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Text(
                      'What interest you?',
                      style: AppTextStyle.bold(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: state.status != Status.loading
                        ? TextFieldTags(
                            textfieldTagsController: _controller,
                            textSeparators: const [' '],
                            letterCase: LetterCase.normal,
                            initialTags: state.user?.interests,
                            validator: (String tag) {
                              if (tag == 'Eat') {
                                return 'Please enter again';
                              } else if (_controller.getTags!.contains(tag)) {
                                return 'You already enter that';
                              }
                              return null;
                            },
                            inputfieldBuilder: (context, tec, fn, error,
                                onChanged, onSubmitted) {
                              return ((context, sc, tags, onTagDelete) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextField(
                                    controller: tec,
                                    focusNode: fn,
                                    style: AppTextStyle.medium(),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      filled: true,
                                      fillColor:
                                          HexColor('#D9D9D9').withOpacity(.06),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      hintText: _controller.hasTags ? '' : " .",
                                      errorText: error,
                                      prefixIconConstraints: BoxConstraints(
                                          maxWidth: _distanceToField * 0.74),
                                      prefixIcon: tags.isNotEmpty
                                          ? SingleChildScrollView(
                                              controller: sc,
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                  children:
                                                      tags.map((String tag) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(4),
                                                    ),
                                                    color: AppColors()
                                                        .hWhite
                                                        .withOpacity(0.1),
                                                  ),
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5.0),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        child: Text(
                                                          tag,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        onTap: () {
                                                          debugPrint(
                                                              "$tag selected");
                                                        },
                                                      ),
                                                      const SizedBox(
                                                          width: 4.0),
                                                      InkWell(
                                                        child: const Icon(
                                                          Icons.close,
                                                          size: 14.0,
                                                          color: Color.fromARGB(
                                                              255,
                                                              233,
                                                              233,
                                                              233),
                                                        ),
                                                        onTap: () {
                                                          onTagDelete(tag);
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }).toList()),
                                            )
                                          : null,
                                    ),
                                    onChanged: onChanged,
                                    onSubmitted: onSubmitted,
                                  ),
                                );
                              });
                            },
                          )
                        : const SkeletonAnimation(
                            width: double.infinity,
                            height: 80,
                          ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
