import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../model/form_data.dart';

class RequestAPI {
  static const String token = 'YXBwYW5kcm9pZDoyMDIzMDUyNQ==';

  static Future<void> getQrCode(
      String name, String phone, String email, String photoPath) async {
    if (name.isNotEmpty &&
        phone.isNotEmpty &&
        email.isNotEmpty &&
        photoPath.isNotEmpty) {
      final url =
          Uri.parse('https://www.tcheofertas.com.br/nova_home/image_upload');

      var headers = {
        'Authorization': 'Bearer $token',
      };

      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields.addAll({'nome': name, 'telefone': phone, 'email': email});

      var multipartFile = await http.MultipartFile.fromPath(
        'image',
        photoPath,
        filename: 'photo.jpg',
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(multipartFile);

      var response = await request.send();
      var responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var responseData = jsonDecode(responseString) as Map<String, dynamic>;
        var imageUrl = responseData['qr_code'];
        FormDataModel().updateQRCode(imageUrl);
      } else {
        throw Exception('Erro ao buscar dados');
      }
    } else {
      throw Exception('Dados inválidos');
    }
  }
}
