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
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [_buildHeader(context), _buildSideBarItems(context)],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final email = context.read<AuthCubit>().userEmail!;
    return Container(
      color: Colors.blue.shade50,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ThemeSwitchButton(
                size: context.responsiveValue<double>(
                  32,
                  tablet: 34,
                  desktop: 36,
                ),
              ),
            ],
          ),
          Container(
            height: context.responsiveValue(100),
            width: context.responsiveValue(100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                context.responsiveValue<double>(50),
              ),

              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                email[0],
                style: TextStyle(
                  color: theme.scaffoldBackgroundColor,
                  fontWeight: FontWeight.normal,
                  fontSize: context.responsiveValue(
                    45,
                    tablet: 47,
                    desktop: 50,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.responsiveValue(20, tablet: 25, desktop: 30),
            ),
            child: Text(
              email,
              style: TextStyle(
                fontSize: context.responsiveValue(20, tablet: 22, desktop: 24),
              ),
            ),
          ),
        ],
      ),
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
