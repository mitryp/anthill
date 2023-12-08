import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'snack_bar_content.dart';

class CopyLinkButton extends StatelessWidget {
  final String _link;

  const CopyLinkButton({required String link, super.key}) : _link = link;

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
    final link = Uri.parse(_link).isAbsolute ? _link : _sameOriginLink(_link);

    await Clipboard.setData(ClipboardData(text: link));

    // ignore: use_build_context_synchronously
    showSnackBar(
      context,
      title: const Text('Copied to clipboard'),
      backgroundColor: Colors.lightGreen,
    );
  }
}
