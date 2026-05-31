import 'package:dream_messenger_demo/core/appTheme/app_colors.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/screen_coverage.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

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
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                itemCount: 20,
                itemBuilder: (context, index) {
                  final isMe = index % 2 == 0;
                  return _buildMessageBubble(
                    context: context,
                    text: isMe
                        ? "This is a blue message sent by me!"
                        : "This is a purple-blue message from someone else.",
                    isMe: isMe,
                    isDark: isDark,
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
              decoration: InputDecoration(
                hintText: "Message",
                hintStyle: TextStyle(color: theme.iconTheme.color),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: theme.iconTheme.color ?? Colors.grey),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: theme.iconTheme.color ?? Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.send, color: AppColors.sentMessage),
          ),
        ],
      ),
    );
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
