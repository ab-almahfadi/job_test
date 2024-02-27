part of '../page.dart';

class _InterestSections extends StatelessWidget {
  final User user;

  const _InterestSections({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 27,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        color: AppColors().hCard2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Interest',
                style: AppTextStyle.bold(),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Interest.routeName);
                },
                child: SvgPicture.asset(
                  MainAssets.editIcon,
                  width: 17,
                  height: 17,
                ),
              )
            ],
          ),
          const SizedBox(height: 33),
          user.interests == null
              ? Text(
            'Add in your interest to find a better match',
            style: AppTextStyle.medium(
                color: AppColors().hWhite.withOpacity(.52)),
          )
              : Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [...generateTags()],
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  generateTags() {
    return user.interests?.map((tag) => getChip(tag)).toList();
  }

  getChip(name) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        color: AppColors().hWhite.withOpacity(.06),
      ),
      child: Text(
        "$name",
        style: AppTextStyle.semiBold(),
      ),
    );
  }
}