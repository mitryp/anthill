import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shareable_url_provider.g.dart';

@riverpod
class ShareableUrl extends _$ShareableUrl {
  @override
  String? build() => state = null;

  void set(String? value) => state = value;
}
