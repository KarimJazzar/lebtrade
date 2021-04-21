import 'package:flutter/material.dart';
import 'package:lebtrade/chatscreen.dart';
import 'package:lebtrade/models/message.dart';
import 'package:lebtrade/services/database.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  String usrid;
  HomePage({this.usrid});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Message>>.value(
        value: DatabaseService().messages,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(234, 233, 226, 100),
            title: Text("Wish List", style: TextStyle(color: Colors.black),),
            centerTitle: true,
          ),
          body: ChatScreen(usrid: widget.usrid,)

      ),
    );
  }}