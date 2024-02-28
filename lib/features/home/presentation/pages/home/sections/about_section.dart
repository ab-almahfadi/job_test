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
        height: state.user?.height?.toString() ?? '',
        heightm: state.user?.heightm ?? '',
        weight: state.user?.weight?.toString() ?? '',
        weightm: state.user?.weightm ?? '',
        interest: state.user?.interests ?? [],
        picker: state.user?.picker,
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
    required this.height,
    required this.heightm,
    required this.weight,
    required this.weightm,
    required this.interest,
    this.picker,
    this.imageKey,
    // this.onImagePicked
  });

  final String name;
  final String birthday;
  final String horoscope;
  final String height;
  final String heightm;
  final String weight;
  final String weightm;
  final String zodiac;
  final List<String> interest;
  final ImagePicker? picker;
  final String? imageKey;
  // final void Function(Uint8List imageData)? onImagePicked;

  @override
  State<_AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<_AboutSection> {
  late bool _editAbout;
  late ImagePicker _picker;
  late String _selectedValue;
  late String _selectedHeight;
  late String _selectedWeight;
  late List<String> _options;
  late List<String> _heightOptions;
  late List<String> _weightOptions;
  late TextEditingController _cName;
  late TextEditingController _cBirthday;
  late TextEditingController _cHoroscope;
  late TextEditingController _cZodiac;
  late TextEditingController _cHeight;
  late TextEditingController _cWeight;
  late GlobalKey<FormState> _formKey;
  late bool _isLoading;
  DateTime? _dateTime;
  late String _imageKey;
  Uint8List? _webImageBytes;
  String? _imagePath;
  // void Function(Uint8List imageData)? onImagePicked;

  @override
  void initState() {
    _editAbout = false;
    _selectedValue = 'Male';
    _selectedHeight = "inch";
    _selectedWeight = "ib";
    _options = [
      'Male',
      'Female',
    ];
    _heightOptions = [
      "cm",
      "inch",
    ];
    _weightOptions = [
      "kg",
      "ib",
    ];
    _picker = widget.picker ?? ImagePicker();
    _cName = TextEditingController();
    _cName.text = widget.name;
    _cBirthday = TextEditingController();
    _cBirthday.text = widget.birthday;
    _cHoroscope = TextEditingController();
    _cHoroscope.text = widget.horoscope;
    _cZodiac = TextEditingController();
    _cZodiac.text = widget.zodiac;
    _cHeight = TextEditingController();
    _cHeight.text = widget.height;
    _cWeight = TextEditingController();
    _cWeight.text = widget.weight;
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
        // String combinedHeight = "${_cHeight.text} ${_selectedHeight}";
        context.read<HomeBloc>().add(UpdateProfileEvent(
            params: UpdateProfileParams(
                name: _cName.text,
                interests: widget.interest,
                height: int.parse(_cHeight.text),
                weight: int.parse(_cWeight.text),
                heightm: _selectedHeight,
                weightm: _selectedWeight,
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
                                    'Add in your profile to help others know you better',
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
                                            '${state.user?.height} $_selectedHeight',
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
                                            '${state.user?.weight} $_selectedWeight',
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
                                      onTap: () async {
                                        try {
                                          // Pick an image
                                          // final ImagePicker _picker = ImagePicker();
                                          final XFile? image =
                                              await _picker.pickImage(
                                                  source: ImageSource
                                                      .gallery); // or ImageSource.camera

                                          if (image != null) {
                                            // For Web: Use the image file directly or upload it
                                            if (kIsWeb) {
                                              // Read the file as bytes
                                              Uint8List imageBytes =
                                                  await image.readAsBytes();
                                              String base64Image =
                                                  base64Encode(imageBytes);

                                              // Define a unique key for the image
                                              _imageKey =
                                                  'stored_image_${DateTime.now().millisecondsSinceEpoch}';
                                              // Store the Base64-encoded string in LocalStorage with the unique key
                                              html.window.localStorage.clear();
                                              html.window
                                                      .localStorage[_imageKey] =
                                                  base64Image;
                                              // Print the "path" (key) where the image is stored
                                              // _webImageBytes = base64Decode(base64Image);
                                              setState(() {
                                                _webImageBytes = imageBytes;
                                              });
                                              // onImagePicked!(imageBytes);
                                              //             [
                                              //   Padding(
                                              //     padding: const EdgeInsets.all(8.0),
                                              //     child: Image.memory(imageBytes),
                                              //   ),
                                              // ];
                                              ;
                                              print(
                                                  "Image stored with key: $_imageKey");
                                            } else {
                                              // For mobile or desktop: Save the image locally
                                              final Directory directory =
                                                  await getApplicationDocumentsDirectory();
                                              final String imagePath =
                                                  path.join(
                                                      directory.path,
                                                      path.basename(
                                                          image.path));
                                              final File newImage =
                                                  await File(image.path)
                                                      .copy(imagePath);
                                              setState(() {
                                                _imagePath = imagePath;
                                              });
                                              print(
                                                  "Image saved to $imagePath");
                                            }
                                          }
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(17)),
                                            child: Container(
                                              height: 57,
                                              width: 57,
                                              color: Colors.white
                                                  .withOpacity(0.08),
                                              child: FittedBox(
                                                fit: BoxFit
                                                    .cover, // This will ensure the image covers the container area
                                                child: _imagePath != null
                                                    ? Image.file(
                                                        File(_imagePath!),
                                                        width: 57,
                                                        height: 57)
                                                    : _webImageBytes != null
                                                        ? Image.memory(
                                                            _webImageBytes!,
                                                            width: 57,
                                                            height: 57)
                                                        : SvgPicture.asset(
                                                            'assets/icons/add_ic.svg',
                                                            width: 25,
                                                            height: 25),
                                              ),
                                            ),
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
                                    // if (_webImageBytes != null) ...[
                                    //   Padding(
                                    //     padding: const EdgeInsets.all(8.0),
                                    //     child: Image.memory(_webImageBytes!),
                                    //   ),
                                    // ],

                                    _FormSection(
                                      controller: _cName,
                                      title: 'Display name:',
                                      hintText: 'Enter name',
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
                                      hintText: 'DD MM YYYY',
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
                                      hintText: '--',
                                      readOnly: true,
                                    ),
                                    const SizedBox(height: 12),
                                    _FormSection(
                                      controller: _cZodiac,
                                      title: 'Zodiac',
                                      hintText: '--',
                                      readOnly: true,
                                    ),
                                    const SizedBox(height: 12),
                                    _FormSection(
                                      title: 'Height: ',
                                      hintText: 'Add height',
                                      readOnly: false,
                                      controller: _cHeight,
                                      dropdownOptions: _heightOptions,
                                      selectedValue: _selectedHeight,
                                      onDropdownChanged: (newValue1) {
                                        setState(() {
                                          _selectedHeight = newValue1!;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 12),
                                    _FormSection(
                                      title: 'Weight:',
                                      hintText: 'Add weight',
                                      readOnly: false,
                                      controller: _cWeight,
                                      dropdownOptions: _weightOptions,
                                      selectedValue: _selectedWeight,
                                      onDropdownChanged: (newValue2) {
                                        setState(() {
                                          _selectedWeight = newValue2!;
                                        });
                                        setState(() {
                                          debugPrint(_selectedWeight);
                                        });
                                      },
                                    ),
                                  ],
                                )),
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
