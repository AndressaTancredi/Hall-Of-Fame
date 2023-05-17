import 'package:flutter/material.dart';

import '../common/app_colors.dart';

class TextFieldForm extends StatelessWidget {
  final String title;
  const TextFieldForm({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title:",
            style: const TextStyle(fontSize: 14.0),
          ),
          const SizedBox(height: 8.0),
          const TextField(
            cursorColor: AppColors.black60,
            style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.normal,
                color: AppColors.black60,
                decorationThickness: 0),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(14.0),
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
