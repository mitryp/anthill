import 'package:flutter/material.dart';

import '../../modules/auth/auth_module.dart';
import 'router.dart';

class AnthillApp extends StatelessWidget {
  const AnthillApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = buildRouter(context);

    return Loader(
      loginPage: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Anthill',
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return const LoginPage();
            },
          );
        },
      ),
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Anthill',
      ),
    );
  }
}
