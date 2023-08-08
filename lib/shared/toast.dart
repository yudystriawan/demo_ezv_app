import 'package:flutter/material.dart';

void showToast(
  BuildContext context, {
  required Widget title,
  Widget? leading,
  Widget? trailing,
}) {
  final content = Row(
    children: [
      if (leading != null) ...[leading, const SizedBox(width: 12)],
      Expanded(child: title),
      if (trailing != null) trailing,
    ],
  );
  ScaffoldMessenger.of(context).showSnackBar(_createSnackbar(content));
}

SnackBar _createSnackbar(Widget content) {
  return SnackBar(
    content: content,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(milliseconds: 1500),
    padding: const EdgeInsets.all(12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}
