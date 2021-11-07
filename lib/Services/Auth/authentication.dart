import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/Pages/Home/home.dart';
import 'package:todo_app/Pages/Login/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class Auth {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;
  final storage = const FlutterSecureStorage();

  Future<void> googleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        try {
          UserCredential userCredential =
              await firebaseAuth.signInWithCredential(authCredential);
          storeTokenAndData(userCredential);
          user = userCredential.user;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      }
    } catch (error) {
      print("ERORR HERE : ===> " + error.toString());
    }
  }

  Future<void> logOut(BuildContext context )async {
    try{
      await storage.delete(key: 'token');
      //await storage.deleteAll();
      await firebaseAuth.signOut();
      await _googleSignIn.disconnect();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false);
    }catch(e){
      print(e);
    }
  }

  Future<void> storeTokenAndData(UserCredential userCredential) async{
    await storage.write(key: 'token', value: userCredential.credential!.token.toString());
    await storage.write(key: 'userCredential', value: userCredential.toString());
  }

  Future<String?> getToken() async{
    return await storage.read(key: 'token');
  }

  Future<void> verifyNumberPhone(BuildContext context,String phoneNumber,Function setData)async{
    PhoneVerificationCompleted verificationCompleted = (PhoneAuthCredential phoneAuthCredential) async {
      showSnackBar(context, "Verification completed");
    };
    PhoneVerificationFailed verificationFailed = (FirebaseException e) {
      showSnackBar(context, e.toString());
    };
    PhoneCodeSent codeSent = (String? verificationID , [int? forceResendingToken]) {
      showSnackBar(context, "Verify OTP sending to your phone");
      setData(verificationID);
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String? verifiticationID){
      showSnackBar(context, "Time out");
    };
    try{
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout
      );
    }catch(er){
      showSnackBar(context, er.toString());
    }
  }

  void showSnackBar(BuildContext context, String text){
    final snackBar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'Hide',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
  }
}
