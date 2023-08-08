import 'package:auto_route/auto_route.dart';
import 'package:demo_ezv_app/features/chat/presentation/bloc/actor/chat_actor_bloc.dart';
import 'package:demo_ezv_app/features/chat/presentation/bloc/form/chat_form_bloc.dart';
import 'package:demo_ezv_app/features/chat/presentation/bloc/loader/chat_loader_bloc.dart';
import 'package:demo_ezv_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/toast.dart';
import '../widgets/chat_buble.dart';
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
    return MultiBlocListener(
      listeners: [
        BlocListener<ChatFormBloc, ChatFormState>(
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
        ),
        BlocListener<ChatActorBloc, ChatActorState>(
          listener: (context, state) {
            state.maybeMap(
              orElse: () {},
              addReactionSuccess: (value) {
                showToast(context, title: const Text('Reaction added'));
                context
                    .read<ChatLoaderBloc>()
                    .add(ChatLoaderEvent.fetched(roomId));
              },
            );
          },
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ChatLoaderBloc, ChatLoaderState>(
            buildWhen: (p, c) => p.isLoading != c.isLoading,
            builder: (context, state) {
              if (state.messages.isEmpty()) {
                return const Center(
                  child: Text('Empty'),
                );
              }

              final messages = state.messages;
              return ListView.separated(
                shrinkWrap: true,
                itemCount: messages.size,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 12,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  final message = messages[index];
                  final isSender = message.createdBy == 'me';

                  return Align(
                    alignment:
                        isSender ? Alignment.topRight : Alignment.topLeft,
                    child: ChatBuble(
                      isSender: isSender,
                      message: message,
                    ),
                  );
                },
              );
            },
          ),
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
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
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
        BlocProvider(
          create: (context) => getIt<ChatActorBloc>(),
        ),
      ],
      child: this,
    );
  }
}
