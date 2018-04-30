import 'package:flutter/material.dart';
import '../entities/Visa.dart';
import '../widgets/DateTimePicker.dart';
import '../widgets/EditFooterButtons.dart';
import '../util/country_code_picker.dart';

class EditPage extends StatefulWidget {
  Visa visa;

  EditPage(this.visa);

  @override
  _EditPageState createState() => new _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String countryCode;
  DateTime _fromDate;
  DateTime _toDate;
  String comment;

  void initState() {
    super.initState();
    countryCode = widget.visa.countryCode;
    _fromDate = widget.visa.startDate;
    _toDate = widget.visa.endDate;
    comment = widget.visa.comment;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Visa info"),
      ),
      body: new Column(children: <Widget>[
        new Expanded(
            child: new Column(
          children: <Widget>[
            new CountryCodePicker(
              onChanged: (String s) {
                setState(() {
                  countryCode = s;
                  widget.visa.countryCode = s;
                });
              },
              initialSelection: countryCode,
            ),
            new Container(
                margin: new EdgeInsets.symmetric(horizontal: 8.0),
                height: 160.0,
                child: new Row(
                  children: <Widget>[
                    new Container(
                      width: 249.0,
                      child: new Image.asset(
                          'assets/flags/${countryCode.toLowerCase()}.png'),
                    ),
                    new Expanded(
                        child: new Container(
                            margin: new EdgeInsets.only(left: 8.0, bottom: 8.0),
                            child: new Column(
                              children: <Widget>[
                                new Expanded(
                                  child: new DateTimePicker(
                                    labelText: 'From',
                                    selectedDate: _fromDate,
                                    selectDate: (DateTime date) {
                                      setState(() {
                                        _fromDate = date;
                                        widget.visa.startDate = date;
                                      });
                                    },
                                  ),
                                ),
                                new Expanded(
                                  child: new DateTimePicker(
                                    labelText: 'To',
                                    selectedDate: _toDate,
                                    selectDate: (DateTime date) {
                                      setState(() {
                                        if (date.isBefore(_fromDate)) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                new AlertDialog(
                                                  title: new Text("Choose another date"),
                                                  content: new Text("Expiration date should be later than the start date"),
                                                  actions: <Widget>[
                                                    new FlatButton(
                                                      onPressed: () => Navigator.pop(context),
                                                      child: new Text("OK"),
                                                    )
                                                  ],
                                                ),
                                          );
                                        } else {
                                          _toDate = date;
                                          widget.visa.endDate = date;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ))),
                  ],
                )),
            new Container(
              margin: new EdgeInsets.all(8.0),
              child: new TextField(
                controller:
                    new TextEditingController(text: widget.visa.comment),
                onChanged: (String s) {
                  widget.visa.comment = s;
                },
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: 'Your note',
                ),
                style: Theme
                    .of(context)
                    .textTheme
                    .display1
                    .copyWith(fontSize: 20.0),
              ),
            ),
          ],
        )),
        //bottom bar (delete/save)
        new EditFooter(widget.visa),
      ]),
    );

    //end country info
  }
}
