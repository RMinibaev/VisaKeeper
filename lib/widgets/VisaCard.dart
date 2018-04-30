import 'package:flutter/material.dart';
import '../entities/Visa.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

import '../pages/EditPage.dart';

class VisaCard extends StatelessWidget {
  Visa visa;

  VisaCard(this.visa);
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new InkWell(
          onTap: () => _onTap(context),
          child: new Ink(
              padding: new EdgeInsets.all(8.0),
              height: 100.0,
              child: new Row(
                children: <Widget>[
                  new Container(
                      decoration: new BoxDecoration(
                        //color: Colors.purple,
                        borderRadius: new BorderRadius.only(
                          topLeft: new Radius.circular(8.0),
                          bottomLeft: new Radius.circular(8.0),
                        ),
                      ),
                      child: new Center(
                          child: new Container(
                              width: 120.0,
                              child: new Image.asset(
                                  'assets/flags/${visa.countryCode.toLowerCase()}.png')))),
                  new Expanded(
                    child: new Column(
                      children: <Widget>[
                        new Expanded(
                            child: new Container(
                                decoration: new BoxDecoration(
                                  // color: Colors.red,
                                  borderRadius: new BorderRadius.only(
                                    topRight: new Radius.circular(8.0),
                                  ),
                                ),
                                child: new Center(
                                    child: new Text(
                                  visa.countryName == null
                                      ? "Refresh plz"
                                      : visa.countryName,
                                  style: new TextStyle(fontSize: 24.0),
                                )))),
                        new Expanded(
                            child: new Container(
                                decoration: new BoxDecoration(
                                  //color: Colors.black,
                                  borderRadius: new BorderRadius.only(
                                    bottomRight: new Radius.circular(8.0),
                                  ),
                                ),
                                child: new Center(
                                    child: new Text(
                                  "expires in ${visa.endDate.difference(new DateTime.now()).inDays} day(s)",
                                  style: new TextStyle(
                                      fontSize: 22.0, color: getColor()),
                                )))),
                      ],
                    ),
                  )
                ],
              ))),
    );
  }

  _onTap(BuildContext context) async {
    Navigator.of(context).push(
          new MaterialPageRoute(builder: (context) => new EditPage(visa)),
        );
  }

  Color getColor() {
    int days = visa.endDate.difference(new DateTime.now()).inDays;
    if (days < 7) {
      return Colors.red;
    } else {
      if (days < 31) {
        return Colors.yellowAccent.shade700;
      } else
        return Colors.greenAccent.shade700;
    }
  }
}
