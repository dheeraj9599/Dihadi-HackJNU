import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/ui_constants.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../core/common/search_text_field.dart';
import '../../../models/event.dart';
import '../../../routes/route_utils.dart';
import '../../../theme/theme.dart';
import '../widget/event_card.dart';
import '../widget/popular_training.dart';

class SkillAndTraining extends ConsumerWidget {
  final bool backNavigationAllowed;
  const SkillAndTraining({
    super.key,
    required this.backNavigationAllowed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Training',
          style: AppTextStyle.displayBlack.copyWith(
            color: AppColors.black,
          ),
        ),
        leading: backNavigationAllowed
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_outlined,
                  color: AppColors.black,
                  size: 30,
                ),
                onPressed: () => Navigation.navigateToBack(context),
              )
            : null,
        backgroundColor: AppColors.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Skills and Training.',
                style: AppTextStyle.textHeavy.copyWith(
                  color: AppColors.black,
                  fontSize: 26,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const SearchTextField(),
              const SizedBox(
                height: 18,
              ),
              Text(
                'Popular',
                style: AppTextStyle.textHeavy.copyWith(
                  color: AppColors.black,
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 350,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: UiConstants.skillsCourses.length,
                  itemBuilder: (BuildContext context, int index) {
                      final course = UiConstants.skillsCourses[index];
                    return PopularEventsCard(
                      event:course,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                'All Events',
                style: AppTextStyle.textHeavy.copyWith(
                  color: AppColors.black,
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return EventCard(
                    event: Event(
                      id: '1',
                      title: 'Sample Event',
                      subtitle: 'A great event',
                      description: 'This is a description of the event.',
                      campus: 'Main Campus',
                      criteria: 'Open to all',
                      prize: 100000,
                      postedAt: DateTime.now(),
                      venueType: 'Indoor',
                      startDate: DateTime.now(),
                      endDate: DateTime.now().add(Duration(days: 2)),
                      tags: ['tag1', 'tag2'],
                      capacity: 100,
                      eventImages: ['''https://images.unsplash.com/photo-1511367461989-f85a21fda167?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D''', 'image2.jpg'],
                      organizerInfo: 'Organizer details',
                      attendees: [],
                      registrationLink:
                          'https://images',
                      contactInfo: 'Contact information',
                      eventType: 'Conference',
                      location: 'Event Hall',
                      feedback: [3, 4, 9, 6],
                      admins: ['admin1', 'admin2'],
                      createdBy: 'organizer1',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
