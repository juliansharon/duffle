import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class Detailspage extends StatefulWidget {
  @override
  _DetailspageState createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {
  bool load=false;
  TextEditingController namectrl=TextEditingController();

  TextEditingController agectrl=TextEditingController();

  TextEditingController genderctrl=TextEditingController();

  FirebaseAuth _auth=FirebaseAuth.instance;
  FirebaseDatabase _database=FirebaseDatabase.instance;


  void adddata() async
  {String name=namectrl.text,address=agectrl.text,gender=genderctrl.text;
    if(name=="" || address=="" || gender=="")
      {
        Fluttertoast.showToast(msg: "Please fill the details");
        return;
      }
    else
      {  var user=await _auth.currentUser();
        var ref= await _database.reference().child('users').child(user.uid).child("details").set({
          "name":name,
          "address":address,
          "gender":gender
        }).then((value){print("success");
        setState(() {
          load=false;
        });
        Navigator.pop(context);});

        String email=user.email;

  }}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async
      {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.yellow,
        body: ModalProgressHUD(
          inAsyncCall: load,
          child: Center(
            child: SafeArea(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Text('WELCOME TO DUFFLE'
                        '\n\nYour Details',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      fontSize: 30,
                    ),),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    flex: 1,
                    child: Textfield(name: 'Name',controller: namectrl,),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    flex: 1,
                    child: Textfield(name: 'Address',controller: agectrl,),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    flex: 1,
                    child: Textfield(name: 'gender',controller: genderctrl,),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    flex:2 ,
                    child: Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: MaterialButton(
                        color: Colors.blue,
                       height: 50,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(16),
                       ),
                        child: Text('Add to Cloud',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                        ),),
                        onPressed: (){
                          setState(() {
                            load=true;
                          });
                          adddata();
                          setState(() {
                            load=false;
                          });
                        },
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Textfield extends StatelessWidget {
  Textfield({@required this.name,@required this.controller});
  final String  name;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: name,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          )

        ),
      ),
    );
  }
}
