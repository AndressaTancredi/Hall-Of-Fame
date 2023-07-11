import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../model/form_data.dart';

class RequestAPI {
  static const String token = 'YXBwYW5kcm9pZDoyMDIzMDUyNQ==';

  static Future<String> getQrCode() async {
    final name = FormDataModel.name;
    final phone = FormDataModel.phone;
    final email = FormDataModel.email;
    final cpf = FormDataModel.cpf;
    final photoPath = FormDataModel.imagePath!;

    if (photoPath.isNotEmpty) {
      final url =
          Uri.parse('https://www.tcheofertas.com.br/nova_home/image_upload');

      var headers = {
        'Authorization': 'Bearer $token',
      };

      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields.addAll(
          {'nome': name, 'telefone': phone, 'email': email, 'cpf': cpf});

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
        return imageUrl;
      } else {
        throw Exception('Erro ao buscar dados');
      }
    } else {
      throw Exception('Dados inválidos');
    }
  }

  static Future<bool> hasRegister(String cpf) async {
    if (cpf.isNotEmpty) {
      final url = Uri.parse(
          'https://www.tcheofertas.com.br/nova_home/getUserbyCpf/$cpf');

      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 400) {
        return false;
      } else {
        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

        var name = responseBody['nome'];
        var cpf = responseBody['cpf'];
        var email = responseBody['email'];
        var phone = responseBody['telefone'];

        FormDataModel().updateName(name!);
        FormDataModel().updateCPF(cpf!);
        FormDataModel().updateEmail(email!);
        FormDataModel().updatePhone(phone!);
        return true;
      }
    } else {
      return false;
    }
  }
}
