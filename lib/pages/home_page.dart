import 'package:calcada_da_fama/widget/button.dart';
import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/common_strings.dart';
import '../common/injection_container.dart';
import '../common/text_styles.dart';
import '../widget/dropdown_field_form.dart';
import '../widget/text_field_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextStyle get titleStyle => sl<TextStyles>().titleYellow;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 150),
                  child: Text(
                    CommonStrings.hallOfFame.toUpperCase(),
                    style: titleStyle.copyWith(
                        fontSize: 60.0, color: AppColors.yellow),
                  ),
                ),
                Container(
                  height: 900,
                  padding: const EdgeInsets.all(50.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFieldForm(title: CommonStrings.name),
                      const SizedBox(height: 74.0),
                      TextFieldForm(title: CommonStrings.yearsOld),
                      const SizedBox(height: 74.0),
                      DropdownFieldForm(title: CommonStrings.gender),
                      const SizedBox(height: 74.0),
                      TextFieldForm(title: CommonStrings.voucher),
                    ],
                  ),
                ),
                const SizedBox(height: 150.0),
                Button(
                  title: CommonStrings.start.toUpperCase(),
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/scan_page'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
