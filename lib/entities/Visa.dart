import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class Visa {
  String countryCode;
  String countryName;
  String documentID;
  String comment = "";
  DateTime startDate;
  DateTime endDate;

  Visa(this.countryCode, this.startDate, this.endDate,this.documentID);

  void setCountryName() async {
    String jsonFile = await rootBundle.loadString('assets/countriesList.json');
    Map<String, dynamic> countriesMap = json.decode(jsonFile);
    this.countryName = countriesMap[countryCode];
  }
}
