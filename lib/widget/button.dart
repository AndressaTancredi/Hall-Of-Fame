import 'package:flutter/material.dart';

import '../common/app_colors.dart';

class Button extends StatelessWidget {
  final String title;
  final String routePath;
  const Button({Key? key, required this.title, required this.routePath})
      : super(key: key);

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
        onPressed: () => Navigator.of(context).pushNamed(routePath),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            fontStyle: FontStyle.normal,
            fontSize: 34,
          ),
        ),
      ),
    );
  }
}
