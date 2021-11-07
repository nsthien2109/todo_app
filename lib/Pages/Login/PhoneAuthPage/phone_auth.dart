import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:todo_app/Pages/Login/PhoneAuthPage/Widget/text_field_phone.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({Key? key}) : super(key: key);

  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}


class _PhoneAuthPageState extends State<PhoneAuthPage> {

  int start = 30;
  String textButton = "Send";
  bool wait = false;
  TextEditingController phoneNumber = TextEditingController();
  String verificationId = "";
  String smsCode = "";
  void setTimer(){
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer){
      if(start == 0){
        setState(() {
          timer.cancel();
          start = 30;
          wait = false;
          textButton = "Resend";
        });
      }else{
        setState(() {
          start --;
          wait = true;
          textButton = "Waiting";
        });
      }
    });
  }
  void setData(verificationID){
    setState(() {
      verificationId = verificationID;
    });
    setTimer();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white,)),
        title: const Text("Login with phone number",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFieldPhone(phoneNumber: phoneNumber,timer: setTimer,textButton: textButton,wait: wait, setData: ()=> setData(verificationId),),
            const SizedBox(height: 50,),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 1,
                    color: Colors.white,
                  )
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Enter 5 OTP code" , style: TextStyle(color: Colors.white),),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      height: 1,
                      color: Colors.white,
                    )
                ),
              ],
            ),
            const SizedBox(height: 20,),
            OTPTextField(
              otpFieldStyle: OtpFieldStyle(
                backgroundColor: const Color(0xff1d1d1d),
              ),
              length: 5,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 50,
              style: const TextStyle(
                  fontSize: 20
              ),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                print("Completed: " + pin);
              },
            ),
            const SizedBox(height: 50,),
            RichText(text:  TextSpan(
                children: [
                  const TextSpan(text: "Send OTP again " ,style: TextStyle(fontSize: 12)),
                  TextSpan(text: "00:$start" ,style: const TextStyle(fontSize: 12,color: Colors.redAccent)),
                  const TextSpan(text: " sec" ,style: TextStyle(fontSize: 12)),
                ]
              )
            ),
            const SizedBox(height: 50,),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.yellow[200],
                borderRadius: BorderRadius.circular(17),
              ),
              child: TextButton(
                onPressed: (){},
                child: const Text("Verify", style: TextStyle(color: Colors.black,fontSize: 20),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
