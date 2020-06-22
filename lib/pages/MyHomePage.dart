import 'package:duffle/pages/Login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void checkauth() async{

    try{var curruser=await _auth.currentUser();
    if(curruser==null)
    {
      Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage()));
      return;
    }
    }
    catch(e)
    {
      print(e);
    }
  }
  FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkauth();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FlatButton(child: Text('home page'),
        onPressed: ()
        async  {
            try
            {await _auth.signOut();
            Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage()));
            }
            catch(e)
          {
            print(e);
          }

          },),
      ),
    );
  }
}
