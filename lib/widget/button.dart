import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/injection_container.dart';
import '../common/text_styles.dart';

class Button extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const Button({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  TextStyle get buttonStyle => sl<TextStyles>().buttonText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.yellow,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          minimumSize: const Size(double.infinity, 150),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: buttonStyle,
        ),
      ),
    );
  }
}
