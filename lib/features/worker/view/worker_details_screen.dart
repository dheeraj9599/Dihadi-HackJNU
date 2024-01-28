import 'dart:convert';

import 'package:dihadi/core/utils/extensions/toggel_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../constants/ui_constants.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/label_chip.dart';
import '../../../core/common/loader.dart';
import '../../../core/core.dart';
import '../../../core/utils/snackbar.dart';
import '../../../models/complaint.dart';
import '../../../models/user.dart';
import '../../../routes/route_utils.dart';
import '../../../theme/theme.dart';
import '../../auth/controller/auth_controller.dart';
import '../../user/controller/user_controller.dart';
import '../widgets/approve_complaint_bottom_sheet.dart';
import '../widgets/complaint_status_message_widget.dart';
import '../widgets/reject_complaint_bottom_sheet.dart';
import '../widgets/solve_complaint_bottom_sheet.dart';

class WorkerDetailsScreen extends ConsumerWidget {
  final String workerId;
  const WorkerDetailsScreen({
    Key? key,
    required this.workerId,
  }) : super(key: key);

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

  void addRemoveBookmarks(
    WidgetRef ref,
    BuildContext context,
    UserModel user,
    String workerId,
  ) {
    user.savedWorkers.toggle(workerId);

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
      getUserDataByIdProvider(id),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final user = ref.watch(userProvider)!;
    return ref.watch(getUserDataByIdProvider(workerId)).when(
          data: (user) {
            return Scaffold(
                body: SafeArea(
              child: LiquidPullToRefresh(
                color: AppColors.secondary,
                height: 300,
                
                backgroundColor: AppColors.white,
                animSpeedFactor: 2,
                showChildOpacityTransition: false,
                onRefresh: () => onRefresh(
                  ref,
                  user.uid,
                  user.name,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.orangeGradient,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 180,
                        width: double.maxFinite,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: AppColors.orangeGradient,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      color: AppColors.white,
                                    ),
                                    onPressed: () =>
                                        Navigation.navigateToBack(context),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                     
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        user.service,
                                        style: AppTextStyle.textHeavy.copyWith(
                                          color: AppColors.white,
                                          fontSize: 16,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        user.email,
                                        style:
                                            AppTextStyle.textRegular.copyWith(
                                          color: AppColors.lightWhite,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //////////////////////////////////////////////////////////         BODY         ///////////////////////////////
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20.0)),
                            ),
                            child: SingleChildScrollView(
                              physics: const ClampingScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LabelChip(
                                          label: 'Phone: ${user.phone}',
                                          color: AppColors.green,
                                          icon: Icons.call,
                                          backgroundColor: null,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {

                                                    Navigation.navigateToOneToOneChatScreen(context, user.uid);
                                                  },
                                                  // updateVotes(ref,
                                                  //     context, complaint),
                                                  icon: const Icon(Icons.message_outlined,
                                                      color: AppColors.greyColor),
                                                ),
                                               const SizedBox(width: 4,),
                                                  IconButton(
                                                  onPressed: () {},
                                                  // updateVotes(ref,
                                                  //     context, complaint),
                                                  icon:const Icon(Icons.star,
                                                      color: Colors.yellow,),
                                                ),
                                                const SizedBox(width: 4,),
                                                Text(
                                                  '3.8'.toString(),
                                                  style: AppTextStyle
                                                      .displayBold
                                                      .copyWith(
                                                    color: AppColors.primary,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                              onPressed: () =>
                                                  addRemoveBookmarks(
                                                ref,
                                                context,
                                                user,
                                                workerId,
                                              ),
                                              icon: Icon(
                                                user.savedWorkers.contains(
                                                  user.uid,
                                                )
                                                    ? Icons.bookmark_added
                                                    : Icons
                                                        .bookmark_add_outlined,
                                                color: user.savedWorkers
                                                        .contains(
                                                  user.uid,
                                                )
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
                                    Text(
                                      'About',
                                      style: AppTextStyle.textBold.copyWith(
                                        fontSize: 16,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      user.about,
                                      style:
                                          AppTextStyle.displayRegular.copyWith(
                                        fontSize: 12,
                                        color: AppColors.black,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                 
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Experience',
                                      style: AppTextStyle.textBold.copyWith(
                                        fontSize: 16,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      '${user.experience} years',
                                      style:
                                          AppTextStyle.displayRegular.copyWith(
                                        fontSize: 12,
                                        color: AppColors.black,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                      const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Skills',
                                      style: AppTextStyle.textBold.copyWith(
                                        fontSize: 16,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                     SizedBox(
                                        width: double.infinity,
                                        child: Wrap(
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          spacing: 6,
                                          runSpacing: 8,
                                          children: user.skills.map((skill) {
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
                                    SizedBox(
                                      height: 250,
                                      child: Image.network(
                                        user.photoUrl,
                                        width: double.maxFinite,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),

                                ////// //////////////////////////////       BOTTOM RESPONSE BUTTON       ///////////////////////////////////
                                // (user.status !=
                                //             UiConstants
                                //                 .complaintStatus[0] &&
                                //         complaint.status !=
                                //             UiConstants
                                //                 .complaintStatus[1])
                                //     ? CompliantStatusMessage(
                                //         user: user,
                                //         complaint: complaint,
                                //       )
                                //     : user.role !=
                                //             UiConstants.userRoles[1]
                                //         ? Row(
                                //             crossAxisAlignment:
                                //                 CrossAxisAlignment.end,
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.center,
                                //             children: <Widget>[
                                //               InkWell(
                                //                 onTap: () =>
                                //                     showCustomSnackbar(
                                //                   context,
                                //                   "Double Tap to Reject the complaint",
                                //                 ),
                                //                 onDoubleTap: () async {
                                //                   showModalBottomSheet(
                                //                     context: context,
                                //                     builder: (context) =>
                                //                         RejectComplaintBottomSheet(
                                //                       complaint:
                                //                           complaint,
                                //                     ),
                                //                   );
                                //                 },
                                //                 child: Container(
                                //                   //color: Color(0xFF181D3D),
                                //                   width: (0.9 *
                                //                               MediaQuery.of(
                                //                                       context)
                                //                                   .size
                                //                                   .width -
                                //                           25) /
                                //                       3,
                                //                   height: (0.6 *
                                //                           MediaQuery.of(
                                //                                   context)
                                //                               .size
                                //                               .height) /
                                //                       9,
                                //                   decoration:
                                //                       BoxDecoration(
                                //                     color:
                                //                         Colors.deepOrange,
                                //                     shape: BoxShape
                                //                         .rectangle,
                                //                     borderRadius:
                                //                         BorderRadius.only(
                                //                       topLeft: Radius.circular((0.6 *
                                //                               MediaQuery.of(
                                //                                       context)
                                //                                   .size
                                //                                   .height) /
                                //                           20),
                                //                       bottomLeft:
                                //                           Radius.circular(
                                //                         (0.6 *
                                //                                 MediaQuery.of(
                                //                                         context)
                                //                                     .size
                                //                                     .height) /
                                //                             20,
                                //                       ),
                                //                       topRight:
                                //                           Radius.zero,
                                //                       bottomRight:
                                //                           Radius.zero,
                                //                     ),
                                //                   ),
                                //                   child: const Center(
                                //                     child: Text(
                                //                       "Reject",
                                //                       style: TextStyle(
                                //                         color:
                                //                             Colors.white,
                                //                       ),
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ),
                                //               const VerticalDivider(
                                //                 color: Color.fromRGBO(
                                //                     58, 128, 203, 1),
                                //                 width: 1.0,
                                //               ),

                                //               ///////////////////////////////////////// Approve  /////////////////////////////
                                //               InkWell(
                                //                 onTap: () =>
                                //                     showCustomSnackbar(
                                //                   context,
                                //                   "Double Tap to Approve the complaint",
                                //                 ),
                                //                 onDoubleTap: () async {
                                //                   // if (snapshot.data!['status'] !=
                                //                   //     status[2]) {
                                //                   //   await ComplaintFiling()
                                //                   //       .complaints
                                //                   //       .doc(widget._workerID)
                                //                   //       .update({'status': status[1]});
                                //                   // }
                                //                   showModalBottomSheet(
                                //                     context: context,
                                //                     builder: (context) =>
                                //                         ApproveComplaintBottomSheet(
                                //                       complaint:
                                //                           complaint,
                                //                     ),
                                //                   );
                                //                 },
                                //                 child: Container(
                                //                   //color: Color(0xFF181D3D),
                                //                   width: (0.9 *
                                //                               MediaQuery.of(
                                //                                       context)
                                //                                   .size
                                //                                   .width -
                                //                           25) /
                                //                       3,
                                //                   height: (0.6 *
                                //                           MediaQuery.of(
                                //                                   context)
                                //                               .size
                                //                               .height) /
                                //                       9,
                                //                   decoration:
                                //                       BoxDecoration(
                                //                     color: const Color(
                                //                         0xFF181D3D),
                                //                     shape: BoxShape
                                //                         .rectangle,
                                //                     borderRadius: user
                                //                                 .role ==
                                //                             UiConstants
                                //                                 .userRoles[2]
                                //                         ? BorderRadius.only(
                                //                             topLeft:
                                //                                 Radius
                                //                                     .zero,
                                //                             bottomLeft:
                                //                                 Radius
                                //                                     .zero,
                                //                             topRight: Radius
                                //                                 .circular((0.6 *
                                //                                         MediaQuery.of(
                                //                                           context,
                                //                                         ).size.height) /
                                //                                     20),
                                //                             bottomRight:
                                //                                 Radius
                                //                                     .circular(
                                //                               (0.6 *
                                //                                       MediaQuery.of(
                                //                                         context,
                                //                                       ).size.height) /
                                //                                   20,
                                //                             ),
                                //                           )
                                //                         : null,
                                //                   ),
                                //                   child: Center(
                                //                     child: Text(
                                //                       complaint.status ==
                                //                               UiConstants
                                //                                   .complaintStatus[2]
                                //                           ? "Approved"
                                //                           : "Approve",
                                //                       textAlign: TextAlign
                                //                           .center,
                                //                       style:
                                //                           const TextStyle(
                                //                         color:
                                //                             Colors.white,
                                //                       ),
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ),
                                //               const VerticalDivider(
                                //                 color: Color.fromRGBO(
                                //                     58, 128, 203, 1),
                                //                 width: 1.0,
                                //               ),

                                //               /////////////////////////////////          Solved          //////////////////////////
                                //               user.role ==
                                //                       UiConstants
                                //                           .userRoles[0]
                                //                   ? InkWell(
                                //                       onTap: () =>
                                //                           showCustomSnackbar(
                                //                         context,
                                //                         "Double Tap to Solve the complaint",
                                //                       ),
                                //                       onDoubleTap:
                                //                           () async {
                                //                         // if (snapshot.data!['status'] !=
                                //                         //     status[2]) {
                                //                         //   //await snapshot.data.data().update('status', (value) => status[4]);
                                //                         //   await ComplaintFiling()
                                //                         //       .complaints
                                //                         //       .doc(widget._workerID)
                                //                         //       .update({'status': status[3]});
                                //                         // }
                                //                         showModalBottomSheet(
                                //                           context:
                                //                               context,
                                //                           builder:
                                //                               (context) =>
                                //                                   SolveComplaintBottomSheet(
                                //                             complaint:
                                //                                 complaint,
                                //                           ),
                                //                         );
                                //                       },
                                //                       child: Container(
                                //                         //color: Color(0xFF181D3D),
                                //                         width: (0.9 *
                                //                                     MediaQuery.of(context)
                                //                                         .size
                                //                                         .width -
                                //                                 25) /
                                //                             3,
                                //                         height: (0.6 *
                                //                                 MediaQuery.of(
                                //                                         context)
                                //                                     .size
                                //                                     .height) /
                                //                             9,
                                //                         decoration:
                                //                             BoxDecoration(
                                //                           color: Colors
                                //                               .green,
                                //                           shape: BoxShape
                                //                               .rectangle,
                                //                           borderRadius:
                                //                               BorderRadius
                                //                                   .only(
                                //                             topLeft:
                                //                                 Radius
                                //                                     .zero,
                                //                             bottomLeft:
                                //                                 Radius
                                //                                     .zero,
                                //                             topRight: Radius
                                //                                 .circular((0.6 *
                                //                                         MediaQuery.of(
                                //                                           context,
                                //                                         ).size.height) /
                                //                                     20),
                                //                             bottomRight:
                                //                                 Radius
                                //                                     .circular(
                                //                               (0.6 *
                                //                                       MediaQuery.of(
                                //                                         context,
                                //                                       ).size.height) /
                                //                                   20,
                                //                             ),
                                //                           ),
                                //                         ),
                                //                         child:
                                //                             const Center(
                                //                           child: Text(
                                //                             "Solved",
                                //                             style:
                                //                                 TextStyle(
                                //                               color: Colors
                                //                                   .white,
                                //                             ),
                                //                           ),
                                //                         ),
                                //                       ),
                                //                     )
                                //                   : const SizedBox(),
                                //             ],
                                //           )
                                //         : const SizedBox(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
          },
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
