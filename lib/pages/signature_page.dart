import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import '../common/app_colors.dart';
import '../common/common_strings.dart';
import '../common/injection_container.dart';
import '../common/text_styles.dart';
import '../widget/button.dart';

class SignaturePage extends StatelessWidget {
  const SignaturePage({Key? key}) : super(key: key);

  TextStyle get titleStyle => sl<TextStyles>().titleYellow;

  @override
  Widget build(BuildContext context) {
    final SignatureController controller = SignatureController(
      penStrokeWidth: 5,
      penColor: AppColors.primary,
      exportBackgroundColor: Colors.transparent,
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
                  style: titleStyle,
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
                    height: 800,
                    width: 1400,
                    backgroundColor: AppColors.black15),
              ),
              Expanded(
                child: Button(
                  title: CommonStrings.immortalize.toUpperCase(),
                  onPressed: () =>
                      _convertSignatureToImage(context, controller).then(
                    (photo) {
                      Navigator.pushNamed(
                        context,
                        '/result_page',
                        arguments: {'photo': photo},
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Uint8List> _convertSignatureToImage(
      BuildContext context, SignatureController controller) async {
    final Uint8List? data =
        await controller.toPngBytes(height: 800, width: 1400);
    if (data != null) {
      return data;
    } else {
      throw Exception('Failed to convert signature to image.');
    }
  }
}
//https://suryadevsingh24032000.medium.com/share-content-with-the-flutter-share-plugin-896570bd1696
//https://pub.dev/documentation/share/latest/
