import 'package:dream_messenger_demo/core/utils/responsive_helper.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/screen_coverage.dart';
import 'package:dream_messenger_demo/features/chat/presentation/widgets/chat_card.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatelessWidget {
  final String email;

  const ChatListPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScreenCoverage(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                  Padding(
                    padding: EdgeInsets.only(
                      left: context.responsiveValue(
                        12,
                        tablet: 14,
                        desktop: 16,
                      ),
                    ),
                    child: Text(
                      "Tick",
                      style: TextStyle(
                        color: theme.colorScheme.surface,
                        fontSize: context.responsiveValue(
                          22,
                          tablet: 24,
                          desktop: 26,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: ListView.separated(
                  separatorBuilder: (context, count) {
                    return Container(
                      color: theme.colorScheme.surface,
                      height: context.responsiveValue(
                        0.2,
                        tablet: 0.4,
                        desktop: 0.6,
                      ),
                    );
                  },
                  itemCount: 20,
                  itemBuilder: (context, count) {
                    return ChatCard(index: count);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
