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
            backgroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            minimumSize: const Size(180, 45),
          ),
          onPressed: () => Navigator.of(context).pushNamed(''),
          child: Text(
            CommonStrings.start,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.black60,
              fontStyle: FontStyle.normal,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
