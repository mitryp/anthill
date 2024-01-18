import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'share_link_provider.g.dart';

@riverpod
class ShareLink extends _$ShareLink {
  void update(String newValue) => state = newValue;

  @override
  String build() => '';
}
