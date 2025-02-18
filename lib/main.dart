import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ott102/data/repositories/shared_pref_repository.dart';
import 'package:ott102/presentation/screens/launch_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final supportedLocales = [
  Locale('en', 'US'),
  Locale('ko', 'KR'),
  Locale('fr', 'FR'),
  Locale('es', 'ES'),
  Locale('ja', 'JP'),
];

late final SharedPrefRepository sharedPrefRepository;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  sharedPrefRepository =
      SharedPrefRepository(await SharedPreferences.getInstance());

  runApp(
    EasyLocalization(
        supportedLocales: supportedLocales,
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: LaunchScreen(),
    );
  }
}
