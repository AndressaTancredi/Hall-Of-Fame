import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/injection_container.dart';
import '../common/text_styles.dart';

class TextFieldForm extends StatelessWidget {
  final String title;
  const TextFieldForm({Key? key, required this.title}) : super(key: key);

  TextStyle get titleStyle =>
      sl<TextStyles>().titleDarkBold.copyWith(fontSize: 34.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: titleStyle,
          ),
          const TextField(
            cursorColor: AppColors.yellow,
            style: TextStyle(
                fontSize: 34,
                fontStyle: FontStyle.normal,
                color: AppColors.primary,
                decorationThickness: 0),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(14.0),
              fillColor: Colors.white,
              focusColor: AppColors.yellow,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.yellow),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
