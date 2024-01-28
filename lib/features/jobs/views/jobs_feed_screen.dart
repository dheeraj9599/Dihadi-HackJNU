import 'package:dihadi/constants/ui_constants.dart';
import 'package:dihadi/core/common/error_text.dart';
import 'package:dihadi/core/common/loader.dart';
import 'package:dihadi/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../routes/route_utils.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_style.dart';
import '../controller/job_controller.dart';
import '../widgets/job_overview_card.dart';

class JobsFeedScreen extends ConsumerStatefulWidget {
  const JobsFeedScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JobsFeedScreenState();
}

class _JobsFeedScreenState extends ConsumerState<JobsFeedScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    return ref.watch(userJobProvider).when(
          data: (allJobs) {
            final filteredJobs =
                allJobs.where((job) => job.contractor == user.uid).toList();

            return Scaffold(
              appBar: AppBar(
                title: Text(
                  user.role == UiConstants.userRoles[1]
                      ? 'All Jobs'
                      : 'My Jobs',
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
              ),
              body: ListView.builder(
                itemCount: user.role == UiConstants.userRoles[1] ? allJobs.length: filteredJobs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final job =  user.role == UiConstants.userRoles[1] ? allJobs[index]: filteredJobs[index];
                  return JobOverViewCard(
                    job: job,
                  );
                },
              ),
            );
          },
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
