import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets.dart';
import '../../application/providers/auth_provider.dart';
import '../../domain/dtos/login_dto.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  LoginDto _loginDto = const LoginDto(email: '', password: '');

  void _onEmailChanged(String email) =>
      setState(() => _loginDto = _loginDto.copyWith(email: email));

  void _onPasswordChanged(String password) =>
      setState(() => _loginDto = _loginDto.copyWith(password: password));

  Future<void> _login() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final res = await ref.read(authProvider.notifier).login(_loginDto);

    if (res || !mounted) return;

    // ignore: use_build_context_synchronously
    showSnackBar(
      context,
      title: const Text('Login details were not accepted'),
      backgroundColor: Colors.red.shade200,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageBody(
        child: SingleChildScrollView(
          child: Padding(
            padding: defaultFormPadding,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    validator: isRequired(context),
                    initialValue: _loginDto.email,
                    onChanged: _onEmailChanged,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: isRequired(context),
                    initialValue: _loginDto.password,
                    onChanged: _onPasswordChanged,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('Log in'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
