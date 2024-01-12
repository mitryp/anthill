import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_html/html.dart';

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

  String _sameOriginLink(String path) => Uri.base.resolve('/#${path.startsWith('/') ? '' : '/'}$path').toString();

  Future<void> _copyLink(BuildContext context) async {
    final rawLink = _link ?? window.location.href;
    final link = Uri.parse(rawLink).hasAuthority ? rawLink : _sameOriginLink(rawLink);

    await Clipboard.setData(ClipboardData(text: link));

    // ignore: use_build_context_synchronously
    showSnackBar(
      context,
      title: Text('Copied to clipboard: $link'),
      backgroundColor: Colors.lightGreen,
    );
  }
}
