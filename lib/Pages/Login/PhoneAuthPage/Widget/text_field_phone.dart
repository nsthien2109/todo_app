import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Services/Auth/authentication.dart';

class TextFieldPhone extends StatefulWidget {
  Function timer;
  String textButton;
  bool wait;
  TextEditingController phoneNumber;
  Function setData;
  TextFieldPhone({Key? key,required this.phoneNumber, required this.timer,required this.textButton ,required this.wait ,required this.setData}) : super(key: key);

  @override
  _TextFieldPhoneState createState() => _TextFieldPhoneState();
}

class _TextFieldPhoneState extends State<TextFieldPhone> {
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15)
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: widget.phoneNumber,
        style: const TextStyle(color: Colors.white,fontSize: 18),
        decoration: InputDecoration(
          label: Text("Enter your number phone" ,style: TextStyle(color: Colors.grey[500],fontSize: 18) ,),
          prefixIcon: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text("+84",style: TextStyle(color: Colors.white,fontSize: 18),),
          ),
          suffixIcon: TextButton(
            onPressed: () async{
              if(widget.wait == false){
                widget.timer();
                await auth.verifyNumberPhone(context, "+84${widget.phoneNumber}",widget.setData);
              }else{
                null;
              }
            },
            child: Text(widget.textButton ,style: const TextStyle(color: Colors.white,fontSize: 18),),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
          ),

        ),

      ),
    );
  }
}
