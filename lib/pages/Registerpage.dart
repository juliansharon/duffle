import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController mailctrl = TextEditingController();
  TextEditingController passctrl = TextEditingController();
  TextEditingController rpassctrl = TextEditingController();

  void authenticatetheuser() async {
    String mail = mailctrl.text;
    String pass = passctrl.text;
    String rpass = rpassctrl.text;
    if (mail == "" || pass == "" || rpass == "") {
      Fluttertoast.showToast(msg: "Please fill the details");
      return;
    } else if (pass != rpass) {
      Fluttertoast.showToast(
          msg: "your password and retyped password is not matching");
      return;
    } else {
      try {
        var user = await _auth.createUserWithEmailAndPassword(
            email: mail, password: pass);
        if (user != null) {
          Fluttertoast.showToast(msg: 'Registered successfully');
          Navigator.pop(context);
        }
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Center(
                  child: Text('SIGN UP',
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
                  controller: mailctrl),
              Textbox(
                  name: 'Password',
                  type: TextInputType.visiblePassword,
                  hide: true,
                  controller: passctrl),
              Textbox(
                  name: 'Retype Password',
                  type: TextInputType.visiblePassword,
                  hide: true,
                  controller: rpassctrl),
              Container(
                margin: EdgeInsets.only(left: 80, right: 80, top: 40, bottom: 20),
                child: FlatButton(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () {
                    authenticatetheuser();
                  },
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'already have an account?sign in',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                child: FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Text(
                      'SIGN IN',
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
      @required this.controller});
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
