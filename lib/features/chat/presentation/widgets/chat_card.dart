import 'package:dream_messenger_demo/core/utils/responsive_helper.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/signInBloc/sign_in_bloc.dart';
import 'package:dream_messenger_demo/features/chat/presentation/bloc/chatCubit/chat_cubit.dart';
import 'package:dream_messenger_demo/features/chat/presentation/bloc/chatCubit/chat_state.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final String userName;

  const ChatCard({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.green,
            radius: context.responsiveValue(26),
            child: Text(userName[0].toUpperCase()),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: context.responsiveValue(6, tablet: 8, desktop: 10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: theme.colorScheme.surface,
                      fontSize: context.textSize,
                    ),
                  ),
                  BlocBuilder<ChatCubit, ChatState>(
                    builder: (context, state) {
                      String content = "No message";
                      if (state is ChatMessageUpdate) {
                        final lastMessage = state.messages.first;
                        content = lastMessage.content;
                        if (lastMessage.to == userName) {
                          content = "You: $content";
                        }
                      }
                      return Text(
                        content,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: theme.colorScheme.surface,
                          fontSize: context.textSize,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
