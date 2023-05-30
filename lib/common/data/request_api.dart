import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../model/form_data.dart';

class RequestAPI {
  static const String token = 'YXBwYW5kcm9pZDoyMDIzMDUyNQ==';

  Future<Image> _getQrCode(BuildContext context) async {
    final formDataModel = Provider.of<FormDataModel>(context, listen: false);
    final data = {
      'name': formDataModel.name,
      'phone': formDataModel.phone.toString(),
      'email': formDataModel.email,
      // 'photo': formDataModel.photo,
    };
    final getQrCodeResponse = await http.post(
      Uri.https('tcheofertas.com.br', '/nova_home/image_upload'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: data,
    );

    final responseBody =
        jsonDecode(getQrCodeResponse.body) as Map<String, dynamic>;
    final qrCodeImage = responseBody['image_url'] as Image;

    if (getQrCodeResponse.statusCode == 200) {
      return qrCodeImage;
    } else {
      throw Exception('Erro ao buscar dados');
    }
  }
}
