import 'package:flutter/material.dart';
import 'package:lebtrade/chatscreen.dart';
class PrivatePage extends StatelessWidget {
  String usertomessage="a";
  PrivatePage({
    this.usertomessage});
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(usertomessage),
          backgroundColor: Colors.black,
        ),
        body: ChatScreen()
        //
    );
  }}