import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/injection_container.dart';
import '../common/text_styles.dart';

class TextFieldForm extends StatefulWidget {
  final String title;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const TextFieldForm({
    Key? key,
    required this.title,
    this.validator,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  TextStyle get titleStyle =>
      sl<TextStyles>().titleDarkBold.copyWith(fontSize: 34.0);

  @override
  State<TextFieldForm> createState() => _TextFieldFormState();
}

class _TextFieldFormState extends State<TextFieldForm> {
  bool isTextFieldFilled = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title.toUpperCase(),
            style: widget.titleStyle,
          ),
          TextFormField(
            controller: widget.controller,
            cursorColor: AppColors.yellow,
            style: const TextStyle(
              fontSize: 34,
              fontStyle: FontStyle.normal,
              color: AppColors.primary,
              decorationThickness: 0,
            ),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(14.0),
              fillColor: Colors.white,
              focusColor: AppColors.yellow,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.yellow),
              ),
              errorStyle: TextStyle(
                color: Colors.red,
                fontSize: 24.0,
              ),
            ),
            onChanged: widget.onChanged,
            validator: (value) {
              if (widget.validator != null) {
                final errorText = widget.validator!(value);
                if (errorText != null) {
                  setState(() {
                    isTextFieldFilled = false;
                  });
                  return errorText;
                }
              }
              setState(() {
                isTextFieldFilled = value!.isNotEmpty;
              });
              return null;
            },
          ),
        ],
      ),
    );
  }
}
