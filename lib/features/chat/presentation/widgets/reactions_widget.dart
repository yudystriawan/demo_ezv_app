import 'package:flutter/material.dart';

class ReactionsWidget extends StatelessWidget {
  const ReactionsWidget({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final Function(String reaction)? onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 20,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.black54,
        ),
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: reactions.map((e) {
            final isFirst = reactions.first == e;

            return Row(
              children: [
                if (!isFirst)
                  const SizedBox(
                    width: 12,
                  ),
                GestureDetector(
                  onTap: onTap != null ? () => onTap!.call(e) : null,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.indigo,
                    ),
                    width: 24,
                    height: 24,
                    child: Center(
                      child: Text(
                        e,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

final reactions = [':)', ':(', ':|'];
