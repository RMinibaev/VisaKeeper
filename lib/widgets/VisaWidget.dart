import 'package:flutter/material.dart';
import '../entities/Visa.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

class VisaWidget extends StatelessWidget {
  Visa visa;

  @override
  Widget build(BuildContext context) {
    return new Material(
        child: new InkWell(
            child: new Ink(
                padding: new EdgeInsets.all(8.0),
                height: 100.0,
                child: new Row(
                  children: <Widget>[
                    new Container(
                        decoration: new BoxDecoration(
                          color: Colors.purple,
                          borderRadius: new BorderRadius.only(
                            topLeft: new Radius.circular(8.0),
                            bottomLeft: new Radius.circular(8.0),
                          ),
                        ),
                        child: new Center(
                            child: new Container(
                                width: 100.0,
                                child: new Image.asset(
                                    'assets/flags/${visa.countryCode.toLowerCase()}.png')))),
                    new Expanded(
                      child: new Column(
                        children: <Widget>[
                          new Expanded(
                              child: new Container(
                                  decoration: new BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: new BorderRadius.only(
                                      topRight: new Radius.circular(8.0),
                                    ),
                                  ),
                                  child: new Center(
                                      child: new Text(
                                    visa.countryName,
                                    style: new TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  )))),
                          new Expanded(
                              child: new Container(
                                  decoration: new BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: new BorderRadius.only(
                                      bottomRight: new Radius.circular(8.0),
                                    ),
                                  ),
                                  child: new Center(
                                      child: new Text(
                                    "${new DateFormat.yMMMd().format(visa.startDate)} - ${new DateFormat.yMMMd().format(visa.endDate)}",
                                    style: new TextStyle(
                                        color: Colors.white, fontSize: 18.0),
                                  )))),
                        ],
                      ),
                    )
                  ],
                ))));
  }
}
