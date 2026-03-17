import 'package:dream_messenger_demo/core/bloc/themeBloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSwitchButton extends StatelessWidget {
  const ThemeSwitchButton({super.key, this.size});
  final double? size;
  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    return IconButton(
      onPressed: () => themeBloc.add(ThemeSwitchEvent()),
      icon: Transform.rotate(
        angle: 0.50,
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return Icon(
              state.themeData.brightness == Brightness.dark
                  ? Icons.brightness_2_outlined
                  : Icons.wb_sunny_outlined,
              size: size,
            );
          },
        ),
      ),
    );
  }
}
