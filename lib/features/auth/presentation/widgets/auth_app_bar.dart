import 'package:dream_messenger_demo/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/bloc/themeBloc/theme_bloc.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final themeBloc = context.read<ThemeBloc>();
    return SizedBox(
      height: size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.all(16.0),
            child: IconButton(
              onPressed: () => themeBloc.add(ThemeSwitchEvent()),
              icon: Transform.rotate(
                angle: 0.50,
                child: BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    return Icon(
                      state.themeData.brightness == Brightness.dark
                          ? Icons.brightness_2_outlined
                          : Icons.wb_sunny_outlined,
                      // color: theme.colorScheme.onPrimary,
                      size: context.iconSize,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
