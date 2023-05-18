import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import '../common/app_colors.dart';
import '../common/common_strings.dart';
import '../common/injection_container.dart';
import '../common/text_styles.dart';
import '../widget/button.dart';

class SignaturePage extends StatelessWidget {
  const SignaturePage({Key? key}) : super(key: key);

  TextStyle get titleStyle => sl<TextStyles>().titleDarkBold;

  @override
  Widget build(BuildContext context) {
    final SignatureController controller = SignatureController(
      penStrokeWidth: 5,
      penColor: AppColors.primary,
      exportBackgroundColor: Colors.blue,
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 225.0, horizontal: 40.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  CommonStrings.signatureOrientation,
                  style: titleStyle.copyWith(
                      fontSize: 40.0, color: AppColors.yellow),
                ),
              ),
              const SizedBox(height: 250),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: AppColors.black15,
                  border: Border.all(
                      color: AppColors.yellow.withOpacity(0.5), width: 10),
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                ),
                child: Signature(
                    controller: controller,
                    height: 700,
                    backgroundColor: AppColors.black15),
              ),
              Expanded(
                child: Button(
                  title: CommonStrings.immortalize.toUpperCase(),
                  routePath: "",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
