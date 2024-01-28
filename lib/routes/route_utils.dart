import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class Navigation {
  static void navigateToBack(BuildContext context) {
    Routemaster.of(context).pop();
  }

  static void navigateToHome(BuildContext context) {
    Routemaster.of(context).push('/');
  }

  static void navigateToNewComplaintScreen(BuildContext context) {
    Routemaster.of(context).push('/new-complaint');
  }

  static void navigateToNewEventScreen(BuildContext context) {
    Routemaster.of(context).push('/new-event');
  }

  static void navigateToNewJobScreen(BuildContext context) {
    Routemaster.of(context).push('/new-job');
  }

  static void navigateToNewEquipmentScreen(BuildContext context) {
    Routemaster.of(context).push('/new-equipment');
  }

  static void navigateToIssuedEquipmentScreen(BuildContext context) {
    Routemaster.of(context).push('/issued-equipment');
  }

  static void navigateToJoinedEventsScreen(BuildContext context) {
    Routemaster.of(context).push('/joined-events');
  }

  static void navigateToMyComplaintsScreen(BuildContext context) {
    Routemaster.of(context).push('/my-complaints');
  }
  static void navigateToChatBotScreen(BuildContext context) {
    Routemaster.of(context).push('/chat-bot');
  }

  static void navigateToWorkerDetailsScreen(
      BuildContext context, String workerId) {
    Routemaster.of(context).push(
      '/worker/$workerId',
    );
  }

  static void navigateToEventDetailsScreen(
      BuildContext context, String eventId) {
    Routemaster.of(context).push(
      '/event/$eventId',
    );
  }

  static void navigateToEventRegistrationsScreen(
      BuildContext context, String eventId) {
    Routemaster.of(context).push(
      '/event-registrations/$eventId',
    );
  }
  static void navigateToOneToOneChatScreen(
      BuildContext context, String userId) {
    Routemaster.of(context).push('/one-to-one-chat/$userId');
  }
  static void navigateToJobDetailsScreen(
      BuildContext context, String jobId) {
    Routemaster.of(context).push(
      '/job/$jobId',
    );
  }
}
