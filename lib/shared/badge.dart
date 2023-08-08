import 'package:flutter/material.dart';

class ReactionBadge extends StatelessWidget {
  final Widget? label;
  final Widget child;
  final Color badgeColor;
  final Color textColor;

  const ReactionBadge({
    Key? key,
    required this.label,
    required this.child,
    this.badgeColor = Colors.red,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        child,
        if (label != null)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: badgeColor,
                shape: BoxShape.circle,
              ),
              child: label,
            ),
          ),
      ],
    );
  }
}
