import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/common_strings.dart';

class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.yellow,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            minimumSize: const Size(380, 95),
          ),
          onPressed: () => Navigator.of(context).pushNamed(''),
          child: Text(
            CommonStrings.start.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              fontStyle: FontStyle.normal,
              fontSize: 34,
            ),
          ),
        ),
      ),
    );
  }
}
