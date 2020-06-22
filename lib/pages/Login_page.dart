import 'package:duffle/pages/Registerpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController mailctrl = TextEditingController();
  TextEditingController passctrl = TextEditingController();
  void logintheuser() async {
    String mail = mailctrl.text;
    String pass = passctrl.text;
    if (mail == "" || pass == "") {
      Fluttertoast.showToast(msg: "Please fill the details");
      return;
    } else {
      try {
        var user = await _auth.signInWithEmailAndPassword(email: mail, password: pass);
        if (user != null) {
          Fluttertoast.showToast(msg: "Login sucessfull");
          Navigator.pop(context);
          return;
        }

      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
        return;
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.yellow,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Container(
                  margin:
                      EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 20),
                  color: Colors.yellow,
                  child: Text('DUFFLE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.blue,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3,
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Center(
                  child: Text('SIGN IN',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 3,
                      )),
                ),
              ),
              Textbox(
                name: 'E-mail',
                type: TextInputType.emailAddress,
                controller: mailctrl,
              ),
              Textbox(
                name: 'Password',
                type: TextInputType.visiblePassword,
                hide: true,
                controller: passctrl,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 80, right: 80, top: 40, bottom: 40),
                child: FlatButton(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () {
                    logintheuser();
                  },
                ),
              ),
              Text(
                'No account?Sign up now',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.redAccent,
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 37, left: 20, right: 20, bottom: 0),
                child: FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Textbox extends StatelessWidget {
  Textbox(
      {@required this.name,
      @required this.type,
      this.hide = false,
      this.controller});
  final String name;
  final TextInputType type;
  final bool hide;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          labelText: name,
          labelStyle: TextStyle(
            fontSize: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          fillColor: Colors.white,
        ),
        keyboardType: type,
        obscureText: hide,
      ),
    );
  }
}
