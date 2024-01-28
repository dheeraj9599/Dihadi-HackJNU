import 'package:dihadi/features/chatbot/views/chat_bot_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import '../features/auth/views/auth_screen.dart';
import '../features/auth/views/verify_email_screen.dart';
import '../features/home/views/home_screen.dart';
import '../features/jobs/views/job_details_screen.dart';
import '../features/jobs/views/new_job_screen.dart';
import '../features/message/view/message_screen.dart';
import '../features/worker/view/worker_details_screen.dart';
import '../features/worker/view/feeds/my_complaints_feed.dart';
import '../features/worker/view/new_complaint_add_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (route) => const MaterialPage(
        child: AuthScreen(),
      ),
});
final loggedInRoute = RouteMap(routes: {
  '/': (route) => const MaterialPage(
        child: HomeScreen(),
      ),
  '/new-complaint': (route) => const MaterialPage(
        child: NewComplaintFormScreen(),
      ),

  '/new-job': (route) => const MaterialPage(
        child: NewJobFormScreen(),
      ),

  '/worker/:workerId': (routeData) {
    final workerId = routeData.pathParameters['workerId']!;
    return MaterialPage(
      child: WorkerDetailsScreen(
        workerId: workerId,
      ),
    );
  },
'/one-to-one-chat/:userId': (route) {
    final userId = route.pathParameters['userId'];
    return MaterialPage(
      child: OneToOneChatScreen(
        userId: userId!,
      ),
    );
  },

  '/chat-bot': (routeData) {

    return const MaterialPage(
      
      child: ChatBotScreen(
      ),
    );
  },

  '/job/:jobId': (routeData) {
    final jobId = routeData.pathParameters['jobId']!;
    return MaterialPage(
      child: JobsDetailsScreen(
        jobId: jobId,
      ),
    );
  },
});
