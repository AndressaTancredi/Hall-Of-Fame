import 'package:flutter/material.dart';

import 'app_colors.dart';

class TextStyles {
  final body = const TextStyle(
    fontFamily: "TTTravels",
    fontWeight: FontWeight.w400,
    fontSize: 16,
    fontStyle: FontStyle.normal,
    color: AppColors.primary,
  );

  final titleDarkBold = const TextStyle(
    fontFamily: "TTTravels",
    fontWeight: FontWeight.w700,
    fontSize: 18,
    fontStyle: FontStyle.normal,
    color: AppColors.primary,
  );

  final titleYellow = const TextStyle(
    fontFamily: "TTTravels",
    fontWeight: FontWeight.w700,
    fontSize: 40,
    fontStyle: FontStyle.normal,
    color: AppColors.yellow,
  );

  final buttonText = const TextStyle(
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    fontStyle: FontStyle.normal,
    fontSize: 34,
  );
}
