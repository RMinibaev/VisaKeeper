import '../entities/Visa.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class VisaFirebaseModel {
  static Future<List<Visa>> getVisasList(String username) async {
    List<DocumentSnapshot> docList =
        (await Firestore.instance.collection(username).getDocuments())
            .documents;
    List<Visa> visaList = new List<Visa>();
    await docList.forEach((DocumentSnapshot ds) async {
      Visa visa = new Visa(
          ds["countryCode"], ds["startDate"], ds["endDate"], ds.documentID);
      visa.comment = ds["commentary"];
      visa.setCountryName();
      visaList.add(visa);
    });
    return visaList;
  }

  static String createNewDocumentID(String username) {
    return Firestore.instance.collection(username).document().documentID;
  }

  static Future<String> saveVisa(String username, Visa visa) async {
    DocumentReference documentReference =
        Firestore.instance.collection(username).document(visa.documentID);
    if (visa != null) {
      documentReference.setData({
        'countryCode': visa.countryCode,
        'startDate': visa.startDate,
        'endDate': visa.endDate,
        'commentary': visa.comment
      });
    }
    return documentReference.documentID;
  }

  static deleteVisa(String username, String documentID) {
    Firestore.instance.collection(username).document(documentID).delete();
  }
}
