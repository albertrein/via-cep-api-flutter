
import 'package:http/http.dart' as http;
import 'package:web_service/models/result_cep.dart';

class ViaCepService {
  static Future<ResultCep> fetchCep({String? cep}) async {
    final Uri uri = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return ResultCep.fromJson(response.body);
    } else {
      return ResultCep.fromJson(response.body);
    }
  }
}