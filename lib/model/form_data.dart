import 'dart:typed_data';

import 'package:flutter/material.dart';

class FormDataModel with ChangeNotifier {
  static String name = "";
  static String cpf = "";
  static String phone = "";
  static String email = "";
  static Uint8List? image;
  static String qrCode = "";

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

  void updatePhoto(Uint8List? value) {
    image = value;
    notifyListeners();
  }

  void updateQRCode(String value) {
    qrCode = value;
    notifyListeners();
  }
}
