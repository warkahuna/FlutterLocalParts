import 'dart:convert';

import 'package:http/http.dart' as http;

 class  BulletinController{

   Future<dynamic> FetchBulletin() async {
     final response =
     await http.get('http://10.0.2.2:5000/api/parts/getSells');
     print(response.body);
     if (response.statusCode == 200) {
       List<dynamic> data = json.decode(response.body);
      print("data length is "+data.length.toString());
       return data  ;
     } else {
       throw Exception('Failed to load');
     }
   }
 }