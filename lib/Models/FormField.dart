
import 'package:flutter/material.dart';

class TextForm_model extends StatelessWidget {
   TextForm_model({this.hintText, this.onChanged , this.obscureText =false,this.textInputType=TextInputType.text,required this.color}) ;
  Function(String)? onChanged;
  String? hintText;
  bool obscureText;
  TextInputType? textInputType;
  Color color;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data){
        if(data!.isEmpty){return "Field is required!";}
      },
      keyboardType: textInputType,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(

        hintText: hintText,
        hintStyle: TextStyle(color: color),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: color,),),

    ),


    );

  }
}
