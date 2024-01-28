
import 'package:dihadi/core/utils/extensions/toggel_list_item.dart';
import 'package:dihadi/features/worker/widgets/worker_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/common/loader.dart';
import '../../../../models/complaint.dart';
import '../../../../models/user.dart';
import '../../../auth/controller/auth_controller.dart';
import '../../../user/controller/user_controller.dart';
import '../../controller/worker_controller.dart';

class SavedWorkersFeed extends ConsumerWidget {
  final bool backNavigationAllowed;

  const SavedWorkersFeed({
    super.key,
    required this.backNavigationAllowed,
  });

  
  

  void addRemoveBookmarks(
    WidgetRef ref,
    BuildContext context,
    UserModel user,
    String complaintId,
  ) {
    user.savedWorkers.toggle(complaintId);

    ref.read(userControllerProvider.notifier).updateUser(
          user: user,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getAllUsersrovider).when(
          data: (complaints) {
            return ListView.builder(
              itemCount: complaints.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final user = complaints[index];
                // Build your UI based on each complaint
                return ref
                    .watch(getUserDataByIdProvider(user.uid))
                    .when(
                      data: (user) {
                        return WorkerCard(
                          user: user!,
                         
                          onBookmark: () {}
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
