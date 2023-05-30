import 'package:flutter/cupertino.dart';

class FormDataModel with ChangeNotifier {
  String? name;
  int? phone;
  String? email;

  void updateName(String value) {
    name = value;
    notifyListeners();
  }

  void updatePhone(int? value) {
    phone = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }
}
