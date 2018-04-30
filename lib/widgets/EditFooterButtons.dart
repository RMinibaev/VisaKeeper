import 'package:flutter/material.dart';
import '../util/VisaFirebaseModel.dart';
import '../entities/Visa.dart';

class EditFooter extends StatelessWidget {
  Visa visa;
  EditFooter(this.visa);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.all(8.0),
            child: new RaisedButton(
              child: new Text("SAVE"),
              onPressed: () => _onSaveTap(context),
            ),
          ),
        ],
      ),
    );
  }

  _onSaveTap(BuildContext context) {
    VisaFirebaseModel.saveVisa('username', visa).then((String f) {
      visa.documentID = f;
      Navigator.pop(context);
    });
  }
}
