import 'package:demo_ezv_app/features/chat/presentation/bloc/actor/chat_actor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../domain/entities/entity.dart';
import 'reactions_widget.dart';

class ChatBuble extends HookWidget {
  const ChatBuble({
    Key? key,
    required this.message,
    required this.isSender,
  }) : super(key: key);

  final Chat message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    final showReaction = useState(false);

    return GestureDetector(
      onTap: () => showReaction.value = false,
      onDoubleTap:
          isSender ? null : () => showReaction.value = !showReaction.value,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isSender ? colorScheme.primary : colorScheme.secondary,
              ),
              child: Text(
                message.message,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (message.hasReaction)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  message.reaction!,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          if (showReaction.value && !isSender)
            ReactionsWidget(
              onTap: (reaction) {
                showReaction.value = false;
                context.read<ChatActorBloc>().add(ChatActorEvent.reactionAdded(
                    chatId: message.id, reaction: reaction));
              },
            )
        ],
      ),
    );
  }
}
