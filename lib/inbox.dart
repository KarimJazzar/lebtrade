import 'package:flutter/material.dart';
import 'package:lebtrade/chatsList.dart';
import 'package:lebtrade/models/chatsmessage.dart';
import 'package:lebtrade/services/database.dart';
import 'package:provider/provider.dart';

class Inbox extends StatefulWidget {
  String receiver;
  Inbox({this.receiver});
  @override
  _State createState() => _State();
}

class _State extends State<Inbox> {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ChatsMessage>>.value(
      value: DatabaseService().chatsmessages,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Inbox",style: TextStyle(color: Colors.black)),
            centerTitle: true,
            backgroundColor: Color.fromRGBO(234, 233, 226, 100),
          ),
          body: ChatsList(receiver: widget.receiver,)
      ),
    );
  }
}
