import 'dart:async';

import 'package:calcada_da_fama/common/data/request_api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../common/app_colors.dart';
import '../common/common_strings.dart';
import '../common/injection_container.dart';
import '../common/text_styles.dart';

class SharePage extends StatefulWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  TextStyle get titleStyle => sl<TextStyles>().titleYellow;
  TextStyle get subTitleStyle => sl<TextStyles>().titleDarkBold;

  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(seconds: 20), () async {
    //   await Navigator.of(context).pushNamed('/start_page');
    // });
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 50.0, horizontal: 90.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    CommonStrings.shareOrientation,
                    style: titleStyle,
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 50),
                FutureBuilder<dynamic>(
                  future: RequestAPI.getImageUrl(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 150),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(AppColors.yellow),
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasData) {
                      Future.delayed(const Duration(seconds: 25), () async {
                        await Navigator.of(context).pushNamed('/start_page');
                      });
                      final imagePath = snapshot.data;
                      debugPrint(imagePath);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 150.0),
                        // child: Image.network(
                        //   imagePath,
                        //   fit: BoxFit.contain,
                        //   height: 500,
                        //   loadingBuilder: (context, child, loadingProgress) {
                        //     return const CircularProgressIndicator(
                        //       valueColor: AlwaysStoppedAnimation<Color>(
                        //           AppColors.yellow),
                        //     );
                        //   },
                        // ),
                        child: QrImageView(
                          data: imagePath,
                          version: QrVersions.auto,
                          backgroundColor: Colors.white,
                          size: 500.0,
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 150),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Text(
                            snapshot.error.toString(),
                          ),
                        ),
                      );
                    }

                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 150),
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text(
                    "Compartilhe nas redes sociais com seu celular",
                    style: subTitleStyle.copyWith(
                        color: Colors.white, fontSize: 44),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 150.0, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        FontAwesomeIcons.instagram,
                        size: 100,
                        color: Colors.white,
                      ),
                      Icon(
                        FontAwesomeIcons.facebook,
                        size: 100,
                        color: Colors.white,
                      ),
                      Icon(
                        FontAwesomeIcons.whatsapp,
                        size: 100,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
