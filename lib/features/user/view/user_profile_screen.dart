
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_constant.dart';
import '../../../core/common/alert_dialog.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../routes/route_utils.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_style.dart';
import '../../auth/controller/auth_controller.dart';
import '../controller/user_controller.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String userId;
  const UserProfileScreen({super.key, required this.userId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: ref.watch(getUserDataByIdProvider(widget.userId)).when(
            data: (user) {
              return Stack(
                children: [
                  Container(
                    height: 230,
                    decoration: BoxDecoration(
                      gradient: AppColors.orangeGradient,
                    ),
                  ),
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        centerTitle: true,
                        pinned: true,
                        elevation: 0,
                        backgroundColor: Colors.white,
                        expandedHeight: 140,
                        flexibleSpace: LayoutBuilder(
                          builder: (context, constraints) {
                            return FlexibleSpaceBar(
                              title: AnimatedOpacity(
                                duration: const Duration(milliseconds: 200),
                                opacity:
                                    constraints.biggest.height <= 120 ? 1 : 0,
                                child: const Text(
                                  'My Profile',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              background: Container(
                                decoration: BoxDecoration(
                                    gradient: AppColors.orangeGradient),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 25, left: 30),
                                  child: Row(
                                    children: [
                                      user!.photoUrl == ''
                                          ? const CircleAvatar(
                                              radius: 50,
                                              backgroundImage: AssetImage(
                                                IMAGE_PATH_DEFAULT_USER_PROFILE_IMAGE,
                                              ),
                                            )
                                          : CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage(
                                                user.photoUrl,
                                              ),
                                            ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25),
                                        child: Text(
                                          user.name.toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 239, 240, 255),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.purpleColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () => Navigation
                                          .navigateToJoinedEventsScreen(
                                        context,
                                      ),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            'Chats Joined',
                                            textAlign: TextAlign.center,
                                            style:
                                                AppTextStyle.textBold.copyWith(
                                              color: AppColors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: AppColors.pinkAccent,
                                    child: TextButton(
                                        onPressed: () => Navigation
                                                .navigateToMyComplaintsScreen(
                                              context,
                                            ),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          height: 50,
                                          child: Center(
                                            child: Text(
                                              'My Jobs',
                                              textAlign: TextAlign.center,
                                              style: AppTextStyle.textBold
                                                  .copyWith(
                                                color: AppColors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.purpleColor,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: TextButton(
                                        onPressed: () => Navigation
                                                .navigateToIssuedEquipmentScreen(
                                              context,
                                            ),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          height: 50,
                                          child: Center(
                                            child: Text(
                                              'Active App',
                                              textAlign: TextAlign.center,
                                              style: AppTextStyle.textBold
                                                  .copyWith(
                                                color: AppColors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              children: [
                                Column(
                                  children: [
                                    const ProfileHeaderLabel(
                                      headerLabel: '  Account Info.  ',
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 260,
                                        decoration: BoxDecoration(
                                          color: AppColors.lightPurpleColor,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Column(
                                          children: [
                                            RepeatedListTile(
                                              title: 'Email Address',
                                              subTitle: user!.email == ''
                                                  ? 'example@gmail.com'
                                                  : user.email,
                                              icon: Icons.email,
                                              onPressed: () {},
                                            ),
                                            const YellowDivider(),
                                            RepeatedListTile(
                                                title: 'Service',
                                                subTitle: user.service,
                                                icon: Icons.book,
                                                onPressed: () {}),
                                            const YellowDivider(),
                                            RepeatedListTile(
                                              title: 'Experience',
                                              subTitle: user.experience,
                                              icon: Icons.location_pin,
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const ProfileHeaderLabel(
                                        headerLabel: '  Account Settings  '),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 260,
                                        decoration: BoxDecoration(
                                          color: AppColors.lightPurpleColor,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Column(
                                          children: [
                                            RepeatedListTile(
                                              title: 'Edit Profile',
                                              subTitle: '',
                                              icon: Icons.edit,
                                              onPressed: () {},
                                            ),
                                            const YellowDivider(),
                                            RepeatedListTile(
                                              title: 'Change Password',
                                              subTitle: '',
                                              icon: Icons.lock,
                                              onPressed: () {},
                                            ),
                                            const YellowDivider(),
                                            RepeatedListTile(
                                              title: 'Log Out',
                                              subTitle: '',
                                              icon: Icons.logout,
                                              onPressed: () async {
                                                MyAlertDialog.showMyDialog(
                                                  context: context,
                                                  title: 'Log Out',
                                                  content:
                                                      'Are you sure to log out ?',
                                                  tabNo: () =>
                                                      Navigator.pop(context),
                                                  tabYes: () async {
                                                    ref
                                                        .read(
                                                            authControllerProvider
                                                                .notifier)
                                                        .logOut();
                                                    Navigator.pop(context);
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
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

class YellowDivider extends StatelessWidget {
  const YellowDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Divider(
        color: Color.fromARGB(103, 166, 161, 252),
        thickness: 1,
      ),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Function()? onPressed;

  const RepeatedListTile({
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(
          title,
        ),
        subtitle: Text(subTitle),
        leading: Icon(icon),
      ),
    );
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  final String headerLabel;
  const ProfileHeaderLabel({
    required this.headerLabel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Text(
            headerLabel,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
