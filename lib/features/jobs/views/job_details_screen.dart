import 'package:dihadi/constants/ui_constants.dart';
import 'package:dihadi/core/common/rounded_button.dart';
import 'package:dihadi/core/utils/extensions/toggel_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../core/type_defs.dart';
import '../../../models/user.dart';
import '../../../routes/route_utils.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_style.dart';
import '../../auth/controller/auth_controller.dart';
import '../../user/controller/user_controller.dart';
import '../controller/job_controller.dart';

class JobsDetailsScreen extends ConsumerStatefulWidget {
  final String jobId;
  const JobsDetailsScreen({
    super.key,
    required this.jobId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _JobsDetailsScreenState();
}

class _JobsDetailsScreenState extends ConsumerState<JobsDetailsScreen> {
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

  FutureVoid onRefresh(
    WidgetRef ref,
    String id,
    String uid,
  ) async {
    ref.invalidate(
      getUserDataByIdProvider(uid),
    );
    ref.invalidate(
      getJobByIdProvider(id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userProvider)!;

    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          'Job Details',
          style: AppTextStyle.displayBlack.copyWith(
            color: AppColors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: AppColors.black,
            size: 30,
          ),
          onPressed: () => Navigation.navigateToBack(context),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => addRemoveBookmarks(
              ref: ref,
              context: context,
              user: currentUser,
              jobId: widget.jobId,
            ),
            icon: Icon(
              currentUser.savedJobs.contains(widget.jobId)
                  ? Icons.bookmark_added
                  : Icons.bookmark_add_outlined,
              color: currentUser.savedJobs.contains(widget.jobId)
                  ? AppColors.primary
                  : AppColors.mDisabledColor,
            ),
          ),
        ],
      ),
      body: ref.watch(getJobByIdProvider(widget.jobId)).when(
            data: (job) {
              return ref.watch(getUserDataByIdProvider(job.contractor)).when(
                    data: (user) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                job.title,
                                style: AppTextStyle.textBold.copyWith(
                                  fontSize: 24,
                                  color: AppColors.black,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    size: 18.0,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: 10.0),
                                  Text(
                                    'Posted by: ',
                                    style: AppTextStyle.textBold.copyWith(
                                      fontSize: 18,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  Text(
                                    user!.email,
                                    style: AppTextStyle.displayMedium.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.start,
                                alignment: WrapAlignment.center,
                                runAlignment: WrapAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.school,
                                    size: 18.0,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: 10.0),
                                  Text(
                                    'Skills: ',
                                    style: AppTextStyle.textBold.copyWith(
                                      fontSize: 18,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  Text(
                                    job.skills.join(
                                        ', '), // Join the campuses with ', '
                                    style: AppTextStyle.displayMedium.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              SelectableText(
                                job.responsibility,
                                style: AppTextStyle.displayBold.copyWith(
                                    fontSize: 16.0,
                                    color: AppColors.black,
                                    letterSpacing: 1.5),
                              ),
                              const SizedBox(height: 20.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                ),
                                child: Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: AppColors.lightShadowColor
                                        .withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Start from',
                                              style: AppTextStyle.displayLight
                                                  .copyWith(
                                                color: AppColors.black,
                                                fontSize: 14,
                                                letterSpacing: 3,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              DateFormat('d MMM yyyy hh:mm a')
                                                  .format(
                                                job.startDate.toDate(),
                                              ),
                                              style: AppTextStyle.textBold
                                                  .copyWith(
                                                color: AppColors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Status',
                                              style: AppTextStyle.displayLight
                                                  .copyWith(
                                                color: AppColors.black,
                                                fontSize: 14,
                                                letterSpacing: 3,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              job.status,
                                              style: AppTextStyle.textHeavy
                                                  .copyWith(),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Posted At:',
                                          style: AppTextStyle.textBold.copyWith(
                                            fontSize: 18,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          DateFormat.yMMMMd().format(
                                            job.postedAt.toDate(),
                                          ),
                                          style: AppTextStyle.displayMedium
                                              .copyWith(
                                            fontSize: 16.0,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Category:',
                                          style: AppTextStyle.textBold.copyWith(
                                            fontSize: 18,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.mail,
                                              size: 18.0,
                                              color: AppColors.primary,
                                            ),
                                            const SizedBox(width: 6.0),
                                            Text(
                                              'Contact: ',
                                              style: AppTextStyle.textBold
                                                  .copyWith(
                                                fontSize: 18,
                                                color: AppColors.black,
                                              ),
                                            ),
                                            Text(
                                              job.contractorContact, // Join the campuses with ', '
                                              style: AppTextStyle.displayMedium
                                                  .copyWith(
                                                fontSize: 16.0,
                                                color: AppColors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              currentUser.role == UiConstants.userRoles[1]
                                  ? job.applicants.contains(currentUser.uid)
                                      ? RoundedButton(
                                          onPressed: null,
                                          text: 'Already Apply',
                                          linearGradient: AppColors.redGradient,
                                        )
                                      : RoundedButton(
                                          onPressed: () {
                                            ref
                                                .read(jobControllerProvider
                                                    .notifier)
                                                .applyForJob(job.id);
                                          },
                                          text: 'Applied',
                                          linearGradient:
                                              AppColors.lightPinkGradient,
                                        )
                                  : RoundedButton(
                                      onPressed: () {},
                                      text: 'See Applications',
                                      linearGradient:
                                          AppColors.lightPinkGradient,
                                    ),
                            ],
                          ),
                        ),
                      );
                    },
                    error: (error, stackTrace) => ErrorText(
                      error: error.toString(),
                    ),
                    loading: () => const Loader(),
                  );
            },
            error: (error, stackTrace) => ErrorText(
              error: error.toString(),
            ),
            loading: () => const Loader(),
          ),
    );
  }
}
