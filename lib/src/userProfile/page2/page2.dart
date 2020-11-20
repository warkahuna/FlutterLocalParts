import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Homepage/custom_navigation_bar.dart';
import 'package:flutter_login_signup/src/Homepage/custome_navigation_bar.dart';
import 'package:flutter_login_signup/src/Parts/Devoirs/Devoirs.dart';
import 'package:flutter_login_signup/src/navBar.dart';
import 'package:flutter_login_signup/src/userProfile/page2/part_view.dart';
import 'package:flutter_login_signup/src/userProfile/page2/partsDetails.dart';
import 'package:flutter_login_signup/src/userProfile/page2/parts_feeder.dart';
import 'package:flutter_login_signup/src/userProfile/page2/part.dart';
import 'package:http/http.dart' as http;
import 'header.dart';
import 'pitem.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  List<Part> parts = new List<Part>();
  int _currentIndex = 4;

  List<int> _badgeCounts = List<int>.generate(5, (index) => index);

  List<bool> _badgeShows = List<bool>.generate(5, (index) => true);
  bool isLoading = true;
  void assin() async {
    List<dynamic> value = await PartsFeeder.getParts();

    int i = 0;
    value.forEach((dynamic entry) {
      Part p = new Part(
          value[i]["idparts"], value[i]["vues"], value[i]["String_image"]);

      parts.add(p);
      i++;
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    assin();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Header(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.63,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 60.0,
                      height: 6.0,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 18.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          PItem(),
                          SizedBox(height: 32.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                color: Color(0xff9ba1a6),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                padding: EdgeInsets.all(0.0),
                                onPressed: () {},
                                child: Text(
                                  "Add Parts",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              /*FollowCard(
                                title: "FRIENDS",
                                subtitle: "2353",
                              ),
                              FollowCard(
                                title: "FOLLOWING",
                                subtitle: "2353",
                              ),
                              FollowCard(
                                title: "FOLLOWERS",
                                subtitle: "2353",
                              ),*/
                            ],
                          ),
                          SizedBox(height: 32.0),
                          Text(
                            'Garage',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          /*Container(
                            height: 40.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.only(right: 6.0),
                                width: 40.0,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage("https://i.pravatar.cc/300"),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 32.0),
                          Text(
                            'Photos',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),*/
                          Container(
                            height: 150.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  child: PartView(parts[index].id,
                                      parts[index].vues, parts[index].imageUrl),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PartsDetails(
                                                idPart: parts[index].id)));
                                  },
                                );
                              },
                              itemCount: parts.length,
                            ),
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
    );
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
