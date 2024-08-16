import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:universal_html/html.dart';

import '../../pagination.dart';
import '../../widgets.dart';

class CopyLinkButton extends StatelessWidget {
  final String? _link;

  const CopyLinkButton({String? link, super.key}) : _link = link;

  static void updateProviderWithParams({
    required Map<String, Object> params,
    required BuildContext context,
    GoRouterState? state,
  }) {
    state ??= GoRouterState.of(context);

    final uri = state.uri.cleanWithParams(params);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ProviderScope.containerOf(context).read(shareLinkProvider.notifier).update(
            Uri.base.resolve('#$uri').toString(),
          );
    });
  }

  static Widget fromProvider() => Consumer(
        builder: (context, ref, child) => CopyLinkButton(
          link: ref.watch(shareLinkProvider),
        ),
      );

  @override
  Widget build(BuildContext context) => IconButton(
        padding: const EdgeInsets.all(16),
        onPressed: () => _copyLink(context),
        icon: const Icon(Icons.share),
        tooltip: context.locale.copyLinkButtonTooltip,
      );

  String _sameOriginLink(String path) =>
      Uri.base.resolve('/#${path.startsWith('/') ? '' : '/'}$path').toString();

  Future<void> _copyLink(BuildContext context) async {
    final locale = context.locale;
    final rawLink = _link ?? window.location.href;
    final link = Uri.parse(rawLink).hasAuthority ? rawLink : _sameOriginLink(rawLink);

    await Clipboard.setData(ClipboardData(text: link));

    if (!context.mounted) {
      return;
    }

    showSnackBar(
      context,
      title: Text(locale.copyLinkButtonConfirmation(link)),
      backgroundColor: Colors.lightGreen,
    );
  }
}
