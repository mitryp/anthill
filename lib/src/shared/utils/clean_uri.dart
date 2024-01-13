extension CleanUri on Uri {
  Uri cleanWithParams(Map<String, Object> params) => resolveUri(
        Uri(
          queryParameters: params.map(
            (key, value) =>
                MapEntry(key, value is List ? value.map((e) => '$e').toList() : '$value'),
          ),
        ),
      );
}
