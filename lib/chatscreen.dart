import 'package:flutter/material.dart';
import 'package:lebtrade/chatmessage.dart';
import 'package:lebtrade/models/message.dart';
import 'package:lebtrade/services/database.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  String usrid;
  ChatScreen({this.usrid});
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  String name;

  final TextEditingController _chatController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

      void _handleSubmit(String text) async{
    /*_chatController.clear();

    //here we wrap inside loop and add dynamically from wishlist table
    ChatMessage message = ChatMessage(
        text: text,username: name
    );

    setState(() {
      _messages.insert(0, message);
    });
    */
        await DatabaseService(uid: widget.usrid).updateWishlist(text,name);
    
  }
  Widget _chatEnvironment (){
    return IconTheme(
      data: IconThemeData(color: Colors.blue),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal:8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                decoration: InputDecoration.collapsed(hintText: "Starts typing ..."),
                controller: _chatController,
                onSubmitted: _handleSubmit,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: ()=> _handleSubmit(_chatController.text),
              ),
            )
          ],),),);}
  @override

  Widget build(BuildContext context) {
    DatabaseService().infoCollection.document(widget.usrid).get().then((value) async{
      setState(() {
        name = value.data["firstName"] + " " + value.data["lastName"];
      });
    });

    final wishlistmessages = Provider.of<List<Message>>(context);
    return Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                //itemBuilder: (_, int index) => _messages[index],
                itemCount: wishlistmessages.length,
                  itemBuilder: (context,i){
                    return ChatMessage(username: wishlistmessages[i].name,text: wishlistmessages[i].message,);
                  }
              ),
            ),
            new Divider(
              height: 1.0,
            ),
            new Container(decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
              child: _chatEnvironment(),
            )
          ],)
    ;}}