import 'package:flutter/material.dart';
import 'package:lebtrade/files/chatmessage.dart';
import 'package:lebtrade/models/chatsmessage.dart';
import 'package:lebtrade/models/message.dart';
import 'package:lebtrade/services/database.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  String sender;
  String senderName;
  String usertomessage;
  ChatScreen({this.usertomessage,this.senderName});
  @override
  State createState() => new ChatScreenState();
}
class ChatScreenState extends State<ChatScreen> {
  //String nameSender;

  final TextEditingController _chatController = new TextEditingController();

 //List<ChatMessage> _messages = <ChatMessage>[ChatMessage(
     // text: 'hi ',username: '(sender name)'
  //)  ];


  void _handleSubmit(String text) async {
    _chatController.clear();

    /*DatabaseService().infoCollection.document(widget.sender).get().then((
        value) async {
      setState(() {
        nameSender = value.data["firstName"] + " " + value.data["lastName"];
      });
    });
    */
    final chatmsgs = Provider.of<List<ChatsMessage>>(context, listen: false);
    for(int i =0; i<chatmsgs.length;i++){
      print(chatmsgs[i].contacts);
      if(chatmsgs[i].contacts.contains(widget.senderName,0) && chatmsgs[i].contacts.contains(widget.usertomessage,2)){
        await DatabaseService().updateChats(widget.senderName + " " + widget.usertomessage, text, chatmsgs[i].message2);
        break;
      }else if(chatmsgs[i].contacts.contains(widget.senderName,2) && chatmsgs[i].contacts.contains(widget.usertomessage,0)) {
        await DatabaseService().updateChats(
            widget.usertomessage + " " + widget.senderName,
            chatmsgs[i].message1, text);
        break;
      }else{
        await DatabaseService().updateChats(widget.senderName + " " + widget.usertomessage, text, "");
      }
    }

  }
/*
    ChatMessage message = new ChatMessage(
        text: text,username: 'You'
    );

    setState(() {
      _messages.insert(0, message);
    });

    
  }
*/
  Widget _chatEnvironment (){

    return IconTheme(
      data: IconThemeData(color: Colors.blue),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal:8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                decoration: InputDecoration.collapsed(hintText: "Start typing ..."),
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
    final chatsmessages = Provider.of<List<ChatsMessage>>(context);
    return Column(
      children: <Widget>[
        Flexible(
          child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            reverse: true,
            //itemBuilder: (_, int index) => _messages[index],
            //itemCount: _messages.length,
              itemCount: chatsmessages.length,
              itemBuilder: (context,i){
              //print(chatsmessages[i].contacts.contains(widget.senderName,0));
          if (widget.senderName == widget.usertomessage){
             return SizedBox(width: 0,);
           }else if(chatsmessages[i].contacts.contains(widget.senderName,0) && chatsmessages[i].contacts.contains(widget.usertomessage,1)){
                return Column(children: [ChatMessage(username: widget.senderName,text: chatsmessages[i].message1,),ChatMessage(username: widget.usertomessage,text: chatsmessages[i].message2,)]);
              } else if(chatsmessages[i].contacts.contains(widget.senderName,1) && chatsmessages[i].contacts.contains(widget.usertomessage,0)){
            return Column(children: [ChatMessage(username: widget.usertomessage,text: chatsmessages[i].message1,),ChatMessage(username: widget.senderName,text: chatsmessages[i].message2,)]);
              }else{
            return SizedBox(height:0);
                }
              }
          ),
        ),
        Divider(
          height: 1.0,
        ),
        Container(decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
        ),
          child: _chatEnvironment(),
        )
      ],);}}