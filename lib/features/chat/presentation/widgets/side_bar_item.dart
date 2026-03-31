import 'package:flutter/material.dart';

import '../../../../core/utils/responsive_helper.dart';

class SideBarItem extends StatelessWidget {
  const SideBarItem({
    super.key,
    required this.text,
    this.color,
    this.onTap,
  });

  final Function()? onTap;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(
          vertical: context.responsiveValue(10, tablet: 15, desktop: 20),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveValue(15, tablet: 20, desktop: 25),
        ),
        height: context.responsiveValue(50, tablet: 52, desktop: 55),
        width: double.infinity,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: context.responsiveValue<double>(
              18,
              tablet: 20,
              desktop: 22,
            ),
          ),
        ),
      ),
    );
  }
}
