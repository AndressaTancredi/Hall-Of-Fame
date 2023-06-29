import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../common/app_colors.dart';
import '../common/common_strings.dart';
import '../common/injection_container.dart';
import '../common/text_styles.dart';
import '../model/form_data.dart';
import '../widget/button.dart';
import '../widget/text_field_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FormDataModel(),
      child: _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatefulWidget {
  @override
  State<_HomePageContent> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePageContent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cpfController = TextEditingController();
  bool _isFormValid = false;

  TextStyle get titleStyle => sl<TextStyles>().titleYellow;
  TextStyle get subtitleStyle => sl<TextStyles>().titleDarkBold;

  @override
  void initState() {
    super.initState();
  }

  void _checkFormValidity() async {
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 150),
                  child: Text(
                    CommonStrings.hallOfFame.toUpperCase(),
                    style: titleStyle.copyWith(
                      fontSize: 60.0,
                      color: AppColors.yellow,
                    ),
                  ),
                ),
                Container(
                  height: 400,
                  padding: const EdgeInsets.all(50.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: Form(
                    key: _formKey,
                    onChanged: _checkFormValidity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFieldForm(
                          maskFormatter: [maskCPFFormatter],
                          title: "Insira seu CPF:",
                          controller: _cpfController,
                          onChanged: (value) {
                            _checkFormValidity();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 150),
                  child: Text(
                    "Lembre-se de realizar seu cadastro no piso inferior",
                    style: subtitleStyle.copyWith(
                        fontSize: 40, color: Colors.white),
                  ),
                ),
                Consumer<FormDataModel>(
                  builder: (context, formDataModel, _) {
                    return Button(
                      title: CommonStrings.start.toUpperCase(),
                      onPressed: _isFormValid
                          ? () {
                              formDataModel.updateCPF(_cpfController.text);
                              Navigator.of(context).pushNamed('/scan_page');
                            }
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  var maskCPFFormatter = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
}
