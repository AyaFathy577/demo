import 'package:demo/constants/functions.dart';
import 'package:demo/constants/variables.dart';
import 'package:demo/data_layer/providers/language_provider.dart';
import 'package:demo/localization/localization.dart';
import 'package:demo/app_routes.dart';
import 'package:demo/presentation_layer/screens/home_screen.dart';
import 'package:demo/presentation_layer/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(context, newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late LanguageProvider provider;

  setLocale(BuildContext context, Locale locale) {
    provider = Provider.of<LanguageProvider>(context, listen: false);
    provider.updateLanguage(locale);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Functions.getProviders(),
      child: Consumer<LanguageProvider>(builder: (context, provider, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          locale: provider.locale,
          supportedLocales: const [
            Locale(Variables.englishLangCode, Variables.englishCountryCode),
            Locale(Variables.arabicLangCode, Variables.arabicCountryCode),
          ],
          localizationsDelegates: const [
            Localization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          onGenerateRoute: AppRoutes().generateRoute,
          home: const SplashScreen(),
        );
      }),
    );
  }
}
