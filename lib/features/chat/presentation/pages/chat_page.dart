import 'package:dream_messenger_demo/core/appTheme/app_colors.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/screen_coverage.dart';
import 'package:dream_messenger_demo/features/chat/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/show_snack_bar.dart';
import '../../../auth/presentation/bloc/signInBloc/sign_in_bloc.dart';
import '../bloc/chatCubit/chat_cubit.dart';
import '../bloc/chatCubit/chat_state.dart';

class ChatPage extends StatefulWidget {
  final String sender;
  final String receiver;

  const ChatPage({super.key, required this.sender, required this.receiver});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  final messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    messageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat", style: TextStyle(color: theme.iconTheme.color)),
        elevation: 0,
        scrolledUnderElevation: 0, // This stops the color change on scroll
        surfaceTintColor: Colors.transparent, // This removes the tint
      ),
      body: ScreenCoverage(
        child: Column(
          children: [
            // Messages List
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is ChatError) {
                    showSnackBar(context, state.failure);
                  }
                },
                builder: (context, state) {
                  if (state is ChatMessageUpdate) {
                    final messages = state.messages;
                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isMe = message.from == widget.sender;
                        return _buildMessageBubble(
                          context: context,
                          text: message.content,
                          isMe: isMe,
                          isDark: isDark,
                        );
                      },
                    );
                  }
                  return Center(
                    child: Text(
                      "Be first to send a message!",
                      style: TextStyle(color: theme.iconTheme.color),
                    ),
                  );
                },
              ),
            ),

            // Input Area
            _buildMessageInput(theme, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_circle_outline, color: theme.iconTheme.color),
          ),
          Expanded(
            child: TextField(
              onEditingComplete: () => _sendMessage(),
              controller: messageTextController,
              style: TextStyle(color: theme.iconTheme.color),
              decoration: InputDecoration(
                hintText: "Message",
                hintStyle: TextStyle(color: theme.iconTheme.color),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(
                    color: theme.iconTheme.color ?? Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(
                    color: theme.iconTheme.color ?? Colors.grey,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => _sendMessage(),
            icon: const Icon(Icons.send, color: AppColors.sentMessage),
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage() async {
    await context.read<ChatCubit>().sendMessage(
      MessageEntity(
        type: "text",
        content: messageTextController.text,
        time: DateTime.timestamp().toString(),
        from: widget.sender,
        to: widget.receiver,
      ),
    );
    messageTextController.clear();
  }

  Widget _buildMessageBubble({
    required BuildContext context,
    required String text,
    required bool isMe,
    required bool isDark,
  }) {
    final theme = Theme.of(context);
    final textColor = isDark
        ? (theme.iconTheme.color ?? Colors.white)
        : Colors.white;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? AppColors.sentMessage : AppColors.receivedMessage,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 16),
          ),
        ),
        child: Text(text, style: TextStyle(color: textColor, fontSize: 16)),
      ),
    );
  }
}
