import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:universal_html/html.dart';

import '../../../../shared/typedefs.dart';
import '../../../users/users_module.dart';
import '../../domain/dtos/login_dto.dart';

/// Provides methods to control the authentication process:
/// [restore] and [login].
class AuthService {
  static const _apiPrefix = 'auth';

  final Dio client;

  const AuthService(this.client);

  /// Tries to login with the given [loginDto].
  ///
  /// Returns a boolean value representing the result of login.
  /// If returned true, the [restore] method is guaranteed to succeed.
  Future<bool> login(LoginDto loginDto) => client
      .post('$_apiPrefix/login', data: loginDto.toJson())
      .then(_decodeLoginResponse)
      .onError(_printErrorAndReturn(false));

  /// Asks the server to invalidate current session.
  ///
  /// If was successfully invalidated, returns true.
  Future<bool> logoff() => client
      .post('$_apiPrefix/logoff')
      .then(_decodeLogoffResponse)
      .onError(_printErrorAndReturn(false));

  /// Tries to restore the present session.
  ///
  /// As there is no way to know if the access token is present, it's necessary to
  /// call this method every time before calling [login] if necessary.
  Future<UserReadDto?> restore() => client
      .post<JsonMap>('$_apiPrefix/restore')
      .then(_decodeRestoreResponse)
      .onError(_printErrorAndReturn(null));

  bool _decodeLoginResponse(Response res) => res.statusCode == HttpStatus.created;

  bool _decodeLogoffResponse(Response res) => res.statusCode == HttpStatus.ok;

  UserReadDto? _decodeRestoreResponse(Response<JsonMap> res) {
    final data = res.data;

    if (data == null) {
      return null;
    }

    return UserReadDto.fromJson(data);
  }
}

T Function(Object? err, StackTrace stackTrace) _printErrorAndReturn<T>(T returnValue) =>
    (err, stackTrace) {
      log('[AuthService] [info]: Caught $err');
      return returnValue;
    };
