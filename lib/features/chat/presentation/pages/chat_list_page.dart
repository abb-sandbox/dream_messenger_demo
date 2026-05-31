import 'package:dream_messenger_demo/core/utils/responsive_helper.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/screen_coverage.dart';
import 'package:dream_messenger_demo/features/chat/presentation/pages/chat_page.dart';
import 'package:dream_messenger_demo/features/chat/presentation/widgets/chat_card.dart';
import 'package:dream_messenger_demo/features/chat/presentation/widgets/navigation_side_bar.dart';
import 'package:flutter/material.dart';

import '../../../auth/presentation/bloc/signInBloc/sign_in_bloc.dart';
import '../bloc/chatListCubit/chat_list_cubit.dart';

class ChatListPage extends StatefulWidget {
  final String email;

  const ChatListPage({super.key, required this.email});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<ChatListCubit>();
    return ScreenCoverage(
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    icon: Icon(Icons.menu),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: context.responsiveValue(
                        12,
                        tablet: 14,
                        desktop: 16,
                      ),
                    ),
                    child: Text(
                      "Dream",
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
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
              BlocBuilder<ChatListCubit, ChatListState>(
                builder: (context, state) {
                  if (state is ChatListUpdated) {
                    return Flexible(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return Container(
                            color: theme.colorScheme.surface,
                            height: context.responsiveValue(
                              0.2,
                              tablet: 0.4,
                              desktop: 0.6,
                            ),
                          );
                        },
                        itemCount: state.onlineUsers.length,
                        itemBuilder: (context, index) {
                          final user = state.onlineUsers[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(),
                                ),
                              );
                            },
                            child: ChatCard(userName: user.uid),
                          );
                        },
                      ),
                    );
                  } else if (state is ChatListInitialState) {
                    return Center(
                      child: IconButton(
                        onPressed: () async {
                          await cubit.getOnlineUsers();
                        },
                        icon: Icon(Icons.refresh),
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
          drawer: NavigationSideBar(),
        ),
      ),
    );
  }
}
