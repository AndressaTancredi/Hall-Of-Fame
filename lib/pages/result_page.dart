import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/injection_container.dart';
import '../common/text_styles.dart';

class ResultPage extends StatelessWidget {
  final Uint8List photo;
  const ResultPage({Key? key, required this.photo}) : super(key: key);

  TextStyle get titleStyle => sl<TextStyles>().titleYellow;

  static const List<String> imageAssets = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final int randomIndex = random.nextInt(1);
    final String backgroundImage = imageAssets[randomIndex];
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 225.0, horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Resultado",
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
                child: Stack(
                  children: [
                    Image.asset(
                      backgroundImage,
                      fit: BoxFit.fill,
                      width: 1400,
                      height: 1000,
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: -90,
                      child: Opacity(
                        opacity: 0.5,
                        child: Image.memory(
                          photo,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
