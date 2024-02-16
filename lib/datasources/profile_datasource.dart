import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_tes_application/models/profile_response_model.dart';
import 'package:http/http.dart' as http;

class ProfileDataSource {
  static String baseUrl =
      'https://1518f853-b279-4960-aa5f-b3db1adbb13e.mock.pstmn.io';

  Future<ProfileResponseModel> getProfile(String id) async {
    try {
      String hashedId = md5.convert(utf8.encode(id)).toString();
      final response =
          await http.get(Uri.parse('$baseUrl/profile?id=$hashedId'), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        return ProfileResponseModel.fromJson(jsonResponse);
      } else {
        throw Exception("Failed to load profile");
      }
    } catch (e) {
      throw Exception("Failed to load profile: $e");
    }
  }
}
