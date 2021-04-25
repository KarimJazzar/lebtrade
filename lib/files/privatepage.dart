import 'package:flutter/material.dart';
import 'package:lebtrade/files/chatscreen.dart';
import 'package:lebtrade/models/chatsmessage.dart';
import 'package:lebtrade/services/database.dart';
import 'package:provider/provider.dart';

class PrivatePage extends StatelessWidget {
  //String sender;
  String usertomessage;
  String senderName;
  PrivatePage({this.usertomessage,this.senderName});
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ChatsMessage>>.value(
      value: DatabaseService().chatsmessages,
      child: Scaffold(
          appBar: AppBar(
            title: Text(usertomessage,style: TextStyle(color: Colors.black),),
            centerTitle: true,
            backgroundColor: Color.fromRGBO(234, 233, 226, 100),
          ),
          body: ChatScreen(usertomessage: usertomessage,senderName: senderName,)
          //
      ),
    );
  }}