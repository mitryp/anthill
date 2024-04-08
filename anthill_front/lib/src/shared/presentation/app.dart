import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../modules/auth/auth_module.dart';
import '../widgets.dart';
import 'router.dart';

class AnthillApp extends StatelessWidget {
  const AnthillApp({super.key});

  @override
  Widget build(BuildContext context) {
    const localizationDelegates = [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];

    final router = buildRouter(context);

    return Loader(
      loginPage: MaterialApp(
        localizationsDelegates: localizationDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => context.locale.appName,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      ),
      child: MaterialApp.router(
        localizationsDelegates: localizationDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => context.locale.appName,
      ),
    );
  }
}
