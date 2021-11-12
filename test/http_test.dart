import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'src/mock_data_provider.dart';
import 'dart:convert';

void main() {
  test("Fetch first image", () async {
    final MockDataProvider mockDataProvider = MockDataProvider();

    mockDataProvider.client = MockClient((request) async {
      final jsonMap = {
        "total": 604260,
        "totalHits": 500,
        "hits": [
          {
            "largeImageURL":
                "https://pixabay.com/get/gfff637b89c40f74f333c83f12a1316a0b63fcf85002c8e5e2f258f674201ac0ad3911d6dee42d17b35c598bcffa4e343e88c37a4b189875106702492d6f63527_1280.jpg",
          },
          {
            "largeImageURL":
                "https://pixabay.com/get/gf48f934b928b8a418b22e77242195b15dea0be614f6e1a33cd7997ca426a8ef232fcf8b5efe0064b2ac058eaad582b89dd226339625e8c85aa32a94ad3bc299f_1280.jpg",
          },
          {
            "largeImageURL":
                "https://pixabay.com/get/gb3f165743613a727faff4f421e68b74b4dfc3c711e6a2abcdfbe0f21170412008c1428ee7b91f873340af3095fdbb097e2ec7c209344a083f84b6eb2a04fdaae_1280.jpg",
          }
        ]
      };

      return Response(json.encode(jsonMap), 200);
    });

    final _data = await mockDataProvider.getData();

    String firstImage = _data["hits"][0]["largeImageURL"];

    expect(firstImage,
        "https://pixabay.com/get/gfff637b89c40f74f333c83f12a1316a0b63fcf85002c8e5e2f258f674201ac0ad3911d6dee42d17b35c598bcffa4e343e88c37a4b189875106702492d6f63527_1280.jpg");
  });

  test("Fetch data returns exception", () async {
    final MockDataProvider mockDataProvider = MockDataProvider();

    mockDataProvider.client = MockClient((request) async {
      return Response(json.encode(""), 404);
    });

    try {
      mockDataProvider.getData();

    } on TestDataHttpException catch (error) {

      expect(error.statusCode, 404);

    }

  });
}
