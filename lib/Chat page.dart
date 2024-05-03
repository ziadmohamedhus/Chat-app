
import 'package:chat_app/Models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'Models/Massage_puilder.dart';

class Chat_page extends StatefulWidget {
   Chat_page(this.email) ;
   final String email;

  @override
  State<Chat_page> createState() => _Chat_pageState();
}

class _Chat_pageState extends State<Chat_page> {


  /////////START IN FIREBASE==============================================>>>>>>>>>>>>>>>>>>>>
  CollectionReference messages = FirebaseFirestore.instance.collection('message');
  
  TextEditingController controller=TextEditingController();
  final controller_scroll=ScrollController();


  @override
  Widget build(BuildContext context) {
    //QuerySnapshot == مجموعة ال  documents في الفايربيز
    
    return  StreamBuilder<QuerySnapshot>(
          stream: messages.orderBy('time',descending: true).snapshots(),

          builder: (context,snapshot)
          {
            List<message_model> message_list=[];
            for(int i=0;i<snapshot.data!.docs.length;i++)
            {
              message_list.add(message_model.fromJson(snapshot.data!.docs[i]));
            }
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            if(snapshot.hasData)
              {

                //snapshot.data   has all documents in the firebase and you can access it as a list of map !!!!!!!!!!!!!!!!!!!!!!!!!!!!
                print(snapshot.data!.docs[0]["message"]);

                return  Scaffold(
                  appBar: AppBar(),
                  body: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                            reverse: true,
                            controller: controller_scroll,
                              itemCount: message_list.length,
                              itemBuilder: (context,index){return message_list[index].id==widget.email ? Massage_buble(message: message_list[index],):Massage_buble_friend(message: message_list[index],);}
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          ///////////////FIREBASE=======================================================================>>>>>>>>>>>>>>>>>>>>>.
                          onFieldSubmitted: (data)
                          {
                            messages.add({
                              "message":data,
                              "time":DateTime.now(),
                              //to access var from the super class in stateful
                              "id":widget.email
                            })
                                .then((value) => print("User Added"))
                                .catchError((error) => print("Failed to add user: $error"));
                            controller.clear();
                            controller_scroll.animateTo(0, duration: Duration(milliseconds: 10), curve: Curves.linear);

                          },
                          controller:controller ,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                            suffixIcon: Icon(Icons.send),
                            hintText: "Send massage ",
                          ),

                        ),
                      )

                    ],
                  ),
                );
              }

            return Text('data');





          }
      );
  }
}
