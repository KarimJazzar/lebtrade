import 'package:flutter/material.dart';
import 'package:lebtrade/files/privatepage.dart';
import 'package:lebtrade/models/chatsmessage.dart';
import 'package:provider/provider.dart';

class ChatsList extends StatefulWidget {
  String receiver;
  ChatsList({this.receiver});
  @override
  _ChatsListState createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
  @override
  Widget build(BuildContext context) {
    final chatsmessages = Provider.of<List<ChatsMessage>>(context);
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemCount: chatsmessages.length,
              itemBuilder: (context,i){
                if(chatsmessages[i].contacts.contains(widget.receiver,1)){
                  int iend = chatsmessages[i].contacts.indexOf(widget.receiver);
                  return ButtonTheme(
                    buttonColor: Colors.white24,
                    height: 40,
                    child: RaisedButton.icon(onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivatePage(senderName: widget.receiver,usertomessage: chatsmessages[i].contacts.substring(0,iend-1),)
                          ));
                    }, icon: Icon(Icons.description), label: Text(chatsmessages[i].contacts)),
                  );
                }else if(chatsmessages[i].contacts.contains(widget.receiver,0)){
                  return ButtonTheme(
                    height: 40,
                    child: RaisedButton.icon(onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivatePage(senderName: widget.receiver,usertomessage:chatsmessages[i].contacts.substring(widget.receiver.length+1,chatsmessages[i].contacts.length))
                          ));
                    }, icon: Icon(Icons.description), label: Text(chatsmessages[i].contacts)),
                  );
                }
                else{
                  return SizedBox(height: 0,);
                }
              }
          ),
        ),
      ],
    );
  }
}
