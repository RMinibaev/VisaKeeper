library country_code_picker;

import '../util/country_codes.dart';
import 'package:flutter/material.dart';
import '../util/selection_dialog.dart';
import '../util/celement.dart';

class CountryCodePicker extends StatefulWidget {
  final Function(String) onChanged;
  final String initialSelection;
  final List<String> favorite;

  CountryCodePicker({this.onChanged, this.initialSelection, this.favorite});

  @override
  State<StatefulWidget> createState() {
    List<Map> jsonList = codes;

    List<CElement> elements = jsonList
        .map((s) => new CElement(
              name: s['name'],
              code: s['code'],
              flag: s['flag'],
            ))
        .toList();
    return new _CountryCodePickerState(elements);
  }
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  CElement selectedItem;
  List<CElement> elements = [];

  _CountryCodePickerState(this.elements);

  @override
  Widget build(BuildContext context) => new GestureDetector(
        child: new Text(
          "${selectedItem.toString()}",
          style: new TextStyle(
              fontSize: 38.0,
              fontFamily: "Roboto",
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900),
        ),
        onTap: _showSelectionDialog,
      );

  @override
  initState() {
    if (widget.initialSelection != null) {
      selectedItem = elements.firstWhere(
          (e) =>
              (e.code.toUpperCase() == widget.initialSelection.toUpperCase()),
          orElse: () => elements[0]);
    } else {
      selectedItem = elements[0];
    }

    super.initState();
  }

  void _showSelectionDialog() {
    showDialog(
      context: context,
      child: new SelectionDialog(elements),
    ).then((e) {
      if (e != null) {
                  selectedItem = e;

       // setState(() { });
        if (widget.onChanged != null) {
          widget.onChanged(e.code);
        }
      }
    });
  }
}
