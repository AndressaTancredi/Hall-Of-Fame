import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../common/app_colors.dart';
import '../common/common_strings.dart';
import '../common/injection_container.dart';
import '../common/text_styles.dart';
import '../widget/button.dart';

class SharePage extends StatelessWidget {
  final String qrCodeImageLink;
  const SharePage({Key? key, required this.qrCodeImageLink}) : super(key: key);
  TextStyle get titleStyle => sl<TextStyles>().titleYellow;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 100.0, horizontal: 50.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    CommonStrings.shareOrientation,
                    style: titleStyle,
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 150),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Image.network(
                    "https://www.tcheofertas.com.br/tcheofertas/upload/api_uploads/647e6ec5390b8_qr_code.png",
                    fit: BoxFit.contain,
                    height: 600,
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 150.0, vertical: 150),
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
                Button(
                  title: CommonStrings.restart.toUpperCase(),
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/home_page'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
