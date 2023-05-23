import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

import '../common/app_colors.dart';
import '../common/common_strings.dart';
import '../common/injection_container.dart';
import '../common/text_styles.dart';
import '../widget/button.dart';

class ResultPage extends StatefulWidget {
  final Uint8List photo;
  const ResultPage({Key? key, required this.photo}) : super(key: key);

  static const List<String> imageAssets = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
  ];

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  TextStyle get titleStyle => sl<TextStyles>().titleYellow;

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final int randomIndex = random.nextInt(ResultPage.imageAssets.length);
    final String backgroundImage = ResultPage.imageAssets[randomIndex];
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 150.0, horizontal: 40.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    CommonStrings.immortalized,
                    style: titleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 150),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: AppColors.black15,
                    border: Border.all(
                        color: AppColors.yellow.withOpacity(0.5), width: 10),
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        backgroundImage,
                        fit: BoxFit.fill,
                        width: 1300,
                        height: 900,
                      ),
                      Positioned.fill(
                        child: Image.memory(
                          widget.photo,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 150.0),
                Button(
                  title: CommonStrings.share.toUpperCase(),
                  onPressed: () async {
                    await _shareMergedImages(backgroundImage, widget.photo);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _shareMergedImages(
    String backgroundImage,
    Uint8List photo,
  ) async {
    const mergedImagePath = ""; // criar!

    Share.shareFiles([mergedImagePath]);
  }
}
