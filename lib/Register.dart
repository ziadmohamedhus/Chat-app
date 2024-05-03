
import 'package:chat_app/Models/Button.dart';
import 'package:chat_app/Models/FormField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'Chat page.dart';

class Register extends StatefulWidget {

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                      'Register',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                TextForm_model(hintText: "Email",onChanged: (data){email=data;},color: Colors.black,),
                const SizedBox(height: 10,),
                TextForm_model(hintText: "Password",onChanged: (data){password=data;},obscureText: true,color: Colors.black,),
                const SizedBox(height: 20,),
                // ///////////////////////////////////////////////////
                CustomButon(
                  onTap: ()async{
                    if(form_key.currentState!.validate())
                      {
                        looding=true;
                        setState(() {});
                        try {
                          final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: email!,
                            password: password!,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success!The account created successfully.")));
                          Navigator.push(context, MaterialPageRoute(builder: (context) {return Chat_page(email!);}));
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sorry!this password is weak.")));
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sorry!The account already exists for that email.")));
                          }
                        } catch (e) {
                          print(e);
                        }
                        looding=false;
                        setState(() {});
                      }
                  },
                    text: "Submit"
                ),
                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'you have an account?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){Navigator.pop(context);},
                      child: Text(
                        '  login',
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
