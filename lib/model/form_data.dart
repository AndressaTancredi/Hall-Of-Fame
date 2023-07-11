import 'package:flutter/material.dart';

class FormDataModel with ChangeNotifier {
  static String name = "";
  static String cpf = "";
  static String phone = "";
  static String email = "";
  static String? imagePath;
  static String? qrCode;

  void updateName(String value) {
    name = value;
    notifyListeners();
  }

  void updateCPF(String value) {
    cpf = value;
    notifyListeners();
  }

  void updatePhone(String value) {
    phone = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }

  void updatePhoto(String? value) {
    imagePath = value;
    notifyListeners();
  }

  void updateQRCode(String value) {
    qrCode = value;
    notifyListeners();
  }
}
