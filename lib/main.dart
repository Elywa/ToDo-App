import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:to_do/auth/register/register_view.dart';
import 'package:to_do/firebase_options.dart';
import 'package:to_do/home/home_view.dart';
import 'package:to_do/home/task_list/edit_task_view.dart';
import 'package:to_do/providers/list_provider.dart';
import 'package:to_do/theme.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // عشان اكيش الداتا اوفلاين عندى ع الجهاز بحط السطرين دول
  await FirebaseFirestore.instance.disableNetwork();
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(ChangeNotifierProvider(
      create: (context) => ListProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: RegisterView.routeName,
      routes: {
        HomeView.routeName: (context) => HomeView(),
        RegisterView.routeName: (context) => const RegisterView()
      },
    );
  }
}
