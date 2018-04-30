import 'package:flutter/material.dart';
import '../pages/EditPage.dart';
import '../entities/Visa.dart';
import '../util/VisaFirebaseModel.dart';

class AddVisaButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
        child: new InkWell(
            onTap: () => _onTap(context),
            child: new Ink(
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.red.shade600,
              child: new Center(
                  child: new Text("ADD VISA",
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ))),
            )));
  }

  _onTap(BuildContext context) async {
    Navigator.of(context).push(new MaterialPageRoute(
          builder: (context) => new EditPage(new Visa("US", new DateTime.now(),
              new DateTime.now().add(new Duration(days: 1)), VisaFirebaseModel.createNewDocumentID("username"))),
        ));
  }
}
