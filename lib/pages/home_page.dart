import 'package:flutter/material.dart';
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
    final formData = Provider.of<FormDataModel>(context, listen: false);
    _nameController.text = formData.name ?? '';
    _phoneController.text = formData.phone?.toString() ?? '';
    _emailController.text = formData.email ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _checkFormValidity() {
    final formData = Provider.of<FormDataModel>(context, listen: false);
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;
    });
    formData.updateName(_nameController.text);
    formData.updatePhone(int.tryParse(_phoneController.text));
    formData.updateEmail(_emailController.text);
  }

  void _saveFormData() {
    final formData = Provider.of<FormDataModel>(context, listen: false);
    formData.updateName(_nameController.text);
    formData.updatePhone(int.tryParse(_phoneController.text));
    formData.updateEmail(_emailController.text);
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
                            _checkFormValidity();
                          },
                        ),
                        const SizedBox(height: 150),
                        TextFieldForm(
                          title: CommonStrings.phoneNumber,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return CommonStrings.phoneNumberRequired;
                            }
                            if (int.tryParse(value) == null) {
                              return CommonStrings.onlyNumber;
                            }
                            return null;
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
                Button(
                    title: CommonStrings.start.toUpperCase(),
                    onPressed: () {
                      _isFormValid ? _saveFormData : null;
                      Navigator.of(context).pushNamed('/scan_page');
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
