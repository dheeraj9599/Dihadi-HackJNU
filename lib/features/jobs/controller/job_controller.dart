//controller
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihadi/apis/jobs_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

import '../../../core/utils/snackbar.dart';

import '../../../models/job.dart';
import '../../auth/controller/auth_controller.dart';

final jobControllerProvider = StateNotifierProvider<JobController, bool>((ref) {
  final communityRepository = ref.watch(jobRepositoryProvider);

  return JobController(articleRepository: communityRepository, ref: ref);
});
final userJobProvider = StreamProvider((ref) {
  final jobController = ref.watch(jobControllerProvider.notifier);
  return jobController.fatchUserJobs();
});

// final userCommunityArticleProvider =
//     StreamProvider.family((ref, Set<Community> communities) {
//   final jobController = ref.watch(jobControllerProvider.notifier);
//   return jobController.fatchUserCommunityJobs(communities);
// });

final getJobByIdProvider = StreamProvider.family((ref, String articleId) {
  final jobController = ref.watch(jobControllerProvider.notifier);
  return jobController.getArticleById(articleId);
});

class JobController extends StateNotifier<bool> {
  final JobsRepository _jobRepository;
  final Ref _ref;

  JobController({
    required JobsRepository articleRepository,
    required Ref ref,
  })  : _jobRepository = articleRepository,
        _ref = ref,
        super(false);

  void saveJobToDatabase({
    required BuildContext context,
    required String title,
    required String responsibility,
    required List<String> skills,
    required DateTime startDate,
    required WidgetRef ref,
    required String contact,
  }) async {
    state = true; // Loading has Started
    String jobId = const Uuid().v1();
    final userId = ref.read(userProvider)!.uid;

    final Jobs job = Jobs(
      id: jobId,
      title: title,
      postedAt: Timestamp.now(),
      startDate: Timestamp.fromDate(startDate),
      contractor: userId,
      responsibility: responsibility,
      skills: skills,
      status: 'active',
      contractorContact: contact,
      applicants: [],
    );
    final res = await _jobRepository.addJob(job);

    state = false;
    res.fold((l) {
      showCustomSnackbar(context, l.message);
    }, (r) {
      showCustomSnackbar(context, 'Posted successfully!');
      Routemaster.of(context).pop();
    });
  }

  Stream<List<Jobs>> fatchUserJobs() {
    return _jobRepository.fatchUserJobs();
  }

  // Stream<List<Jobs>> fatchUserCommunityJobs(
  //     List<Community> communities) {
  //   if (communities.isNotEmpty) {
  //     return _jobRepository.fatchUserCommunityJobs(communities);
  //   }
  //   return Stream.value([]);
  // }
// Stream<Set<Jobs>> fatchUserCommunityJobs(Set<Community> communities) {
//     return _jobRepository.fatchUserCommunityJobs(communities)
//         .map((list) => Set.from(list));
//   }

  Future<void> applyForJob(
    String jobId,
  ) async {
    final userId = _ref.read(userProvider)!.uid;
    await _jobRepository.applyForJob(jobId, userId);
  }

  Stream<Jobs> getArticleById(String articleId) {
    return _jobRepository.getArticleById(articleId);
  }

  void deleteArticle(Jobs article, BuildContext context) async {
    final res = await _jobRepository.deleteArticle(article);
    res.fold((l) => null,
        (r) => showCustomSnackbar(context, 'Article Deleted Successfully!'));
  }
}
