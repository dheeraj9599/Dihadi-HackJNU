
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import 'core/common/error_text.dart';
import 'core/common/loader.dart';
import 'features/auth/controller/auth_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'features/user/controller/user_controller.dart';
import 'firebase_options.dart';
import 'models/user.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await dotenv.load(fileName: ".env");

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
UserModel? userModel;
  void getUserData(WidgetRef ref, User data) async {
    print('getData called');
    userModel = await ref
        .watch(userControllerProvider.notifier)
        .getUserDataById(id: data.uid.toString())
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
  }



  @override
  Widget build(BuildContext context) {
    print('build');
     return ref.watch(authStateChangeProvider).when(
          data: (data) => MaterialApp.router(
            // if The data available means user is logged in
            debugShowCheckedModeBanner: false,
            title: 'Dihadi',
      theme: ThemeData.light(),
            routerDelegate: RoutemasterDelegate(
              routesBuilder: (context) {
                if (data != null) {
                  print('data != null ? : $data');
                  // if (userModel != null) {
                  if (ref.watch(userProvider) != null) {
                    print(
                        'userProvider.notifier: ${ref.read(userProvider.notifier)}');
                    return loggedInRoute;
                  // }
                  } else {
                    getUserData(ref, data);
                  }
                }
                return loggedOutRoute;
              },
            ),
            routeInformationParser: const RoutemasterParser(),
          ),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
