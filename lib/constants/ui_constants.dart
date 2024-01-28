import 'package:dihadi/features/skills/views/skill_training_screen.dart';
import 'package:dihadi/models/event.dart';
import 'package:flutter/material.dart';

import '../features/jobs/views/jobs_feed_screen.dart';
import '../features/worker/view/workers_feed_screen.dart';
import '../features/worker/view/feeds/all_workers_feed.dart';
import '../features/worker/view/feeds/saved_workers_feed.dart';
import '../features/dashboard/view/dashboard_screen.dart';

import '../features/user/view/user_profile_screen.dart';
import 'app_constant.dart';

class UiConstants {
  static List<Widget> homeTabWidgets(String userId) {
    return [
      const DashboardScreen(),
      const ComplaintsFeedScreen(),
      const SkillAndTraining(
        backNavigationAllowed: false,
      ),
      const JobsFeedScreen(),
      UserProfileScreen(userId: userId),
    ];
  }

  static List<Widget> workersFeed = [
    const AllWorkersFeed(
      backNavigationAllowed: false,
    ),
    const SavedWorkersFeed(
      backNavigationAllowed: false,
    ),
  ];
  // static List<Widget> noticeFeeds = [
  //   const AllNoticeScreen(
  //     backNavigationAllowed: false,
  //   ),
  //   const BookmarkedNoticeScreen(
  //     backNavigationAllowed: false,
  //   ),
  // ];

  static List adminFABIconsList = [
    Icons.add,
  ];

  static const List<String> complaintCategories = [
    'Academic Issues',
    'Administrative Issues',
    'Infrastructure Issues',
    'IT and Technical Issues',
    'Social and Campus Life',
    'Security Concerns',
    'Health and Wellness',
    'Transportation Issues',
    'Diversity and Inclusion',
    'Miscellaneous',
  ];
  static const List<String> universityNoticeCategories = [
    'Academic',
    'Administrative',
    'Events',
    'Announcements',
    'Scholarships',
    'Research Opportunities',
    'Student Activities',
    'Examinations',
    'Graduation',
    'Internship Opportunities',
    'Career Services',
    'Workshops and Seminars',
    'Cultural Events',
    'Sports',
    'Club Activities',
    'Health and Wellness',
    'Holidays',
    'Library Notices',
    'Financial Aid',
    'Student Organizations',
    'Campus Facilities',
    'Technology Updates',
    'Community Outreach',
    'Safety and Security',
    'Student Services',
    'Semester Breaks',
    'Alumni Events',
    'Faculty Meetings',
    'Admissions',
    'Important Deadlines',
    'Special Lectures',
  ];

  static const List<String> userRoles = [
    'contractor',
    'worker',
  ];
  static const List<String> complaintStatus = [
    'pending',
    'inProgress',
    'solved',
    'rejected',
  ];

  static List<Event> skillsCourses = [
    Event(
      id: '1',
      title: 'The Pradhan Mantri Kaushal Vikas Yojana (PMKVY)',
      subtitle: 'A great event',
      description:
          'the flagship scheme of the Ministry of Skill Development and Entrepreneurship (MSDE) implemented by the National Skill Development Corporation (NSDC), focuses on imparting skill development training to youth nationwide, including rural areas',
      campus: 'Main Campus',
      criteria: 'Open to all',
      prize: 100000,
      postedAt: DateTime.now(),
      venueType: 'Indoor',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 2)),
      tags: ['tag1', 'tag2'],
      capacity: 100,
      eventImages: [
        'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
      ],
      organizerInfo: 'Organizer details',
      attendees: [],
      registrationLink:
          'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      contactInfo: 'Contact information',
      eventType: 'Conference',
      location: 'Event Hall',
      feedback: [36],
      admins: ['admin1', 'admin2'],
      createdBy: 'organizer1',
    ),
  ];
}
