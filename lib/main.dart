import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/Pages/Home/home.dart';
import 'package:todo_app/Pages/Login/login.dart';
import 'package:todo_app/Pages/Register/register.dart';
import 'package:todo_app/Services/Auth/authentication.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = RegisterPage();
  Auth auth = Auth();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async{
    String? token = await auth.getToken();
    if(token != null) {
      currentPage = HomePage();
    } else {
      currentPage = LoginPage();
    }
  }



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent)
    );
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firebase Todo App',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: currentPage
    );
  }
}

