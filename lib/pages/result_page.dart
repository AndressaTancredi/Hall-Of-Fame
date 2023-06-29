import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import '../common/app_colors.dart';
import '../common/common_strings.dart';
import '../common/data/request_api.dart';
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

  TextStyle get titleStyle => sl<TextStyles>().titleYellow;
  TextStyle get bodyStyle => sl<TextStyles>().titleDarkBold;
  TextStyle get dateStyle => sl<TextStyles>().signatureDate;

  List<String> imagePaths =
      List.generate(12, (index) => 'assets/images/${index + 1}.png');

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int randomIndex = random.nextInt(imagePaths.length);
    String randomImagePath = imagePaths[randomIndex];

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 25.0, horizontal: 40.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    CommonStrings.immortalized,
                    style: titleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.yellow.withOpacity(0.5),
                      width: 5,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                  ),
                  child: WidgetToImage(builder: (key) {
                    key1 = key;
                    return ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      child: Stack(
                        children: [
                          Image.asset(
                            randomImagePath,
                            fit: BoxFit.contain,
                            height: 1100,
                          ),
                          Positioned.fill(
                            bottom: -480,
                            child: Padding(
                              padding: const EdgeInsets.all(194.0),
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
                  }),
                ),
                const SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 130.0),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColors.yellow),
                        )
                      : isError
                          ? Button(
                              title: CommonStrings.errorTryAgain.toUpperCase(),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/home_page');
                              },
                            )
                          : Button(
                              title: CommonStrings.share.toUpperCase(),
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });

                                try {
                                  await shareQrCode();
                                  Navigator.of(context)
                                      .pushNamed('/share_page');
                                } catch (error) {
                                  setState(() {
                                    print(error);
                                    isError = true;
                                    isLoading = false;
                                  });
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

  Future<void> shareQrCode() async {
    final capturedImage = await Utils.capture(key1);

    final tempDir = await getTemporaryDirectory();
    final imagePath = '${tempDir.path}/result_image.jpg';

    if (capturedImage != null) {
      final img.Image image = img.decodeImage(capturedImage)!;
      final jpegBytes = img.encodeJpg(image, quality: 80);
      await File(imagePath).writeAsBytes(jpegBytes);
    } else {
      throw Exception('Failed to decode image');
    }

    FormDataModel().updatePhoto(widget.photo);
    final name = FormDataModel.name;
    final phone = FormDataModel.phone;
    final email = FormDataModel.email;
    final cpf = FormDataModel.cpf;
    await RequestAPI.getQrCode(name, phone, email, cpf, imagePath);
  }

  String getDataTime() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    DateTime tsDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return "${tsDate.day}/${tsDate.month}/${tsDate.year}";
  }
}
