import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditPage extends StatefulWidget {
  static String tag = 'edit-page';
  static Map contact;

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  final _cName = TextEditingController();
  final _cLastName = TextEditingController();
  final _cNickName = TextEditingController();
  final _cWork = TextEditingController();
  final _cPhoneNumber = TextEditingController();
  final _cEmail = TextEditingController();
  final _cWebSite = TextEditingController();

  static Future<dynamic> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('username');
    print(stringValue);
    print("get User details");
    String requestUrl = "http://192.168.1.4:5000/api/getUser";
    Map<String, String> headers = {"Content-type": "application/json"};
    http.Response response = await http.post(
      requestUrl,
      headers: headers,
      body: jsonEncode(<String, String>{
        'username': stringValue,
      }),
    );
    return json.decode(response.body);
  }

  Future<dynamic> setData() async {
    dynamic value = await getUser();
    _cName.text = value[0]["firstname"];
    _cLastName.text = value[0]["lastname"];
    _cPhoneNumber.text = value[0]["tele_num"];
    _cEmail.text = value[0]["username"];
    _cWebSite.text = value[0]["address"];
    print(value);
  }

  static Future<dynamic> updateProfile(
      username, firstName, lastName, telenumber, adress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('username');
    print(stringValue);
    print("update User details");
    String requestUrl = "http://192.168.1.4:5000/api/Dataupadte";
    Map<String, String> headers = {"Content-type": "application/json"};
    http.Response response = await http.put(
      requestUrl,
      headers: headers,
      body: jsonEncode(<String, String>{
        "username": username,
        "firstname": firstName,
        "lastname": lastName,
        "telenumber": telenumber,
        "address": adress
      }),
    );
    return response.body;
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextFormField inputName = TextFormField(
      controller: _cName,
      inputFormatters: [
        LengthLimitingTextInputFormatter(45),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'first Name',
        icon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Obrigatório';
        }
        return null;
      },
    );
    TextFormField inputLastName = TextFormField(
      controller: _cLastName,
      inputFormatters: [
        LengthLimitingTextInputFormatter(45),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'last Name',
        icon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Obrigatório';
        }
        return null;
      },
    );

    TextField inputPhoneNumber = new TextField(
      maxLength: 16,
      controller: _cPhoneNumber,
      keyboardType: TextInputType.phone,
      decoration: new InputDecoration(
        labelText: "phone",
        icon: Icon(Icons.phone),
      ),
    );

    TextFormField inputEmail = TextFormField(
      controller: _cEmail,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'E-mail',
        icon: Icon(Icons.email),
      ),
    );

    TextFormField inputWebSite = TextFormField(
      controller: _cWebSite,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Adress',
        icon: Icon(Icons.home),
      ),
    );

    Column picture = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[],
    );

    ListView body = ListView(
      padding: EdgeInsets.all(20),
      children: <Widget>[
        SizedBox(height: 20),
        picture,
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              inputName,
              inputLastName,
              inputPhoneNumber,
              inputEmail,
              inputWebSite,
            ],
          ),
        )
      ],
    );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff3B3F42),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text("Edit profile"),
          actions: <Widget>[
            Container(
              width: 80,
              child: IconButton(
                icon: Text(
                  'SAVE',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  if (_cEmail.text != "" &&
                      _cName.text != "" &&
                      _cLastName.text != "" &&
                      _cPhoneNumber.text != "" &&
                      _cWebSite.text != "") {
                    dynamic value = await updateProfile(
                        _cEmail.text,
                        _cName.text,
                        _cLastName.text,
                        _cPhoneNumber.text,
                        _cWebSite.text);
                    print(value);
                    if (jsonDecode(value)["success"] == "Update sucessfull") {
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.LEFTSLIDE,
                        headerAnimationLoop: false,
                        dialogType: DialogType.SUCCES,
                        title: 'Succes',
                        desc: 'profile updated',
                        btnOkOnPress: () {
                          debugPrint('OnClcik');
                        },
                        btnOkIcon: Icons.check_circle,
                      )..show();
                    } else {
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.WARNING,
                          headerAnimationLoop: false,
                          animType: AnimType.TOPSLIDE,
                          title: 'Warning',
                          desc: 'please verifie your data',
                          btnOkOnPress: () {})
                        ..show();
                    }
                  } else {
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.WARNING,
                        headerAnimationLoop: false,
                        animType: AnimType.TOPSLIDE,
                        title: 'Warning',
                        desc: 'please verifie your data',
                        btnOkOnPress: () {})
                      ..show();
                  }
                },
              ),
            )
          ],
        ),
        body: body);
  }
}
