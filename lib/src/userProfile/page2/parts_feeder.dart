import 'dart:convert';

import 'package:http/http.dart' as http;

class PartsFeeder {
  static Future<List> getParts() async {
    print("get Parts");
    List<dynamic> value = await getMyParts();

    return value;
  }

  static Future<dynamic> getMyParts() async {
    print("getMyParts");
    String requestUrl = "http://192.168.1.4:5000/api/parts/myparts";
    Map<String, String> headers = {"Content-type": "application/json"};
    http.Response response = await http.post(
      requestUrl,
      headers: headers,
      body: jsonEncode(<String, String>{
        'username': "jawhergharbi@yahoo.fr",
      }),
    );
    List<dynamic> data = json.decode(response.body);
    return data;
  }
}
