import 'package:dio/dio.dart';

class AuthService {
  final Dio client;

  const AuthService(this.client);

  // todo auth instead of this
  Future<bool> isAuthorized() => Future.delayed(const Duration(seconds: 1), () => true);
}
