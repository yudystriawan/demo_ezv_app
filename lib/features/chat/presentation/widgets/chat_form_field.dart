import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../bloc/form/chat_form_bloc.dart';

class ChatFormField extends HookWidget {
  const ChatFormField({
    super.key,
    required this.roomId,
  });

  final String roomId;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return BlocListener<ChatFormBloc, ChatFormState>(
      listenWhen: (p, c) => p.messsage != c.messsage,
      listener: (context, state) {
        if (state.messsage.isEmpty) controller.clear();
      },
      child: TextField(
        controller: controller,
        maxLines: 3,
        minLines: 1,
        onChanged: (value) => context
            .read<ChatFormBloc>()
            .add(ChatFormEvent.messageChanged(value)),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: 'Message',
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, value, child) {
              return TextButton(
                onPressed: value.text.isEmpty
                    ? null
                    : () => context
                        .read<ChatFormBloc>()
                        .add(ChatFormEvent.submitted(roomId)),
                child: const Text('Send'),
              );
            },
          ),
        ),
      ),
    );
  }
}
