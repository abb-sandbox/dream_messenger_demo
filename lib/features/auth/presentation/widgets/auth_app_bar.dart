import 'package:dream_messenger_demo/core/utils/responsive_helper.dart';
import 'package:dream_messenger_demo/shared/widgets/theme_switch_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/bloc/themeBloc/theme_bloc.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeBloc = context.read<ThemeBloc>();
    return SizedBox(
      height: size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(
              right: context.responsiveValue(16, tablet: 26, desktop: 34),
            ),
            child: ThemeSwitchButton(),
          ),
        ],
      ),
    );
  }
}
