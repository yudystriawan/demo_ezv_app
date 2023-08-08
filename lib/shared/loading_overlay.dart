import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
    this.size = 50,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class LoadingIndicatorOverlay extends StatelessWidget {
  const LoadingIndicatorOverlay({
    Key? key,
    this.text,
    required this.isLoading,
  }) : super(key: key);

  final bool isLoading;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isLoading,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: isLoading ? Colors.black.withOpacity(0.8) : Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Visibility(
          visible: isLoading,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const LoadingIndicator(),
              const SizedBox(height: 8),
              Text(
                text ?? 'Memuat',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
