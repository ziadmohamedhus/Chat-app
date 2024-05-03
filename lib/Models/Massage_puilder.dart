import 'package:chat_app/Models/message_model.dart';
import 'package:flutter/material.dart';


class Massage_buble extends StatelessWidget {
   Massage_buble({
    Key? key,
    required this.message,
  }) : super(key: key);

  final message_model message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: Color(0xff2B475E),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              //message.message,
              message.id,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12
              ),
            ),

                Text(
                  message.message,
                  //message.message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17
                  ),
                ),


          ],
        ),
      ),
    );
  }
}

class Massage_buble_friend extends StatelessWidget {
  const Massage_buble_friend({
    Key? key,
    required this.message,
  }) : super(key: key);

  final message_model message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Color(0xff006D84),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              //message.message,
              message.id,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15
              ),
            ),

                Text(
                  //message.message,
                  message.message,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),


          ],
        ),
      ),
    );
  }
}
