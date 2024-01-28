
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/user_api.dart';
import '../../../core/utils/snackbar.dart';
import '../../../models/user.dart';
import '../../auth/controller/auth_controller.dart';
import '../../worker/controller/worker_controller.dart';

final userControllerProvider = StateNotifierProvider<UserController, bool>(
  (ref) => UserController(
    userAPI: ref.watch(userApiProvider),
    ref: ref,
  ),
);

final getUserDataByIdProvider = StreamProvider.family((ref, String id) {
  final userController = ref.watch(userControllerProvider.notifier);
  return userController.getUserDataById(id: id);
});
final getAllUsersrovider = StreamProvider((ref,) {
  final userController = ref.watch(userControllerProvider.notifier);
  return userController.getAllUsers();
});
class UserController extends StateNotifier<bool> {
  final UserAPI _userAPI;
  final Ref _ref;
  UserController({required UserAPI userAPI, required Ref ref})
      : _userAPI = userAPI,
        _ref = ref,
        super(false); // loading while asynchronous tasks initially false

  Stream<UserModel> getUserDataById({required String id})  {
    return  _userAPI.getUserDataById(id);
   

    
  }
Stream<List<UserModel>> getAllUsers() {
    return _userAPI.getAllUsers();
}

  Future<void> updateUser({
    required UserModel user,
    required BuildContext context,
  }) async {
    final res = await _userAPI.updateUser(userModel: user);
    res.fold(
      (l) => showCustomSnackbar(context, l.message),
      (r) {
        _ref.read(userProvider.notifier).update((state) => user);
        _ref.invalidate(getUserDataByIdProvider(user.uid));
        // _ref.invalidate(
        //     getBookmarkedComplaintsProvider); // Refresh bookmarkedComplaintsProvider
      },
    );
  }
}
