part of '../page.dart';

class _About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return _AboutSection(
        name: state.user?.name ?? '',
        birthday: state.user?.birthday ?? '',
        horoscope: state.user?.horoscope ?? '',
        zodiac: state.user?.zodiac ?? '',
        interest: state.user?.interests ?? [],
      );
    });
  }
}

class _AboutSection extends StatefulWidget {
  const _AboutSection({
    required this.name,
    required this.birthday,
    required this.horoscope,
    required this.zodiac,
    required this.interest,
  });

  final String name;
  final String birthday;
  final String horoscope;
  final String zodiac;
  final List<String> interest;

  @override
  State<_AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<_AboutSection> {
  late bool _editAbout;
  late String _selectedValue;
  late List<String> _options;
  late TextEditingController _cName;
  late TextEditingController _cBirthday;
  late TextEditingController _cHoroscope;
  late TextEditingController _cZodiac;
  late TextEditingController _cHeight;
  late TextEditingController _cWeight;
  late GlobalKey<FormState> _formKey;
  late bool _isLoading;
  DateTime? _dateTime;

  @override
  void initState() {
    _editAbout = false;
    _selectedValue = 'Male';
    _options = [
      'Male',
      'Female',
    ];
    _cName = TextEditingController();
    _cName.text = widget.name;
    _cBirthday = TextEditingController();
    _cBirthday.text = widget.birthday;
    _cHoroscope = TextEditingController();
    _cHoroscope.text = widget.horoscope;
    _cZodiac = TextEditingController();
    _cZodiac.text = widget.zodiac;
    _cHeight = TextEditingController();
    _cHeight.text = '';
    _cWeight = TextEditingController();
    _cWeight.text = '';
    _formKey = GlobalKey();
    _isLoading = false;
    super.initState();
  }

  void _update() {
    setState(() {
      _editAbout = !_editAbout;
    });
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
        context.read<HomeBloc>().add(UpdateProfileEvent(
            params: UpdateProfileParams(
                name: _cName.text,
                interests: widget.interest,
                height: int.parse(_cHeight.text),
                weight: int.parse(_cWeight.text),
                birthday: _cBirthday.text)));
      });
    }
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
        }
      },
      builder: (context, state) {
        return state.status != Status.loading
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 27,
                  vertical: 13,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                  color: AppColors().hCard2,
                ),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'About',
                              style: AppTextStyle.bold(),
                            ),
                            !_editAbout
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _editAbout = !_editAbout;
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      MainAssets.editIcon,
                                      width: 17,
                                      height: 17,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: _update,
                                    child: GradientText(
                                      'Save & Update',
                                      gradient: LinearGradient(
                                          colors: AppColors().hGolden),
                                      style: AppTextStyle.medium(),
                                    ),
                                  ),
                          ],
                        ),
                        const SizedBox(height: 33),
                        !_editAbout
                            ? widget.name.isEmpty
                                ? Text(
                                    'Add in your your to help others know you better',
                                    style: AppTextStyle.medium(
                                        color: AppColors()
                                            .hWhite
                                            .withOpacity(.52)),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Birthday: ',
                                            style: AppTextStyle.medium(
                                              color: AppColors()
                                                  .hWhite
                                                  .withOpacity(.33),
                                            ),
                                          ),
                                          Text(
                                            widget.birthday,
                                            style: AppTextStyle.medium(),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Text(
                                            'Horoscope: ',
                                            style: AppTextStyle.medium(
                                              color: AppColors()
                                                  .hWhite
                                                  .withOpacity(.33),
                                            ),
                                          ),
                                          Text(
                                            widget.horoscope,
                                            style: AppTextStyle.medium(),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Text(
                                            'Zodiac: ',
                                            style: AppTextStyle.medium(
                                              color: AppColors()
                                                  .hWhite
                                                  .withOpacity(.33),
                                            ),
                                          ),
                                          Text(
                                            widget.zodiac,
                                            style: AppTextStyle.medium(),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Text(
                                            'Height: ',
                                            style: AppTextStyle.medium(
                                              color: AppColors()
                                                  .hWhite
                                                  .withOpacity(.33),
                                            ),
                                          ),
                                          Text(
                                            '${state.user?.height} cm',
                                            style: AppTextStyle.medium(),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Text(
                                            'Weight: ',
                                            style: AppTextStyle.medium(
                                              color: AppColors()
                                                  .hWhite
                                                  .withOpacity(.33),
                                            ),
                                          ),
                                          Text(
                                            '${state.user?.weight} kg',
                                            style: AppTextStyle.medium(),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                            : Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 57,
                                            width: 57,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 18),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(17)),
                                              color: AppColors()
                                                  .hWhite
                                                  .withOpacity(0.08),
                                            ),
                                            child: SvgPicture.asset(
                                                'assets/icons/add_ic.svg'),
                                          ),
                                          const SizedBox(width: 15),
                                          Text(
                                            'Add image',
                                            style: AppTextStyle.medium(
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 29),
                                    _FormSection(
                                      controller: _cName,
                                      title: 'Display name:',
                                      hint: 'Enter name',
                                      readOnly: false,
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Gender:',
                                          style: AppTextStyle.medium(
                                              color: AppColors()
                                                  .hWhite
                                                  .withOpacity(.33)),
                                        ),
                                        Flexible(
                                          child: SizedBox(
                                            height: 36,
                                            width: 202,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: HexColor('#D9D9D9')
                                                    .withOpacity(.06),
                                                border: Border.all(
                                                  color: AppColors()
                                                      .hWhite
                                                      .withOpacity(.22),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(9.0),
                                              ),
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                    style: AppTextStyle.medium(
                                                      color: Colors.white
                                                          .withOpacity(.4),
                                                      fontSize: 13,
                                                    ),
                                                    value: _selectedValue,
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        _selectedValue =
                                                            newValue!;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: AppColors().hWhite,
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15),
                                                    underline: Container(),
                                                    dropdownColor:
                                                        AppColors().hPrimary3,
                                                    items: _options.map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String option) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: option,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            option,
                                                            style: AppTextStyle
                                                                .medium(
                                                              color: AppColors()
                                                                  .hWhite,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    _FormSection(
                                      controller: _cBirthday,
                                      title: 'Birthday:',
                                      hint: 'DD MM YYYY',
                                      readOnly: true,
                                      onTap: () async {
                                        await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1980),
                                          lastDate: DateTime(2099),
                                        ).then((date) {
                                          setState(() {
                                            _dateTime = date;
                                          });
                                        });
                                        setState(() {
                                          _cBirthday.text =
                                              TimeHelper.convertToBirthday(
                                                  '$_dateTime');
                                          debugPrint(_cBirthday.text);
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 12),
                                    _FormSection(
                                      controller: _cHoroscope,
                                      title: 'Horoscope:',
                                      hint: '--',
                                      readOnly: true,
                                    ),
                                    const SizedBox(height: 12),
                                    _FormSection(
                                      controller: _cZodiac,
                                      title: 'Zodiac',
                                      hint: '--',
                                      readOnly: true,
                                    ),
                                    const SizedBox(height: 12),
                                    _FormSection(
                                      controller: _cHeight,
                                      title: 'Height',
                                      hint: 'Add height',
                                      readOnly: false,
                                    ),
                                    const SizedBox(height: 12),
                                    _FormSection(
                                      controller: _cWeight,
                                      title: 'Weight',
                                      hint: 'Add weight',
                                      readOnly: false,
                                    ),
                                  ],
                                ),
                              ),
                        const SizedBox(height: 10)
                      ],
                    );
                  },
                ),
              )
            : const AboutShimmer();
      },
    );
  }
}
