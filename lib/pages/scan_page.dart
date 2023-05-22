import 'package:flutter/material.dart';
import 'package:scanning_effect/scanning_effect.dart';

import '../common/app_colors.dart';
import '../common/common_strings.dart';
import '../common/injection_container.dart';
import '../common/text_styles.dart';
import '../widget/button.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);

  TextStyle get titleStyle => sl<TextStyles>().titleYellow;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(125.0),
                child: Text(CommonStrings.scanOrientation,
                    textAlign: TextAlign.center, style: titleStyle),
              ),
              Expanded(
                child: ScanningEffect(
                  scanningColor: AppColors.yellow,
                  borderLineColor: AppColors.primary,
                  delay: const Duration(seconds: 1),
                  duration: const Duration(seconds: 2),
                  child: Opacity(
                    opacity: 0.1,
                    child: Container(
                      height: 1600,
                      padding: const EdgeInsets.all(54.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.yellow, width: 10),
                        color: AppColors.primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40)),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 125.0),
                child: Button(
                  title: CommonStrings.finish.toUpperCase(),
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/signature_page'),
                ),
              ),
              const SizedBox(height: 250)
            ],
          ),
        ),
      ),
    );
  }
}
