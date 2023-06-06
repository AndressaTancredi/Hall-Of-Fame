import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../common/app_colors.dart';
import '../common/common_strings.dart';
import '../common/data/request_api.dart';
import '../common/injection_container.dart';
import '../common/text_styles.dart';
import '../common/utils.dart';
import '../model/form_data.dart';
import '../widget/button.dart';
import '../widget/widgetToImage.dart';

class ResultPage extends StatefulWidget {
  final Uint8List photo;

  const ResultPage({Key? key, required this.photo}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  GlobalKey key1 = GlobalKey();
  Uint8List? bytes1;

  TextStyle get titleStyle => sl<TextStyles>().titleYellow;
  TextStyle get bodyStyle => sl<TextStyles>().titleDarkBold;

  List<String> imagePaths =
      List.generate(12, (index) => 'assets/images/resultImage${index + 1}.png');

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
                              padding: const EdgeInsets.all(150.0),
                              child: Image.memory(
                                widget.photo,
                              ),
                            ),
                          ),
                          Positioned.fill(
                            top: 855,
                            left: 412,
                            child: Text(
                              getDataTime(),
                              style: bodyStyle.copyWith(
                                  color: Colors.white, fontSize: 24),
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
                  child: Consumer<FormDataModel>(
                    builder: (context, formDataModel, _) {
                      return Button(
                        title: CommonStrings.share.toUpperCase(),
                        onPressed: () {
                          // shareQrCode();
                          Navigator.of(context).pushNamed('/share_page');
                        },
                      );
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
    bytes1 = await Utils.capture(key1);
    FormDataModel().updateBytes(bytes1!);
    final bytes = FormDataModel.bytes1;
    final name = FormDataModel.name;
    final phone = FormDataModel.phone;
    final email = FormDataModel.email;

    await RequestAPI.getQrCode(name, phone, email, bytes);
  }

  String getDataTime() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    DateTime tsDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return "${tsDate.day}/${tsDate.month}/${tsDate.year}";
  }
}
