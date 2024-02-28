part of '../page.dart';

// class _FormSection extends StatelessWidget {
//   final String title;
//   final String hint;
//   final bool? readOnly;
//   final TextEditingController controller;
//   final void Function()? onTap;

//   const _FormSection({
//     required this.title,
//     required this.hint,
//     required this.readOnly,
//     required this.controller,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: AppTextStyle.medium(color: AppColors().hWhite.withOpacity(.33)),
//         ),
//         Flexible(
//           child: SizedBox(
//             height: 36,
//             width: 202,
//             child: formFieldEdit(
//                 controller: controller,
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 10,
//                   horizontal: 20,
//                 ),
//                 hintText: hint,
//                 readOnly: readOnly ?? false,
//                 onTap: onTap
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

class _FormSection extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final List<String>? dropdownOptions;
  final String? selectedValue;
  final Function(String?)? onDropdownChanged;
  final bool? readOnly;
  final void Function()? onTap;
  final bool showDropdown;

  const _FormSection({
    required this.title,
    required this.hintText,
    required this.controller,
    this.dropdownOptions,
    this.selectedValue,
    this.onDropdownChanged,
    required this.readOnly,
    this.onTap,
    this.showDropdown = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              AppTextStyle.medium(color: AppColors().hWhite.withOpacity(.33)),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .end, // Aligns the child Row contents to the right
            children: [
              if (showDropdown &&
                  dropdownOptions != null &&
                  selectedValue != null &&
                  onDropdownChanged != null) ...[
                // const SizedBox(width: 8),
                Flexible(
                  child: SizedBox(
                    height: 36,
                    width: 202,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: HexColor('#D9D9D9').withOpacity(.06),
                        border: Border.all(
                          color: AppColors().hWhite.withOpacity(.22),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedValue,
                            onChanged: onDropdownChanged,
                            style: AppTextStyle.medium(
                              color: Colors.white.withOpacity(.4),
                              fontSize: 13,
                            ),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors().hWhite,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            underline: Container(),
                            dropdownColor: AppColors().hPrimary3,
                            items: dropdownOptions!
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: AppTextStyle.medium(
                                      color: AppColors().hWhite,
                                      fontSize: 13,
                                    )),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
              const SizedBox(width: 8),
              SizedBox(
                height: 36,
                width: 202,
                child: formFieldEdit(
                  controller: controller,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  hintText: hintText,
                  readOnly: readOnly ?? false,
                  onTap: onTap,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
