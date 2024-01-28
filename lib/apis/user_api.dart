import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

import '../constants/app_constant.dart';
import '../constants/firebase_constants.dart';
import '../core/api_config.dart';
import '../core/providers.dart';
import '../core/utils/error_hendling.dart';
import '../core/core.dart';
import '../models/user.dart';
import 'apis.dart';

final userApiProvider = Provider((ref) {
  return UserAPI(
    firestore: ref.watch(firestoreProvider)
  );
});

abstract class IUserAPI {

  FutureEither updateUser({
    required UserModel userModel,
  });
  Stream<UserModel> getUserDataById(String uid) ;
}

class UserAPI implements IUserAPI {
  final FirebaseFirestore _firestore;

  UserAPI({
    required    FirebaseFirestore firestore,

  })  :
        _firestore = firestore;

 CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.user);


  @override
  Stream<UserModel> getUserDataById(String uid) {
    return _users.doc(uid).snapshots().distinct().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>,),);
  }

  Stream<List<UserModel>> getAllUsers() {
  return _users.snapshots().map((event) => event.docs
            .map(
              (e) => UserModel.fromMap(
                e.data() as Map<String, dynamic>,
              ),
            )
            .toList(),);
  }


  @override
  FutureEither updateUser({
    required UserModel userModel,
  }) async {
      try {
      return right(_users.doc(userModel.email).update(userModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
