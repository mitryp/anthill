import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modules/auth/presentation/pages/login_page.dart';
import 'router.dart';
import '../../modules/auth/presentation/loader.dart';

class AnthillApp extends StatelessWidget {
  const AnthillApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = buildRouter(context);

    return ProviderScope(
      child: Loader(
        loginPage: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Login | Anthill',
          home: LoginPage(),
        ),
        child: MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          title: 'Anthill',
        ),
      ),
    );
  }
}
