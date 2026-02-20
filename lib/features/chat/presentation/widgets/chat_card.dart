import 'package:dream_messenger_demo/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final int index;

  const ChatCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      // color: Colors.indigoAccent,
      // height: context.responsiveValue(35),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green,
              radius: context.responsiveValue(26),
            ),
            Container(
              // color: Colors.indigoAccent,
              padding: EdgeInsets.only(
                left: context.responsiveValue(6, tablet: 8, desktop: 10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User #${index + 1}",
                    style: TextStyle(
                      color: theme.colorScheme.surface,
                      fontSize: context.textSize,
                    ),
                  ),
                  Text(
                    "Content",
                    style: TextStyle(
                      color: theme.colorScheme.surface,
                      fontSize: context.textSize,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: context.responsiveValue(9, tablet: 10, desktop: 11),
                      child: Text(
                        "${index+1}",
                        style: TextStyle(
                          fontSize: context.responsiveValue(
                            12,
                            tablet: 13,
                            desktop: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
