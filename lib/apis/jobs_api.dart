// repository
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../constants/firebase_constants.dart';
import '../../../core/failure.dart';
import '../../../core/providers.dart';
import '../../../core/type_defs.dart';
import '../../../models/job.dart';

final jobRepositoryProvider = Provider((ref) {
  return JobsRepository(firestore: ref.watch(firestoreProvider));
});

class JobsRepository {
  final FirebaseFirestore _firestore;
  JobsRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _jobs => _firestore.collection(
        FirebaseConstants.jobsCollection,
      );

  FutureEitherVoid addJob(Jobs jobs) async {
    try {
      return right(
        _jobs.doc(jobs.id).set(
              jobs.toMap(),
            ),
      );
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  Stream<List<Jobs>> fatchUserJobs() {
     
    return _jobs
        .orderBy('postedAt', descending: true)
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => Jobs.fromMap(
                e.data() as Map<String, dynamic>,
              ),
            )
            .toList());
  }

  Future<void> applyForJob(String jobId, String userId)async{
      await _jobs.doc(jobId).update({
      'applicants': FieldValue.arrayUnion([userId]),
    });
  }

  // Stream<List<Jobs>> fatchUserCommunityJobs(
  //     List<Community> communities) {
  //   return _Jobs
  //       .where('communityName',
  //           whereIn: communities.map((e) => e.name).toList())
  //       .orderBy('postedOn', descending: true)
  //       .snapshots()
  //       .map((event) => event.docs
  //           .map(
  //             (e) => Jobs.fromMap(e.data() as Map<String, dynamic>),
  //           )
  //           .toList());
  // }

  Stream<Jobs> getArticleById(String articleId) {
    return _jobs
        .doc(articleId)
        .snapshots()
        .map((event) => Jobs.fromMap(event.data() as Map<String, dynamic>));
  }

  FutureEitherVoid deleteArticle(Jobs article) async {
    try {
      return right(_jobs.doc(article.id).delete());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
