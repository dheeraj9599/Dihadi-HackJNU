import '../../theme/theme.dart';
import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Text(
      "Dihadi",
      style: AppTextStyle.displayBold.copyWith(
        color: Colors.black.withOpacity(0.6),
        fontSize: 26,
      ),
    );
  }
}
