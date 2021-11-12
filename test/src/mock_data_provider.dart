import 'dart:convert';
import 'package:http/http.dart';

class TestDataHttpException implements Exception {
  TestDataHttpException(this.statusCode);
  final int statusCode;
}

class MockDataProvider {

  Client client = Client();

  Future<dynamic> getData() async {

    final response = await client.get(Uri.parse("test"));

      // Means success
      if (response.statusCode == 200) {
        // json
        String data = response.body;

        // Parses json string and returns jsonObjects
        dynamic jsonObjects = jsonDecode(data);

        return jsonObjects;
      } else {

        throw TestDataHttpException(response.statusCode);

      }

  }

}