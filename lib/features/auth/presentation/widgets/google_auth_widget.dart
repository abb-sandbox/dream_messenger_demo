import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/bloc/themeBloc/theme_bloc.dart';
import '../../../../core/bloc/themeBloc/theme_state.dart';

class GoogleAuthWidget extends StatelessWidget {
  final bool signIn;

  const GoogleAuthWidget({super.key, required this.signIn});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(vertical: size.height*0.02),
          child: Row(
            children: [
              SizedBox(width: size.width * 0.06),
              Expanded(
                child: Divider(
                  // endIndent: size.width * 0.02,
                  color: theme.colorScheme.surface.withOpacity(0.2),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Text(
                  "or",
                  style: TextStyle(
                    color: theme.colorScheme.surface,
                    fontSize: size.width * 0.04,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  indent: size.width * 0.02,
                  color: theme.colorScheme.surface.withOpacity(0.2),
                ),
              ),
              SizedBox(width: size.width * 0.06),
            ],
          ),
        ),

        SizedBox(
          width: double.infinity,
          height: size.height * 0.05,
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              if (state.themeData.brightness == Brightness.dark) {
                return SvgPicture.asset(
                  signIn
                      ? "assets/icons/g_logo_android_dark_sq_SI.svg"
                      : "assets/icons/g_logo_android_dark_sq_SU.svg",
                );
              }
              return SvgPicture.asset(
                signIn
                    ? "assets/icons/g_logo_android_light_sq_SI.svg"
                    : "assets/icons/g_logo_android_light_sq_SU.svg",
              );
            },
          ),
        ),
      ],
    );
  }
}
