
// import 'package:dihadi/core/utils/extensions/toggel_list_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../core/common/error_text.dart';
// import '../../../../core/common/loader.dart';
// import '../../../../models/complaint.dart';
// import '../../../../models/user.dart';
// import '../../../../routes/route_utils.dart';
// import '../../../../theme/theme.dart';
// import '../../../auth/controller/auth_controller.dart';
// import '../../../user/controller/user_controller.dart';
// import '../../controller/worker_controller.dart';
// import '../../widgets/complaint_card.dart';

// class MyComplaintsFeed extends ConsumerWidget {
//   final bool backNavigationAllowed;

//   const MyComplaintsFeed({
//     super.key,
//     required this.backNavigationAllowed,
//   });

//   void updateVotes(WidgetRef ref, BuildContext context, Complaint complaint) {
//     final currentUserUid = ref.read(userProvider)!.uid;

//     complaint.upvotes.toggle(currentUserUid);

//     ref.read(complaintControllerProvider.notifier).updateComplaint(
//           complaint: complaint,
//           context: context,
//         );
//   }

//   void addRemoveBookmarks(
//     WidgetRef ref,
//     BuildContext context,
//     UserModel user,
//     String complaintId,
//   ) {
//     user.bookmarkedComplaints.toggle(complaintId);

//     ref.read(userControllerProvider.notifier).updateUser(
//           user: user,
//           context: context,
//         );
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(userProvider)!;
//     return Scaffold(
//       backgroundColor: AppColors.scaffoldBackgroundColor,
//       appBar: AppBar(
//         title: Text(
//           'My Complaints',
//           style: AppTextStyle.displayBlack.copyWith(
//             color: AppColors.black,
//           ),
//         ),
//         leading: backNavigationAllowed
//             ? IconButton(
//                 icon: const Icon(
//                   Icons.arrow_back_outlined,
//                   color: AppColors.black,
//                   size: 30,
//                 ),
//                 onPressed: () => Navigation.navigateToBack(context),
//               )
//             : null,
//         backgroundColor: AppColors.scaffoldBackgroundColor,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: ref.watch(getAllComplaintsProvider).when(
//             data: (complaints) {
//               List<Complaint> myComplaints =
//                   complaints // Filter events for joined only
//                       .where(
//                         (complaint) => complaint.createdBy == user.uid,
//                       )
//                       .toList();

//               return myComplaints.isEmpty
//                   ? Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(
//                             Icons.warning,
//                             size: 48,
//                             color: AppColors.greyColor,
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'No Complaints yet.',
//                             style: AppTextStyle.textRegular.copyWith(
//                               color: AppColors.greyColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   : Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ListView.builder(
//                         itemCount: myComplaints.length,
//                         shrinkWrap: true,
//                         itemBuilder: (context, index) {
//                           myComplaints.sort(
//                             (a, b) => b.filingTime.compareTo(
//                               a.filingTime,
//                             ),
//                           ); // Sort by postedAt in descending order

//                           final complaint = myComplaints[index];
//                           // Build your UI based on each complaint
//                           return ref
//                               .watch(
//                                   getUserDataByIdProvider(complaint.createdBy))
//                               .when(
//                                 data: (user) {
//                                   return ComplaintCard(
//                                     user: user!,
//                                     complaint: complaint,
//                                     onUpvote: () =>
//                                         updateVotes(ref, context, complaint),
//                                     onBookmark: (){}
//                                   );
//                                 },
//                                 error: (error, stackTrace) => ErrorText(
//                                   error: error.toString(),
//                                 ),
//                                 loading: () => const SizedBox(),
//                               );
//                         },
//                       ),
//                     );
//             },
//             error: (error, stackTrace) => ErrorText(
//               error: error.toString(),
//             ),
//             loading: () => const Loader(),
//           ),
//     );
//   }
// }
