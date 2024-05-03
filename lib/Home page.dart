
import 'package:chat_app/Chat%20page.dart';
import 'package:chat_app/Models/Button.dart';
import 'package:chat_app/Models/FormField.dart';
import 'package:chat_app/Register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Home_page extends StatefulWidget {
   Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  String? email;

  String? password;

  bool looding=false;

  GlobalKey<FormState>form_key=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall: looding,
      child: Scaffold(
        backgroundColor: Color(0xff2B475E),
        appBar: AppBar(title: Text('Chat app'),),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: form_key,
              child: Column(children: [
                Image.asset('assets/images/scholar.png'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 75,),
                Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                TextForm_model(hintText: "Email",onChanged: (data) {email=data;},color: Colors.black,),
                const SizedBox(height: 10,),
                TextForm_model(hintText: "Password",onChanged: (data) {password=data;},obscureText: true,color: Colors.black,),
                const SizedBox(height: 20,),
                ////////////////////////////////////////////////////////////////////////////////////////////////
                CustomButon(
                  onTap: ()async
                  {
                    if(form_key.currentState!.validate())
                      {
                        looding=true;
                        setState(() {});
                        try {
                          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: email!,
                              password: password!,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success!")));
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sorry!No user found for that email.")));
                          } else if (e.code == 'wrong-password') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sorry!Wrong password provided for that user.")));
                          }
                        }
                        looding=false;
                        setState(() {});

                      }
                    Navigator.push(context, MaterialPageRoute(builder: (context) {return Chat_page(email!);}));

                  },
                    text: "Submit"
                ),
                ////////////////////////////////////////////////////////////////////////////////////////////////////////
                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'dont\'t have an account?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) {return Register();}));},
                      child: Text(
                          '  Register',
                          style: TextStyle(
                            color: Color(0xffC7EDE6),
                          ),
                        ),
                    ),

                  ],
                ),


              ],),
            ),
          ),
        ),
      ),
    );
  }
}
