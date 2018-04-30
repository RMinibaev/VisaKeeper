import 'package:flutter/material.dart';
import 'dart:async';
import './VisaCard.dart';
import '../entities/Visa.dart';
import '../util/VisaFirebaseModel.dart';

class VisaListWidget extends StatefulWidget {
  @override
  _VisaListWidgetState createState() => new _VisaListWidgetState();
}

class _VisaListWidgetState extends State<VisaListWidget> {
  int count = 0;
  List<Visa> visaList;
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new FutureBuilder(
      future: _asyncActions(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new CircularProgressIndicator(),
                new Container(
                  height: 8.0,
                ),
                new Text(
                  "Check your internet connection",
                  textScaleFactor: 1.3,
                ),
              ],
              //)
            );
          case ConnectionState.waiting:
            return new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new CircularProgressIndicator(),
                new Container(
                  height: 8.0,
                ),
                new Text(
                  "Loading",
                  textScaleFactor: 1.3,
                ),
              ],
              //)
            );
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return new RefreshIndicator(
                child: new ListView.builder(
                  itemCount: count,
                  itemBuilder: _itemBuilder,
                ),
                onRefresh: _onRefresh,
              );
        }
      },
    ));
  }

  Future<Null> _onRefresh() async {
    Completer<Null> completer = new Completer();
    completer.complete(_asyncActions());
    return completer.future;
  }

  Widget _itemBuilder(BuildContext context, int index) {
    VisaCard visaCard = new VisaCard(visaList.elementAt(index));
    return new Dismissible(
      key: new Key(visaList.elementAt(index).documentID),
      onDismissed: (DismissDirection dd) {
        showDialog(
          context: context,
          builder: (BuildContext context) => new AlertDialog(
                title: new Text("Do you really want to delete this visa?"),
                // content: new Text("Thi"),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        visaList.removeAt(index);
                      });
                    },
                    child: new Text("CANCEL"),
                  ),
                  new FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        VisaFirebaseModel.deleteVisa(
                            "username", visaList.elementAt(index).documentID);
                        visaList.removeAt(index);
                      });
                    },
                    child: new Text("DELETE"),
                  ),
                ],
              ),
        );
      },
      child: visaCard,
    );
  }

  Future<Null> _asyncActions() async {
    visaList = await VisaFirebaseModel.getVisasList('username');
    visaList.sort((Visa v1, Visa v2) =>v1.endDate.compareTo(v2.endDate));
    count = visaList.length;
  }
}
