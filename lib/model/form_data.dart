import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class FormDataModel with ChangeNotifier {
  static String name = "";
  static String phone = "";
  static String email = "";
  static Uint8List? bytes1;
  static String qrCode = "";

  void updateName(String value) {
    name = value;
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

  void updateBytes(Uint8List value) {
    bytes1 = value;
    notifyListeners();
  }

  void updateQRCode(String value) {
    qrCode = value;
    notifyListeners();
  }
}
