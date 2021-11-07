import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Pages/Login/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final FormKey = GlobalKey<FormState>();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    void register() async{
      final FormState? form = FormKey.currentState;
      if (form!.validate()) {
        try{
          UserCredential userCredential =  await firebaseAuth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Register success')),
          );
          var emailLogin =  userCredential.user!.email.toString();
          Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
        }catch(e){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      }
    }


    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios_rounded , color: Colors.white,)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Form(
            key: FormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Text("Register", style: TextStyle(color: Colors.white, fontSize: 35 , fontWeight: FontWeight.bold),),
                const SizedBox(height: 25,),
                const Text("Welcome to Todo Meta", style: TextStyle(color: Colors.white, fontSize: 18),),
                const SizedBox(height: 25,),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.yellow,
                      width: 1
                    ),
                  ),
                  child: TextButton(
                    onPressed: (){},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/google.png', fit: BoxFit.cover,),
                        const SizedBox(width: 15,),
                        const Text("Continue with Google" , style: TextStyle(color: Colors.white , fontSize: 15),)
                      ],
                    ),
                  )
                ),
                const SizedBox(height: 20,),
                Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: Colors.yellow,
                          width: 1
                      ),
                    ),
                    child: TextButton(
                      onPressed: (){},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/call.png', fit: BoxFit.cover,),
                          const SizedBox(width: 15,),
                          const Text("Continue with Mobile" , style: TextStyle(color: Colors.white , fontSize: 15),)
                        ],
                      ),
                    )
                ),
                const SizedBox(height: 25,),
                const Text("Or",style: TextStyle(color: Colors.white , fontSize: 15),),
                const SizedBox(height: 25,),
                TextFormField(
                  controller: email,
                  validator: (value) => !regExp.hasMatch(value!) ? "Email failed !" : null ,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    label: const Text("Enter your email",style: TextStyle(color: Colors.white),),
                    border: const OutlineInputBorder(
                      gapPadding: 5,
                      borderSide: BorderSide(
                        color: Colors.white
                      )
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    )
                  ),
                ),
                const SizedBox(height: 25,),
                TextFormField(
                  controller: password,
                  validator: (value) => value!.length <= 6 ? "Password must be longer 6 character" : null ,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      label: const Text("Enter your password",style: TextStyle(color: Colors.white),),
                      border: const OutlineInputBorder(
                          gapPadding: 5,
                          borderSide: BorderSide(
                              color: Colors.white
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      )
                  ),
                ),
                const SizedBox(height: 25,),
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.yellow[200],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextButton(
                    onPressed: register,
                    child: const Text("Register",style: TextStyle(color: Colors.black87 , fontSize: 20),),
                  ),
                ),
                const SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Do you have already an account ?",style: TextStyle(color: Colors.white , fontSize: 16)),
                    TextButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage())), child: const Text("Login",style: TextStyle(color: Colors.white , fontSize: 17)))
                  ],
                ),
                TextButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage())), child: const Text("Forgot password ?",style: TextStyle(color: Colors.white , fontSize: 17)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
