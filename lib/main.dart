import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:to_do/auth/login/login_view.dart';
import 'package:to_do/auth/register/register_view.dart';
import 'package:to_do/firebase_options.dart';
import 'package:to_do/home/home_view.dart';
import 'package:to_do/providers/language_provider.dart';
import 'package:to_do/providers/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/providers/list_provider.dart';
import 'package:to_do/providers/user_provider.dart';
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
  // await FirebaseFirestore.instance.disableNetwork();
  // FirebaseFirestore.instance.settings =
  //     Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ListProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var appLanguage = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: themeProvider.myTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: LoginView.routeName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(appLanguage.appLanguage),
      routes: {
        HomeView.routeName: (context) => HomeView(),
        RegisterView.routeName: (context) => RegisterView(),
        LoginView.routeName: (context) => LoginView()
      },
    );
  }
}
