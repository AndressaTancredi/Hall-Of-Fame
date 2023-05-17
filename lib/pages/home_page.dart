import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/common_strings.dart';
import '../widget/button.dart';
import '../widget/dropdown_field_form.dart';
import '../widget/text_field_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black15,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44.0, vertical: 44.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 14.0, right: 14.0, bottom: 14.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldForm(title: CommonStrings.name),
                    TextFieldForm(title: CommonStrings.yearsOld),
                    DropdownFieldForm(title: CommonStrings.gender),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              TextFieldForm(title: CommonStrings.voucher),
              const Button(),
            ],
          ),
        ),
      ),
    );
  }
}
