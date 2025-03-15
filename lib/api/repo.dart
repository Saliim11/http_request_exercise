import 'package:http/http.dart' as http;
import 'package:http_request_exercise/api/endpoint.dart';

Future<http.Response> requestPokemon() {
  return http.get(Uri.parse("${Endpoint.baseUrl}/pokemon?limit=1302"));
}

Future<http.Response> requestDetailPokemon(String nama) {
  return http.get(Uri.parse("${Endpoint.baseUrl}/pokemon/$nama"));
}