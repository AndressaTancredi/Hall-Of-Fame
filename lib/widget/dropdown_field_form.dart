import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/common_strings.dart';

class DropdownFieldForm extends StatefulWidget {
  final String title;
  const DropdownFieldForm({Key? key, required this.title}) : super(key: key);

  @override
  State<DropdownFieldForm> createState() => _DropdownFieldFormState();
}

class _DropdownFieldFormState extends State<DropdownFieldForm> {
  String? genderSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.title}:",
            style: const TextStyle(fontSize: 14.0),
          ),
          const SizedBox(height: 8.0),
          Container(
            height: 50.0,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              border: Border.all(color: AppColors.black60),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: Colors.white,
                value: genderSelected,
                icon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 26,
                  color: AppColors.black60,
                ),
                isExpanded: true,
                borderRadius: BorderRadius.circular(10),
                items: CommonStrings.genderList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                          color: AppColors.black60, fontSize: 14.0),
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() {
                  genderSelected = value;
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
