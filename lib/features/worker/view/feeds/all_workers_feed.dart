
import 'package:dihadi/core/utils/extensions/toggel_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/common/loader.dart';
import '../../../../models/complaint.dart';
import '../../../../models/user.dart';
import '../../../auth/controller/auth_controller.dart';
import '../../../user/controller/user_controller.dart';
import '../../controller/worker_controller.dart';
import '../../widgets/worker_card.dart';

class AllWorkersFeed extends ConsumerWidget {
  final bool backNavigationAllowed;

  const AllWorkersFeed({
    super.key,
    required this.backNavigationAllowed,
  });


  void addRemoveBookmarks(
    WidgetRef ref,
    BuildContext context,
    UserModel user,
    String complaintId,
  ) {
    user.savedJobs.toggle(complaintId);

    ref.read(userControllerProvider.notifier).updateUser(
          user: user,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getAllUsersrovider).when(
          data: (users) {
            return ListView.builder(
              itemCount: users.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                

                final user = users[index];
                // Build your UI based on each complaint
                return ref
                    .watch(getUserDataByIdProvider(user.uid))
                    .when(
                      data: (user) {
                        return WorkerCard(
                          user: user,
                          onBookmark: () => addRemoveBookmarks(ref, context, user, user.uid)
                        );
                      },
                      error: (error, stackTrace) => ErrorText(
                        error: error.toString(),
                      ),
                      loading: () => const SizedBox(),
                    );
              },
            );
          },
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
