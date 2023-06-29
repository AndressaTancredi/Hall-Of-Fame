import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../common/app_colors.dart';
import '../common/common_strings.dart';
import '../common/injection_container.dart';
import '../common/text_styles.dart';
import '../model/form_data.dart';
import '../widget/button.dart';

class SharePage extends StatelessWidget {
  const SharePage({Key? key}) : super(key: key);
  TextStyle get titleStyle => sl<TextStyles>().titleYellow;
  TextStyle get subTitleStyle => sl<TextStyles>().titleDarkBold;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 50.0, horizontal: 120.0),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Image.network(
                    FormDataModel.qrCode,
                    fit: BoxFit.contain,
                    height: 600,
                  ),
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
                      EdgeInsets.symmetric(horizontal: 150.0, vertical: 50),
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
                const SizedBox(height: 50),
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
