import 'dart:convert';

import 'package:http/http.dart' as http;

class BulletinController {
  Future<dynamic> FetchBulletin() async {
    final response =
        await http.get('http://10.0.2.2:5000/api/parts/getSells');
    print(response.body);
    if (response.statusCode == 201) {
      List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load');
    }
  }
  Future<dynamic> sort() async {
    Map data = {
      'key': 'Price'
    };
    var body = json.encode(data);
    final response =
    await http.post('http://10.0.2.2:5000/api/parts/getSellSorted', headers: {"Content-Type": "application/json"},
        body: body);
    print(response.body);
    if (response.statusCode == 201) {
      List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load');
    }
  }
  Future<dynamic> sortvues() async {
    Map data = {
      'key': 'vues'
    };
    var body = json.encode(data);
    final response =
    await http.post('http://10.0.2.2:5000/api/parts/getSellSorted', headers: {"Content-Type": "application/json"},
        body: body);
    print(response.body);
    if (response.statusCode == 201) {
      List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load');
    }
  }
}
