import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import '../common/app_colors.dart';
import '../common/common_strings.dart';
import '../common/injection_container.dart';
import '../common/text_styles.dart';
import '../common/utils.dart';
import '../model/form_data.dart';
import '../widget/button.dart';
import '../widget/widget_to_image.dart';

class ResultPage extends StatefulWidget {
  final Uint8List photo;

  const ResultPage({Key? key, required this.photo}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  GlobalKey key1 = GlobalKey();
  Uint8List? bytes1;
  bool isLoading = false;
  bool isError = false;
  late String imagePath;

  TextStyle get titleStyle => sl<TextStyles>().titleYellow;
  TextStyle get bodyStyle => sl<TextStyles>().titleDarkBold;
  TextStyle get dateStyle => sl<TextStyles>().signatureDate;
  TextStyle get shareStyle => sl<TextStyles>().sharedPageText;

  List<String> starImagePaths =
      List.generate(12, (index) => 'assets/images/${index + 1}.png');

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int randomIndex = random.nextInt(starImagePaths.length);
    String randomImagePath = starImagePaths[randomIndex];

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 25.0, horizontal: 40.0),
            child: Column(
              children: [
                if (!isLoading)
                  Center(
                    child: Text(
                      CommonStrings.immortalized,
                      style: titleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 50),
                Visibility(
                  visible: !isLoading,
                  child: Container(
                    decoration: const BoxDecoration(
                      // border: Border.all(
                      //   color:
                      //       AppColors.yellow.withOpacity(isLoading ? 0 : 0.5),
                      //   width: 5,
                      // ),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    child: WidgetToImage(
                      builder: (key) {
                        key1 = key;
                        return ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40)),
                          child: Stack(
                            children: [
                              Image.asset(
                                randomImagePath,
                                fit: BoxFit.contain,
                                height: 1100,
                              ),
                              Positioned.fill(
                                bottom: -470,
                                left: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(184.0),
                                  child: Image.memory(
                                    widget.photo,
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                top: 845,
                                left: 412,
                                child: Text(
                                  getDataTime(),
                                  style: dateStyle,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 130.0),
                  child: isLoading
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 300),
                            child: Column(
                              children: [
                                Text(
                                  "A calçada da fama está mais completa agora com você.",
                                  style: shareStyle,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                FAProgressBar(
                                  currentValue: 95,
                                  animatedDuration: const Duration(seconds: 5),
                                  progressColor: AppColors.yellow,
                                ),
                              ],
                            ),
                          ),
                        )
                      : isError
                          ? Button(
                              title: CommonStrings.errorTryAgain.toUpperCase(),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/start_page');
                              },
                            )
                          : Button(
                              title: CommonStrings.share.toUpperCase(),
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  navigate();
                                } catch (error) {
                                  setState(
                                    () {
                                      isError = true;
                                      isLoading = false;
                                    },
                                  );
                                }
                              },
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getImagePath() async {
    try {
      var start = DateTime.now();
      final capturedImage = await Utils.capture(key1);
      var end = DateTime.now();

      final tempDir = await getTemporaryDirectory();
      imagePath = '${tempDir.path}/result_image.jpg';

      final img.Image image = img.decodeImage(capturedImage)!;
      final jpegBytes = img.encodeJpg(image, quality: 35);
      await File(imagePath).writeAsBytes(jpegBytes);
      FormDataModel().updatePhoto(imagePath);
      var diff = start.difference(end).inMilliseconds;
      debugPrint("Diff: $diff");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String getDataTime() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    DateTime tsDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return "${tsDate.day}/${tsDate.month}/${tsDate.year}";
  }

  void navigate() async {
    setState(
      () {
        isLoading = true;
      },
    );
    await getImagePath()
        .then((value) => Navigator.of(context).pushNamed('/share_page'));
  }
}
