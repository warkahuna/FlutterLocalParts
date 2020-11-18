import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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

  List<String> data = new List<String>();
  bool isLoading = true;

  void asyncInitState() async {
    BulletinController bulletinController = BulletinController() ;
    Map<String, dynamic> value = await bulletinController.FetchBulletin();
    print('value length : '+value.length.toString());
    value.forEach((String key, dynamic entry) {
      print("title :");
      print(value['title']);
      print("id :");
      print(value['id']);
      this.data.add(value['title']);
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
  }

  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  BulletinController bulletincontroller = new BulletinController() ;


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
            SizedBox(
              width: 50.0,
              height: 10.0,
            ),
            Expanded(
                child:
                isLoading ?Center(child: CircularProgressIndicator()) :
                Expanded(
                    child: ListView.builder(
                        itemCount:this.data.length ,
                        itemBuilder: (context, index) {
                          return _specialistsCardInfo(data[index]) ;
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
  Widget _specialistsCardInfo(String data) {
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
      /*        CircleAvatar(
                backgroundColor: Color(0xFFD9D9D9),
       //         backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTery_TX9LaD2_PDXZHtpuZXkvlkVAREwkC_w&usqp=CAU'),
                radius: 36.0,
              )*/
              SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: data+'\n',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'a rendre avant 04/09/2020',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: '\nPoplar Pharma Limited',
                          style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        TextSpan(
                          text: '\nDetails \nAbout the devoirs | 5 min',
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
                    onPressed: () {},
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
                          'Me Rappeler',
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
            Icons.book,
            color: Colors.blueAccent ,
            size: 36,
          ),
        ],
      ),
    );
  }


}
