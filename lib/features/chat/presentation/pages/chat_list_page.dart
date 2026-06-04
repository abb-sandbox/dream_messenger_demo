import 'package:dream_messenger_demo/core/bloc/networkCubit/network_cubit.dart';
import 'package:dream_messenger_demo/core/bloc/networkCubit/network_state.dart';
import 'package:dream_messenger_demo/core/utils/responsive_helper.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/screen_coverage.dart';
import 'package:dream_messenger_demo/features/chat/presentation/pages/chat_page.dart';
import 'package:dream_messenger_demo/features/chat/presentation/widgets/chat_card.dart';
import 'package:dream_messenger_demo/features/chat/presentation/widgets/navigation_side_bar.dart';
import 'package:dream_messenger_demo/shared/widgets/show_snack_bar.dart';
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
    context.read<NetworkCubit>().listenForUserChanges();
    context.read<ChatListCubit>().getOnlineUsers();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScreenCoverage(
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, left: 4.0),
                    child: IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        size: context.responsiveValue(
                          20,
                          tablet: 22,
                          desktop: 24,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: context.responsiveValue(
                        12,
                        tablet: 14,
                        desktop: 16,
                      ),
                    ),
                    child: BlocConsumer<NetworkCubit, NetworkState>(
                      listener: (context, state) {
                        if (state is UserNetworkError) {
                          showSnackBar(context, state.failure);
                        }
                      },
                      builder: (context, state) {
                        return Text(
                          state is UserIsOnline ? "Dream" : "Connecting...",
                          style: TextStyle(
                            color: theme.iconTheme.color,
                            fontSize: context.responsiveValue(
                              20,
                              tablet: 22,
                              desktop: 24,
                            ),
                          ),
                        );
                      },
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
                            margin: EdgeInsets.only(
                              left: 56,
                              bottom: 6,
                              top: 6,
                            ),
                            color: theme.colorScheme.surface.withValues(
                              alpha: 0.1,
                            ),
                            height: context.responsiveValue(1),
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
                          // await cubit.getOnlineUsers();
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
