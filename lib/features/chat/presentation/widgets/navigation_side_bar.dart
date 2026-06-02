import 'package:dream_messenger_demo/core/bloc/authCubit/auth_state.dart';
import 'package:dream_messenger_demo/core/utils/responsive_helper.dart';
import 'package:dream_messenger_demo/features/auth/presentation/pages/sign_in_page.dart';
import 'package:dream_messenger_demo/features/chat/presentation/widgets/side_bar_item.dart';
import 'package:dream_messenger_demo/shared/widgets/theme_switch_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/bloc/authCubit/auth_cubit.dart';
import '../../../auth/presentation/bloc/signInBloc/sign_in_bloc.dart';

class NavigationSideBar extends StatelessWidget {
  const NavigationSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: DefaultTextStyle(
          style: TextStyle(color: theme.colorScheme.surface),
          child: Column(
            children: [_buildHeader(context), _buildSideBarItems(context)],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final email = context.read<AuthCubit>().userEmail!;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ThemeSwitchButton(
                size: context.responsiveValue<double>(
                  24,
                  tablet: 26,
                  desktop: 28,
                ),
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: context.responsiveValue<double>(35, tablet: 36, desktop: 37),

          backgroundColor: Colors.blue,
          child: SizedBox.expand(
            child: Padding(
              padding: EdgeInsets.all(
                context.responsiveValue(16, tablet: 14, desktop: 12),
              ),
              child: FittedBox(
                child: Text(
                  email[0].toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    // fontSize: context.responsiveValue(30, tablet: 31, desktop: 32),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.responsiveValue(18, tablet: 22, desktop: 26),
          ),
          child: Text(
            email,
            style: TextStyle(
              fontSize: context.responsiveValue(16, tablet: 18, desktop: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSideBarItems(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignedOutState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SignInPage()),
            (route) => false,
          );
        }
      },
      child: Column(
        children: [
          SideBarItem(text: "Profile"),
          SideBarItem(text: "Chats"),
          SideBarItem(text: "Settings"),
          SideBarItem(
            text: "Log out",
            color: Colors.red,
            onTap: () {
              context.read<AuthCubit>().signOut();
            },
          ),
        ],
      ),
    );
  }
}
