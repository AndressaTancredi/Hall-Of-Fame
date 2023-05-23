import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scanning_effect/scanning_effect.dart';

import '../common/app_colors.dart';
import '../common/common_strings.dart';
import '../common/injection_container.dart';
import '../common/text_styles.dart';
import '../widget/button.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool showImage = false;
  bool showEffect = true;
  int countdown = 12;

  TextStyle get titleStyle => sl<TextStyles>().titleDarkBold;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    const duration = Duration(seconds: 1);
    Timer.periodic(duration, (timer) {
      setState(() {
        countdown--;
        if (countdown <= 0) {
          timer.cancel();
          showImage = true;
          showEffect = false;
        }
      });
    });
  }

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
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Text(
                  CommonStrings.scanOrientation,
                  textAlign: TextAlign.center,
                  style: titleStyle.copyWith(
                    fontSize: 40.0,
                    color: AppColors.yellow,
                  ),
                ),
              ),
              Text(
                'Tempo restante: $countdown',
                style: titleStyle.copyWith(
                  fontSize: 40.0,
                  color: AppColors.yellow,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (showEffect)
                      ScanningEffect(
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
                              border: Border.all(
                                color: AppColors.yellow,
                                width: 10,
                              ),
                              color: AppColors.primary,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(40)),
                            ),
                          ),
                        ),
                      ),
                    if (showImage) ...[
                      Opacity(
                        opacity: 0.1,
                        child: Container(
                          height: 1600,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.yellow,
                              width: 10,
                            ),
                            color: AppColors.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40)),
                          ),
                          child: Image.asset(
                            'assets/images/img.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (showImage)
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Button(
                    title: CommonStrings.proceed.toUpperCase(),
                    routePath: '/signature_page',
                  ),

                ),
              const SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}
