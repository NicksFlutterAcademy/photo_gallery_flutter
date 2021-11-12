import 'package:http/http.dart' as http;
import 'dart:convert';

class DataHttpException implements Exception {
  DataHttpException(this.statusCode);
  final int statusCode;
}

class NetworkHelper {
  NetworkHelper({required this.url});

  final String url;

  Future<dynamic> getData() async {
    http.Response response;

    response = await http.get(Uri.parse(url));

    // Means success
    if (response.statusCode == 200) {
      // json
      String data = response.body;

      // Parses json string and returns jsonObjects
      dynamic jsonObjects = jsonDecode(data);

      return jsonObjects;
    } else {
      throw DataHttpException(response.statusCode);
    }
  }

}
