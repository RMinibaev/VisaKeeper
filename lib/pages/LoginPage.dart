import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import '../util/Validations.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String stateName = "choose";

  GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
      //'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<FirebaseUser> _handleSignIn(String signType) async {
    FirebaseUser user;
    switch (signType) {
      case "anon":
        break;
      case "google":
        try {
          GoogleSignInAccount googleUser = await _googleSignIn.signIn();
          GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          user = await _auth.signInWithGoogle(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          print("signed in " + user.uid);
        } catch (error) {
          print(error);
        }
        break;
      case "email":
        user = await _auth.signInWithEmailAndPassword();
        print("signed in " + user.uid);
        break;
      case "facebook":
        break;
    }
    return user;
  }

  void _Buttonpressed(String choosed) {
    //stateName = choosed;
    //setState(() {});
    switch (choosed) {
      case "google":
        _handleSignIn(choosed);
        break;
      case "email":
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var emailField = new Form(
        key: _formKey,
        autovalidate: _autovalidate,
        //onWillPop: _warnUserAboutInvalidData,
        child: new Column(
          children: <Widget>[
            new InputField(
              hintText: "Username",
              obscureText: false,
              textInputType: TextInputType.text,
              textStyle: textStyle,
              textFieldColor: textFieldColor,
              icon: Icons.person_outline,
              iconColor: Colors.white,
              bottomMargin: 20.0,
              validateFunction: _validations.validateName,
              onSaved: (String name) {
                newUser.displayName = name;
              },
            ),
            new InputField(
                hintText: "Email",
                obscureText: false,
                textInputType: TextInputType.emailAddress,
                textStyle: textStyle,
                textFieldColor: textFieldColor,
                icon: Icons.mail_outline,
                iconColor: Colors.white,
                bottomMargin: 20.0,
                validateFunction: _validations.validateEmail,
                onSaved: (String email) {
                  newUser.email = email;
                }),
            new InputField(
                hintText: "Password",
                obscureText: true,
                textInputType: TextInputType.text,
                textStyle: textStyle,
                textFieldColor: textFieldColor,
                icon: Icons.lock_open,
                iconColor: Colors.white,
                bottomMargin: 40.0,
                validateFunction: _validations.validatePassword,
                onSaved: (String password) {
                  newUser.password = password;
                }),
            new RoundedButton(
                buttonName: "Continue",
                onTap: _handleSubmitted,
                width: screenSize.width,
                height: 50.0,
                bottomMargin: 10.0,
                borderWidth: 1.0)
          ],
        ));
    switch (stateName) {
      case "google":
        return new Material();

      default:
        return new Material(
            //color: Colors.white,
            child: new Center(
                child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "Choose authentication way:",
              textScaleFactor: 1.6,
            ),
            new Container(
              width: MediaQuery.of(context).size.width - 64,
              padding: new EdgeInsets.all(16.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new IconButton(
                    splashColor: Colors.redAccent,
                    icon: new Image.asset("assets/google.png"),
                    onPressed: () {
                      _Buttonpressed("google");
                    },
                    iconSize: 56.0,
                    //*cover with red, 0.25 sec, then fade animation to login form*,
                  ),
                  new IconButton(
                    splashColor: Colors.redAccent,
                    icon: new Image.asset("assets/email.png"),
                    onPressed: () => _Buttonpressed('email'),
                    iconSize: 56.0,
                  ),
                ],
              ),
            ),
          ],
        )));
        break;
    }
  }
}
