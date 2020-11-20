import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../Part.dart';
import 'BulletinController.dart';
import 'components/light_colors.dart';
import 'components/top_container.dart';

import 'components/utisl.dart';

class DevoirsPage extends StatefulWidget {

  DevoirsPage({Key key}) : super(key: key);

  @override
  _DevoirsPageState createState() => _DevoirsPageState();
}

class _DevoirsPageState extends State<DevoirsPage> {

  List<Part> PartsData = new List<Part>();
  bool isLoading = true;

  void asyncInitState() async {
    BulletinController bulletinController = BulletinController() ;
    List<dynamic>value = await bulletinController.FetchBulletin();
    print('value length : '+value.length.toString());
    int i = 0 ;
    value.forEach((dynamic entry) {
    Part p = new Part();
    p.name = value[i]["name"];
    p.idparts = value[i]["idparts"];
    p.Final_Price = value[i]["Final_Price"];
    p.tag_description = value[i]["tag_description"];
    p.Type =  value[i]["Type"];
    p.String_image = value[i]["String_image"];
    PartsData.add(p);
    i++;
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    asyncInitState();
    super.initState();
    print("Parts data final length is "+PartsData.length.toString());
  }

  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  BulletinController bulletincontroller = new BulletinController() ;
  TextStyle linkStyle = TextStyle(color: Colors.blue);


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1));
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              height: 200,
              width: width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.menu,
                            color: LightColors.kDarkBlue, size: 30.0),
                        Icon(Icons.search,
                            color: LightColors.kDarkBlue, size: 25.0),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CircularPercentIndicator(
                            radius: 90.0,
                            lineWidth: 5.0,
                            animation: true,
                            percent: 0.75,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: LightColors.kRed,
                            backgroundColor: LightColors.kDarkYellow,
                            center: CircleAvatar(
                              backgroundColor: LightColors.kBlue,
                              radius: 35.0,
                           /*   backgroundImage: AssetImage(
                                'assets/images/avatar.png',
                              ),*/
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Devoirs',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.white,
                                    fontFamily: "Dosis",
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Nom Parent',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontFamily: "Dosis",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          getCategoryUI()
          ,
          SizedBox(

            width: 50.0,
            height: 10.0,
          ),
            Expanded(
                child:
                isLoading ?Center(child: CircularProgressIndicator()) :
                Expanded(
                    child: ListView.builder(
                        itemCount:this.PartsData.length ,
                        itemBuilder: (context, index) {
                          return _specialistsCardInfo(this.PartsData[index]) ;
                        }
                    )
                )

            ),
            SizedBox(
              width: 50.0,
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
  Widget _specialistsCardInfo(Part data) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
      margin: EdgeInsets.only(
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1.0,
              blurRadius: 6.0,
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.memory(base64Decode(data.String_image),
                height: 100, width: 100, fit: BoxFit.fitWidth )
              ,
              SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: data.name+'\n',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: data.Final_Price,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: data.tag_description,
                          style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        TextSpan(
                          text: data.Type,
                          style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(todo: data)));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: purpleGradient ,
                        borderRadius: BorderRadius.all(Radius.circular(80.0)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                            minWidth: 88.0,
                            minHeight: 36.0), // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: const Text(
                          'Consulter',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Icon(
            Icons.settings,
            color: Colors.blueAccent ,
            size: 36,
          ),
        ],
      ),
    );
  }
  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 50,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 15) ,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Prix',
                        style: linkStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('Jour click action');
                          })
                  ],
                ),
              )
              ,
              const SizedBox(
                width: 40,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 15) ,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Récent',
                        style: linkStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('Jour click action');
                          })
                  ],
                ),
              ),

              const SizedBox(
                width: 40,
              ),

              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 15) ,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Populaire',
                        style: linkStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('Jour click action');
                          })
                  ],
                ),
              ),

              const SizedBox(
                width: 40,
              )

            ],
          ),
        ),
      ],
    );
  }
//Get Category


}

/////////////

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final Part todo;

  // In the constructor, require a Todo.
  DetailScreen({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Over Image'),
      ),
      body:        Image.memory(base64Decode(todo.String_image),
          height: 300, width: 300, fit: BoxFit.fitHeight )
    );
  }

}
