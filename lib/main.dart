import 'package:app_example/dependency_setup.dart';
import 'package:app_example/firebase_options.dart';
import 'package:app_example/navigation/navigation_service.dart';
import 'package:app_example/navigation/route_generator.dart';
import 'package:app_example/notification/notification_service.dart';
import 'package:app_example/style/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DependencySetup.registerDependencies();
  await Hive.initFlutter();
  await Get.find<NotificationService>().init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        navigatorKey: Get.find<NavigationService>()
            .navigatorKey, // <-- our navigation key
        theme: ThemeData(
            primarySwatch: Colors.brown,
            dialogBackgroundColor: AppColors.dialogBackground,
            scaffoldBackgroundColor: AppColors.appBackground),
        initialRoute: _user != null ? '/home' : '/',
        onGenerateRoute: (settings) =>
            RouteGenerator().generateRoute(settings));
  }
}
