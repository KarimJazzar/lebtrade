import 'package:flutter/material.dart';
import 'package:lebtrade/files/privatepage.dart';

class ChatMessage extends StatelessWidget {
  final String text;


  String username="Anonymous";
  String _name="Anonymous";
// constructor to get text from textfield
  ChatMessage({
    this.text
  ,this.username});
  @override
  Widget build(BuildContext context) {

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child:
              GestureDetector(

                onTap: () {print ('i clicked it');
                print(username);
                Navigator.push(
                  context,
                  //here we specify what user to message
                  MaterialPageRoute(builder: (context)=>PrivatePage(usertomessage: username,senderName: 'hussam younes',),));

                },
                child: CircleAvatar(

                child: Image.network("http://res.cloudinary.com/kennyy/image/upload/v1531317427/avatar_z1rc6f.png"),              ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(username, style: Theme.of(context).textTheme.subhead),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(text),
                )
              ],
            )
          ],
        )
    );
  }
}