import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_constant.dart';
import '../../../core/common/label_chip.dart';
import '../../../models/complaint.dart';
import '../../../models/user.dart';
import '../../../routes/route_utils.dart';
import '../../../theme/theme.dart';

class WorkerCard extends StatelessWidget {
  final UserModel user;

  final VoidCallback onBookmark;
  const WorkerCard({
    super.key,
    required this.user,
    required this.onBookmark,
  });

  Color getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'REJECTED':
        return Colors.red;
      case 'SOLVED':
        return Colors.green;
      case 'IN PROGRESS':
        return Colors.blue;
      default:
        return Colors.deepOrange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          border: Border.all(
            width: 1,
            color: AppColors.mDisabledColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        backgroundImage: (user.photoUrl != "")
                            ? NetworkImage(
                                user.photoUrl,
                              )
                            : const AssetImage(
                                IMAGE_PATH_DEFAULT_USER_PROFILE_IMAGE,
                              ) as ImageProvider<Object>?,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: AppTextStyle.textSemiBold.copyWith(
                              color: AppColors.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            user.email,
                            style: AppTextStyle.textRegular.copyWith(
                              color: AppColors.mDisabledColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                          ),
                          Text(
                            '3.8',
                            style: AppTextStyle.displayBold.copyWith(
                              color: AppColors.primary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: onBookmark,
                        icon: Icon(
                          user.savedWorkers.contains(user.uid)
                              ? Icons.bookmark_added
                              : Icons.bookmark_add_outlined,
                          color: user.savedJobs.contains(user.uid)
                              ? AppColors.primary
                              : AppColors.mDisabledColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                thickness: 1,
                color: AppColors.mDisabledColor,
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 6,
                  runSpacing: 8,
                  children: user.skills.take(4).map((skill) {
                    return LabelChip(
                      label: skill,
                      // Customize the color, icon, and backgroundColor as needed
                      color: AppColors.primary,
                      icon: Icons
                          .code, // Example icon, you can set it to null if not needed
                      backgroundColor: null,
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              InkWell(
                splashColor: AppColors.splashColor,
                hoverColor: AppColors.greyColor,
                onTap: () => Navigation.navigateToWorkerDetailsScreen(
                  context,
                  user.uid,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.service,
                            style: AppTextStyle.textRegular.copyWith(
                              color: AppColors.black,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            user.about,
                            style: AppTextStyle.textLight.copyWith(
                              color: AppColors.greyColor,
                              fontSize: 11,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.greyColor,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
