import 'package:auto_route/auto_route.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:demo_ezv_app/features/chat/presentation/bloc/form/chat_form_bloc.dart';
import 'package:demo_ezv_app/features/chat/presentation/bloc/loader/chat_loader_bloc.dart';
import 'package:demo_ezv_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/toast.dart';
import '../widgets/chat_form_field.dart';

@RoutePage()
class ChatOverviewPage extends StatelessWidget implements AutoRouteWrapper {
  const ChatOverviewPage({
    Key? key,
    required this.roomId,
  }) : super(key: key);

  final String roomId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatFormBloc, ChatFormState>(
      listenWhen: (p, c) =>
          p.failureOrSuccessFailure != c.failureOrSuccessFailure,
      listener: (context, state) {
        state.failureOrSuccessFailure.fold(
          () {},
          (either) => either.fold(
            (f) => showToast(
              context,
              title: const Text('Something went wrong'),
            ),
            (_) {
              context
                  .read<ChatFormBloc>()
                  .add(const ChatFormEvent.messageChanged(''));

              context
                  .read<ChatLoaderBloc>()
                  .add(ChatLoaderEvent.fetched(roomId));
            },
          ),
        );
      },
      child: Scaffold(
        body: BlocBuilder<ChatLoaderBloc, ChatLoaderState>(
          buildWhen: (p, c) => p.messages != c.messages,
          builder: (context, state) {
            if (state.messages.isEmpty()) {
              return const Center(
                child: Text('Empty'),
              );
            }

            final messages = state.messages;
            return ListView.separated(
              itemCount: messages.size,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 12,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                final message = messages[index];
                final isSender = message.createdBy == 'me';
                var colorScheme = Theme.of(context).colorScheme;

                return BubbleSpecialThree(
                  text: message.message,
                  isSender: isSender,
                  color: isSender ? colorScheme.primary : colorScheme.secondary,
                  textStyle: const TextStyle(color: Colors.white),
                );
              },
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(Icons.camera_alt),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: ChatFormField(
                  roomId: roomId,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ChatFormBloc>(),
        ),
        BlocProvider(
          create: (context) =>
              getIt<ChatLoaderBloc>()..add(ChatLoaderEvent.fetched(roomId)),
        ),
      ],
      child: this,
    );
  }
}
