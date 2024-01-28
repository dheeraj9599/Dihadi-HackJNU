import 'package:carousel_slider/carousel_slider.dart';
import 'package:dihadi/features/auth/controller/auth_controller.dart';
import 'package:dihadi/features/worker/controller/worker_controller.dart';
import 'package:dihadi/routes/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../constants/app_constant.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../models/job.dart';
import '../../../theme/theme.dart';
import '../../jobs/controller/job_controller.dart';
import '../widgets/dashboard_widgets.dart';

class DashboardScreen extends ConsumerWidget {
 const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final currentUser = ref.watch(userProvider)!;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ref.watch(userJobProvider).when(
                data: (jobs) {
                  return ref.watch(userJobProvider).when(
                        data: (event) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: [
                                    const  CircleAvatar(
                                        radius: 28.0,
                                        backgroundImage:  AssetImage(
                                                IMAGE_PATH_DEFAULT_USER_PROFILE_IMAGE,
                                              ),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            currentUser.name,
                                            style: AppTextStyle.displayHeavy
                                                .copyWith(
                                              color: AppColors.black,
                                              fontSize: 24.0,
                                            ),
                                          ),
                                          Text(
                                            currentUser.email,
                                            style: AppTextStyle.displayLight
                                                .copyWith(
                                              color: AppColors.subTitleColor,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: IconButton(
                                      iconSize: 32,
                                      onPressed: () {
                                        Navigation.navigateToChatBotScreen(context);
                                      },
                                      icon: const Icon(
                                        Icons.support_agent,
                                        color: AppColors.pinkAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              OverallDetailsCard(
                                cardGradient: AppColors.roundedButtonGradient,
                                title: 'Total Jobs',
                                icon: Icons.stacked_line_chart_sharp,
                                data: jobs.length.toString(),
                              ),
                              OverallDetailsCard(
                                cardGradient: AppColors.blueGradient,
                                title: 'Total Workers',
                                icon: Icons.stacked_line_chart_sharp,
                                data: event.length.toString(),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              PostsOverviewHeader(
                                heading: 'Latest Events',
                                onPressed: () {},
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              CarouselSlider(
                                options: CarouselOptions(
                                  height: 320,
                                  aspectRatio: 2.0,
                                  viewportFraction: 1,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(
                                    seconds: 6,
                                  ),
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: true,
                                  pageSnapping: true,
                                ),
                                items:jobs.map((complaint) {
                                  return LatestComplaintsCard(
                                    user: currentUser,
                                    complaint: complaint,
                                  );
                                }).toList(),
                              ),
                              const SizedBox(
                              height: 12,
                              ),
                              PostsOverviewHeader(
                                heading: 'Latest Jobs',
                                onPressed: () {},
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              ref.watch(userJobProvider).when(
                                    data: (events) {
                                      return StaggeredGridView.countBuilder(
                                        staggeredTileBuilder: (index) =>
                                            const StaggeredTile.fit(1),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        itemBuilder: (context, index) {
                                          events.sort(
                                            (a, b) => b.postedAt.compareTo(
                                              a.postedAt,
                                            ),
                                          ); // Sort by postedAt in descending order

                                          if (index % 2 == 1 &&
                                              (index - 1) % 4 == 0) {
                                            return const SizedBox(height: 32.0);
                                          }

                                          return LatestJobsCard(
                                            size: size,
                                            event: events[index],
                                          );
                                        },
                                        itemCount: events.length > 5
                                            ? 5
                                            : events.length,
                                      );
                                    },
                                    error: (error, stackTrace) => ErrorText(
                                      error: error.toString(),
                                    ),
                                    loading: () => const Loader(),
                                  ),
                         
                              
                            ],
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
        ),
      ),
    );
  }
}
