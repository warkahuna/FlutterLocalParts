import 'dart:convert';

import 'package:flutter/material.dart';

class PartView extends StatelessWidget {
  int id;
  int vues;
  String image;

  PartView(this.id, this.vues, this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6.0),
      width: 100.0,
      child: Stack(
        children: <Widget>[
          Image.memory(base64Decode(image),
              height: 100, width: 100, fit: BoxFit.fitWidth),
          Container(
            height: 15,
            alignment: Alignment.topLeft,
            color: Colors.black.withOpacity(0.7),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 5.0),
            child: Row(
              children: <Widget>[
                Text(
                  vues.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
