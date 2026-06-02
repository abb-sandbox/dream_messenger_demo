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
          vertical: context.responsiveValue(10, tablet: 11, desktop: 12),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveValue(15, tablet: 16, desktop: 17),
        ),
        height: context.responsiveValue(21, tablet: 22, desktop: 23),
        width: double.infinity,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: context.responsiveValue<double>(
              16,
              tablet: 17,
              desktop: 18,
            ),
          ),
        ),
      ),
    );
  }
}
