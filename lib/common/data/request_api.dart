import 'dart:convert';
import 'dart:typed_data';

import 'package:calcada_da_fama/model/form_data.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class RequestAPI {
  static const String token = 'YXBwYW5kcm9pZDoyMDIzMDUyNQ==';

  static Future<void> getQrCode(
      String name, String phone, String email, Uint8List? bytes1) async {
    if (name.isNotEmpty && phone.isNotEmpty && email.isNotEmpty) {
      final url =
          Uri.parse('https://www.tcheofertas.com.br/nova_home/image_upload');

      var headers = {
        'Authorization': 'Bearer $token',
      };

      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields.addAll({'name': name, 'phone': phone, 'email': email});

      if (bytes1 != null) {
        ByteData imageData =
            await rootBundle.load('assets/images/hallOfFame.jpg');
        List<int> bytes = imageData.buffer.asUint8List();

        var multipartFile = http.MultipartFile.fromBytes(
          'image',
          bytes,
          filename: 'photo.jpg',
          contentType: MediaType('image', 'jpeg'),
        );

        request.files.add(multipartFile);
      } else {
        throw Exception('Imagem inválida');
      }

      var response = await request.send();
      var responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var responseData = jsonDecode(responseString) as Map<String, dynamic>;
        var imageUrl = responseData['qr_code'];
        FormDataModel().updateQRCode(imageUrl);
        // Do whatever is necessary with the image or response URL
      } else {
        print(response.reasonPhrase);
        print(response.headers);
        print(responseString);
        throw Exception('Erro ao buscar dados');
      }
    } else {
      throw Exception('Dados inválidos');
    }
  }
}
