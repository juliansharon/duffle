import 'package:duffle/pages/Login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:duffle/pages/profile.dart';
import 'package:duffle/pages/orders.dart';
import 'package:duffle/pages/dufflehome.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:duffle/pages/detailspage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool load=false;
FirebaseDatabase _database=FirebaseDatabase.instance;
int _currentindex = 0;
  void newuser() async{
    try
    {setState(() {
      load=true;
    });
      final user=await _auth.currentUser();
    if(user!=null) {

      final uid=user.uid;
      var data=(await _database.reference().child("users/$uid/details").once()).value;
      print(data);
      if(data==null)
        {
          setState(() {
            load=false;
          });
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Detailspage()));
        }
      setState(() {
        load=false;
      });

    }}
    catch(e)
    {  setState(() {
      load=false;
    });
      print(e);
    }
  }
  void checkauth() async {
    try {
      setState(() {
        load=true;
      });
      var curruser = await _auth.currentUser();
      if (curruser == null) {
        setState(() {
          load=false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
        return;
      }
      setState(() {
        load=false;
      });
    } catch (e) {
      print(e);
      setState(() {
        load=false;
      });
    }
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkauth();
    newuser();
  }

  void signout() async {
    try {
      await _auth.signOut();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      return;
    } catch (e) {
      print(e);
      return;
    }
  }
  final tabs=[
    Dufflehome(),
    Orders(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: Text('DUFFLE',
        style: TextStyle(
          letterSpacing: 2,
          color: Colors.blue,
        ))
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.yellow,
        currentIndex: _currentindex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              size: 35,
            ),
            title: Text(
              'Orders',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, size: 35),
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app, size: 35),
            title: Text(
              'Sign out',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ],
        onTap: (index) {
          if (index == 3) {
            signout();
          } else {
            setState(() {
              _currentindex = index;
            });
          }
        },
      ),
      body: load?SpinKitChasingDots(
        color: Colors.white,
      ):tabs[_currentindex],

    );
  }
}
