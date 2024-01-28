import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

import '../../../apis/auth_api.dart';
import '../../../constants/app_constant.dart';
import '../../../core/utils/snackbar.dart';
import '../../../models/user.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authAPI: ref.watch(authApiProvider),
    ref: ref,
  ),
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final Ref _ref;
  AuthController({required AuthAPI authAPI, required Ref ref})
      : _authAPI = authAPI,
        _ref = ref,
        super(false); // loading while asynchronous tasks initially false

  Stream<User?> get authStateChange => _authAPI.authStateChanges;

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String dob,
    required String phone,
    required String about,
    required String experience,
    required List<String> skills,
    required String service,
    required String portfolioUrl,
    required String role,
    required BuildContext context,
  }) async {
    final uid
     = Uuid().v1();
    UserModel _userModel = UserModel(
      uid: uid,
      name: name,
      email: email,
      photoUrl: '',
      about: about,
      phone: phone,
      dob: dob,
      experience: experience,
      skills: skills,
      service: service,
      portfolioUrl: portfolioUrl,
      myJobs: [],
      savedJobs: [],
      role: role, savedWorkers: [],
    );
    state = true; // loading starts
    final res = await _authAPI.registerWithEmailAndPassword(
      userModel: _userModel,
      password: password,
    );
    state = false;
    res.fold((l) {
      print(l.message);
      showCustomSnackbar(context, l.message);
    }, (userModel) {
      _ref.read(userProvider.notifier).update(
            (state) => userModel,
          );
    });
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    print('login');

    final res = await _ref.read(authApiProvider).logIn(
          email: email,
          password: password,
        );
    state = false;
    res.fold(
      (l) {
        print(l.message);
        showCustomSnackbar(context, l.message);
      },
      (UserModel) {
        // if (UserModel.emailVerified) {
        //   _ref.read(userProvider.notifier).update((state) => UserModel);
        // } else {
        _ref.read(userProvider.notifier).update((state) => UserModel);
        // }
      },
    );
  }

  void sandVerificationEmail({
    required String email,
    required BuildContext context,
  }) async {
    // final res = await _ref.read(authApiProvider).sandVerificationEmail(
    //       email: email,
    //     );
    // res.fold(
    //   (l) => showCustomSnackbar(
    //     context,
    //     l.message,
    //   ),
    //   (r) => showCustomSnackbar(
    //     context,
    //     TEXT_VERIFY_EMAIL_SENT_SUCCESS_MESSAGE,
    //   ),
    // );
  }

  void logOut() {
    _ref.read(authApiProvider).logOut();
    _ref.read(userProvider.notifier).update((state) => null);
  }
}
