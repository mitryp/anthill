import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'snack_bar_content.dart';

class CopyLinkButton extends StatelessWidget {
  final String? _link;

  const CopyLinkButton({String? link, super.key}) : _link = link;

  @override
  Widget build(BuildContext context) => IconButton(
        padding: const EdgeInsets.all(16),
        onPressed: () => _copyLink(context),
        icon: const Icon(Icons.share),
        tooltip: 'Copy to clipboard',
      );

  String _sameOriginLink(String path) {
    final pathStartIndex = path.indexOf(RegExp(r'[^/]'));
    final cleanPath = pathStartIndex < 0 ? path : path.substring(pathStartIndex);

    return '${Uri.base.origin}/#/$cleanPath';
  }

  Future<void> _copyLink(BuildContext context) async {
    final rawLink = _link ?? GoRouterState.of(context).uri.toString();
    final link = Uri.parse(rawLink).isAbsolute ? rawLink : _sameOriginLink(rawLink);

    await Clipboard.setData(ClipboardData(text: link));

    // ignore: use_build_context_synchronously
    showSnackBar(
      context,
      title: const Text('Copied to clipboard'),
      backgroundColor: Colors.lightGreen,
    );
  }
}
