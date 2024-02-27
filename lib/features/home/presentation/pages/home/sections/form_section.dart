part of '../page.dart';

class _FormSection extends StatelessWidget {
  final String title;
  final String hint;
  final bool? readOnly;
  final TextEditingController controller;
  final void Function()? onTap;

  const _FormSection({
    required this.title,
    required this.hint,
    required this.readOnly,
    required this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.medium(color: AppColors().hWhite.withOpacity(.33)),
        ),
        Flexible(
          child: SizedBox(
            height: 36,
            width: 202,
            child: formFieldEdit(
                controller: controller,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                hintText: hint,
                readOnly: readOnly ?? false,
                onTap: onTap
            ),
          ),
        )
      ],
    );
  }
}