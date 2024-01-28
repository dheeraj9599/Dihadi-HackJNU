import 'package:dihadi/models/job.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/label_chip.dart';
import '../../../core/common/like_button.dart';
import '../../../core/common/loader.dart';
import '../../../models/complaint.dart';
import '../../../models/user.dart';
import '../../../theme/theme.dart';
import '../../user/controller/user_controller.dart';

class LatestComplaintsCard extends ConsumerWidget {
  final Jobs complaint;
  final UserModel user;
  const LatestComplaintsCard({
    super.key,
    required this.complaint,
    required this.user,
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
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(18),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppColors.white,
        // boxShadow: AppColors.carouselSliderShadow,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      complaint.title,
                      style: AppTextStyle.textSemiBold.copyWith(
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // LikeButton(
                  //   color: complaint.upvotes.contains(user.uid)
                  //       ? AppColors.primary
                  //       : AppColors.mDisabledColor,
                  //   likes: complaint.upvotes.length.toString(),
                  // )
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                DateFormat(
                  'd MMM yyyy hh:mm a',
                ).format(
                  complaint.postedAt.toDate(),
                ),
                style: AppTextStyle.textMedium.copyWith(
                  color: AppColors.subTitleColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          ref.watch(getUserDataByIdProvider(complaint.id)).when(
                data: (data) {
                  return Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      LabelChip(
                        label: complaint.status.toString(),
                        color: getStatusColor(
                          complaint.status.toUpperCase(),
                        ),
                        icon: Icons.approval,
                        backgroundColor: null,
                      ),
                      LabelChip(
                        label: complaint.title.toString(),
                        color: AppColors.green,
                        icon: Icons.money,
                        backgroundColor: null,
                      ),
                      LabelChip(
                        label: data!.service,
                        color: AppColors.primary,
                        icon: Icons.assured_workload_outlined,
                        backgroundColor: null,
                      ),
                      LabelChip(
                        label: complaint.skills.toString(),
                        color: AppColors.purpleColor,
                        icon: Icons.category_sharp,
                        backgroundColor: null,
                      ),
                    ],
                  );
                },
                error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
                loading: () => const Loader(),
              ),
        ],
      ),
    );
  }
}
