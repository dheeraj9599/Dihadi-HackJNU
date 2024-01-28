import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

import '../constants/app_constant.dart';
import '../constants/firebase_constants.dart';
import '../core/api_config.dart';
import '../core/providers.dart';
import '../core/utils/error_hendling.dart';
import '../core/core.dart';
import '../models/user.dart';
import 'apis.dart';

final authApiProvider = Provider(
  (ref) => AuthAPI(
    // Now we are using provider for firebase instance as well insted of creating like FirebaseFirestore.instance
    // How I am going to use Firebase provers into this provider?, that is that **ref** is for
    // ref allows us to talk with other providers. IT provides us many methods ref.Read() & ref.Watch most is most important
    // ref.read is usually used out side of build Context means you don't want to read any changes mad in providers
    firestore: ref.read(
        firestoreProvider), //It gives the instance if firebaseFirestore class
    auth: ref.read(
        authProvider), // It all provers coming from firebase_providers.dart
  ),
);

abstract class IAuthAPI {
  FutureEither<UserModel> registerWithEmailAndPassword({
    required UserModel userModel,
    required String password,
  });
  FutureEither<UserModel> logIn({
    required String password,
    required String email,
  });

  void logOut();
  void sandVerificationEmail({required String email});
}

class AuthAPI implements IAuthAPI {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  AuthAPI({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  CollectionReference get _user =>
      _firestore.collection(FirebaseConstants.user);

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  FutureEither<UserModel> registerWithEmailAndPassword({
    required UserModel userModel,
    required String password,
  }) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: password,
      );

      final newUserModel = userModel.copyWith(
          photoUrl: user.additionalUserInfo?.profile?['picture'].toString(),
          uid: user.user!.uid);

      await _user.doc(newUserModel.uid).set(newUserModel.toMap());

      return right(newUserModel);
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  FutureEither<UserModel> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final existingUserModel = await _user.doc(user.user!.uid).get();

      if (existingUserModel.exists) {
        final userModel =
            UserModel.fromMap(existingUserModel.data() as Map<String, dynamic>);
        return right(userModel);
      } else {
        // Handle the case where user data doesn't exist (optional)
        return left(Failure('User data not found.'));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  void logOut() {
    _auth.signOut();
  }

  @override
  void sandVerificationEmail({required String email}) {
    // TODO: implement sandVerificationEmail
  }

  // @override
  // FutureEitherVoid sandVerificationEmail({
  //   required String email,
  // }) async {
  //   try {
  //     final res = await _client.post(
  //       Uri.parse('$hostUrl/api/v1/auth/send-verification-email'),
  //       body: jsonEncode({'email': email}),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );

  //     final apiResponse = handleApiResponse(res);
  //     if (apiResponse.success) {
  //       return right(null);
  //     } else {
  //       return left(
  //         Failure(
  //           apiResponse.error!,
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     return left(
  //       Failure(
  //         e.toString(),
  //       ),
  //     );
  //   }
  // }
}
