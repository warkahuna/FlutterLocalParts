import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Homepage/custom_navigation_bar.dart';
import 'package:flutter_login_signup/src/Homepage/custome_navigation_bar.dart';
import 'package:flutter_login_signup/src/Parts/Devoirs/Devoirs.dart';
import 'package:flutter_login_signup/src/Widget/bezierContainer.dart';
import 'package:flutter_login_signup/src/filter/filterlist.dart';
import 'package:flutter_login_signup/src/navBar.dart';
import 'package:flutter_login_signup/src/userProfile/page2/page2.dart';
import 'package:flutter_login_signup/src/userProfile/page2/part_view.dart';
import 'package:flutter_login_signup/src/userProfile/page2/parts_feeder.dart';
import 'package:http/http.dart' as http;
import '../../Part.dart';
import 'header.dart';
import 'pitem.dart';

class PartsDetails extends StatefulWidget {
  final int idPart;
  PartsDetails({Key key, @required this.idPart}) : super(key: key);

  @override
  _PartsDetailsState createState() => _PartsDetailsState();
}

class _PartsDetailsState extends State<PartsDetails> {
  int _currentIndex = 4;

  List<int> _badgeCounts = List<int>.generate(5, (index) => index);

  List<bool> _badgeShows = List<bool>.generate(5, (index) => true);

  TextEditingController priceController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController referanceController = new TextEditingController();
  TextEditingController categoryController = new TextEditingController();
  TextEditingController other1Controller = new TextEditingController();
  TextEditingController content1Controller = new TextEditingController();
  TextEditingController other2Controller = new TextEditingController();
  TextEditingController content2Controller = new TextEditingController();
  TextEditingController other3Controller = new TextEditingController();
  TextEditingController content3Controller = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController imageController = new TextEditingController();
  Part part;

  List categorys = [
    "Brakes",
    "Filtering/Oil,Suspension and Steering",
    "Transmission-Gearbox",
    "Exterior/Interior Equipment and Accessories",
    "Engine compartment",
    "Exhaust",
    "Electrical and lighting",
    "Air conditioning",
    "Locks-closure",
    "Tyres",
    "Others",
  ];
  int _value = 1;

  Widget _buildOriginDesign() {
    return CustomNavigationBar(
      iconSize: 30.0,
      selectedColor: Colors.white,
      strokeColor: Colors.white,
      unSelectedColor: Color(0xff6c788a),
      backgroundColor: Color(0xff040307),
      items: [
        CustomNavigationBarItem(
          icon: Icons.home,
        ),
        CustomNavigationBarItem(
          icon: Icons.shopping_cart,
        ),
        CustomNavigationBarItem(
          icon: Icons.lightbulb_outline,
        ),
        CustomNavigationBarItem(
          icon: Icons.search,
        ),
        CustomNavigationBarItem(
          icon: Icons.account_circle,
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DevoirsPage()));
            break;
          case 1:
            break;
          case 2:
            break;
          case 3:
            break;
          case 4:
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Page2()));
            break;
          default:
        }
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  Widget _header() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        children: <Widget>[
          Image.memory(base64Decode(imageController.text),
              height: 1000, width: 2000, fit: BoxFit.fitWidth),
          Container(
            color: Colors.black45,
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyAppFilter()));
                  },
                ),
                Text(
                  widget.idPart.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 32.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.grey[300],
                  filled: true))
        ],
      ),
    );
  }

  Future<void> setPart(value) async {
    List<dynamic> value = await getPart(widget.idPart);
    print(value);
    priceController.text = value[0]["Price"].toString();
    referanceController.text = value[0]["refrence"];
    nameController.text = value[0]["name"];
    other1Controller.text = value[0]["other1"].split(',')[0];
    content1Controller.text = value[0]["other1"].split(',')[1];
    other2Controller.text = value[0]["other2"].split(',')[0];
    content2Controller.text = value[0]["other2"].split(',')[1];
    other3Controller.text = value[0]["other3"].split(',')[0];
    content3Controller.text = value[0]["other3"].split(',')[1];
    descriptionController.text = value[0]["tag_description"];
    imageController.text = value[0]["String_image"];
    categoryController.text = value[0]["Type"];
    _value = categorys.indexOf(categoryController.text) + 1;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setPart(widget.idPart);
    //_value = categorys.indexOf(categoryController.text) - 1;
  }

  static Future<dynamic> getPart(idpart) async {
    print("get Part details");
    String requestUrl = "http://192.168.1.4:5000/api/parts/getPartsId";
    Map<String, String> headers = {"Content-type": "application/json"};
    http.Response response = await http.post(
      requestUrl,
      headers: headers,
      body: jsonEncode(<String, int>{
        'idpart': idpart,
      }),
    );
    List<dynamic> data = json.decode(response.body);
    return data;
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        dynamic value = await updatePart(
            widget.idPart,
            referanceController.text,
            categoryController.text,
            descriptionController.text,
            other1Controller.text,
            other2Controller.text,
            other3Controller.text,
            content1Controller.text,
            content2Controller.text,
            content3Controller.text,
            nameController.text,
            imageController.text);
        if (jsonDecode(value)["succes"] == "part updated sucessfully") {
          AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.SUCCES,
            title: 'Succes',
            desc: 'part updated',
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
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff9ba1a6), Color(0xff3B3F42)])),
        child: Text(
          'Save',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  static Future<String> updatePart(idpart, refrence, type, description, other1,
      other2, other3, content1, content2, content3, name, imagey) async {
    print("update part");
    String requestUrl = "http://192.168.1.4:5000/api/parts/updatePart";
    Map<String, String> headers = {"Content-type": "application/json"};
    http.Response response = await http.put(
      requestUrl,
      headers: headers,
      body: jsonEncode(<String, String>{
        "idparts": idpart.toString(),
        "refrence": refrence,
        "Type": type,
        "tag_description": description,
        "other1": other1 + "," + content1,
        "other2": other2 + "," + content2,
        "other3": other3 + "," + content2,
        "name": name,
        "String_image": imagey
      }),
    );
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          _header(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10.0),
                          bottom: Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          _entryField("price", priceController),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10.0),
                          bottom: Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Text('UPDATE INFO'),
                          _entryField("Name", nameController),
                          _entryField("Referance", referanceController),
                          Text("current applied category: " +
                              categoryController.text),
                          Container(
                            padding: EdgeInsets.all(20.0),
                            child: DropdownButton(
                                isExpanded: true,
                                value: _value,
                                items: [
                                  DropdownMenuItem(
                                    child: Text("Brakes"),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                        "Filtering/Oil,Suspension and Steering"),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Transmission-Gearbox"),
                                      value: 3),
                                  DropdownMenuItem(
                                      child: Text(
                                          "Exterior/Interior Equipment and Accessories"),
                                      value: 4),
                                  DropdownMenuItem(
                                      child: Text("Engine compartment"),
                                      value: 5),
                                  DropdownMenuItem(
                                      child: Text("Exhaust"), value: 6),
                                  DropdownMenuItem(
                                      child: Text("Electrical and lighting"),
                                      value: 7),
                                  DropdownMenuItem(
                                      child: Text("Air conditioning"),
                                      value: 8),
                                  DropdownMenuItem(
                                      child: Text("Locks-closure"), value: 9),
                                  DropdownMenuItem(
                                      child: Text("Tyres"), value: 10),
                                  DropdownMenuItem(
                                      child: Text("Others"), value: 11),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
                                    categoryController.text =
                                        categorys[_value - 1];
                                  });
                                }),
                          ),
                          _entryField("Label ", other1Controller),
                          _entryField("Content ", content1Controller),
                          _entryField("Label ", other2Controller),
                          _entryField("Content ", content2Controller),
                          _entryField("Label ", other3Controller),
                          _entryField("Content ", content3Controller),
                          _entryField("Descrtiption ", descriptionController),
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10.0),
                                bottom: Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                _submitButton(),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            child: Text(
                                "please make sure to verifie your data before saving"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: _buildOriginDesign(),
            ),
          ),
        ],
      ),
    ));
  }
}

class FollowCard extends StatelessWidget {
  final title;
  final subtitle;

  const FollowCard({Key key, this.title, this.subtitle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: Colors.black38,
            fontSize: 12.0,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          subtitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }
}
