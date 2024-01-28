import 'package:dihadi/core/utils/extensions/toggel_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/enums/enums.dart';
import '../../../models/job.dart';
import '../../../models/user.dart';
import '../../../routes/route_utils.dart';
import '../../../theme/theme.dart';
import '../../auth/controller/auth_controller.dart';
import '../../user/controller/user_controller.dart';

class JobOverViewCard extends ConsumerWidget {
  final Jobs job;
  const JobOverViewCard({
    super.key,
    required this.job,
  });

  Color getStatusColor(String status) {
    switch (status) {
      case 'Upcoming':
        return Colors.blue;
      case 'Active':
        return Colors.green;
      case 'Expired':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  String checkValidity(DateTime start, DateTime end) {
    DateTime now = DateTime.now();
    if (now.isBefore(start)) {
      return 'Upcoming';
    } else if (now.isAfter(end)) {
      return 'Expired';
    } else {
      return 'Active';
    }
  }

  void addRemoveBookmarks({
    required WidgetRef ref,
    required BuildContext context,
    required UserModel user,
    required String jobId,
  }) {
    user.savedJobs.toggle(jobId);
    ref.read(userControllerProvider.notifier).updateUser(
          user: user,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        child: InkWell(
          splashColor: AppColors.splashColor,
          onTap: () => Navigation.navigateToJobDetailsScreen(
            context,
            job.id,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Wrap(
              children: <Widget>[
                Text(
                  job.title,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.textBold
                      .copyWith(fontSize: 20, color: AppColors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Posted on: ',
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.displayBold.copyWith(
                        fontSize: 13,
                        color: AppColors.black,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        DateFormat.yMMMMd()
                            .format(job.postedAt.toDate())
                            .toString(),
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.textSemiBold.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => addRemoveBookmarks(
                        ref: ref,
                        context: context,
                        user: currentUser,
                        jobId: job.id,
                      ),
                      icon: Icon(
                        currentUser.savedJobs.contains(job.id)
                            ? Icons.bookmark_added
                            : Icons.bookmark_add_outlined,
                        color: currentUser.savedJobs.contains(job.id)
                            ? AppColors.primary
                            : AppColors.mDisabledColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    Text(
                      'Job Start From: ',
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.displayBold.copyWith(
                        fontSize: 13,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMMd()
                          .format(
                            job.startDate.toDate(),
                          )
                          .toString(),
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.textSemiBold.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        job.responsibility,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: AppTextStyle.textRegular.copyWith(
                          fontSize: 14,
                          color: AppColors.greyColor,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            job.status,
                            style: TextStyle(
                              fontSize: 16,
                              color: job.status == JobStatus.active.toString()
                                  ? Colors.green
                                  : job.status == JobStatus.closed.toString()
                                      ? Colors.red
                                      : Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'status',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
