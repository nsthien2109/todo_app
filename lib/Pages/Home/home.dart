import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Services/Auth/authentication.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    Auth authGoogle = Auth();
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,

        actions: [
          IconButton(onPressed: ()async{
            await authGoogle.logOut(context);
          }, icon: const Icon(Icons.login_rounded))
        ],
      ),
      body: const Center(
        child: Text("Home Page"),
      ),
    );
  }
}
