import 'dart:convert';

import 'package:http/http.dart' as http;

class BulletinController {
  Future<dynamic> FetchBulletin() async {
    final response =
        await http.get('http://192.168.1.4:5000/api/parts/getSells');
    print(response.body);
    if (response.statusCode == 201) {
      List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load');
    }
  }
}
