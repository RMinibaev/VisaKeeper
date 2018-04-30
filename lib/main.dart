import 'package:flutter/material.dart';
import './widgets/VisaListWidget.dart';
import './widgets/AddVisaButton.dart';
import './pages/LoginPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Visa Keeper',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new MyHomePage(title: 'Your visas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return 
    new LoginPage()
   /* new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body:
         new Column(
          children: <Widget>[
            new Expanded(
              child: new VisaListWidget(),
            ),
            new AddVisaButton(),
          ],
        ))
        */
        ;
  }
}
