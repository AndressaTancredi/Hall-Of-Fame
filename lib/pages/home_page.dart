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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isFormValid = false;

  TextStyle get titleStyle => sl<TextStyles>().titleYellow;

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
                  height: 900,
                  padding: const EdgeInsets.all(50.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: Form(
                    key: _formKey,
                    onChanged: _checkFormValidity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFieldForm(
                          title: CommonStrings.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return CommonStrings.nameRequired;
                            }
                            return null;
                          },
                          controller: _nameController,
                          onChanged: (value) {
                            _nameController.value = TextEditingValue(
                                text: capitalizeAllWord(value),
                                selection: _nameController.selection);
                            _checkFormValidity();
                          },
                        ),
                        const SizedBox(height: 150),
                        TextFieldForm(
                          maskFormatter: [maskFormatter],
                          title: CommonStrings.phoneNumber,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return CommonStrings.phoneNumberRequired;
                            }
                          },
                          controller: _phoneController,
                          onChanged: (value) {
                            _checkFormValidity();
                          },
                        ),
                        const SizedBox(height: 100),
                        TextFieldForm(
                          title: CommonStrings.email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return CommonStrings.emailRequired;
                            }
                            final emailRegex =
                                RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (!emailRegex.hasMatch(value)) {
                              return CommonStrings.validEmail;
                            }
                            return null;
                          },
                          controller: _emailController,
                          onChanged: (value) {
                            _checkFormValidity();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 100.0),
                Consumer<FormDataModel>(
                  builder: (context, formDataModel, _) {
                    return Button(
                      title: CommonStrings.start.toUpperCase(),
                      onPressed: _isFormValid
                          ? () {
                              formDataModel.updateName(_nameController.text);
                              formDataModel.updatePhone(_phoneController.text);
                              formDataModel.updateEmail(_emailController.text);
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

  String capitalizeAllWord(String value) {
    var result = value[0].toUpperCase();
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " ") {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
      }
    }
    return result;
  }

  var maskFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
}
