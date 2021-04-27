import 'package:flutter/material.dart';
import 'package:lebtrade/ItemListCategory.dart';
import 'package:lebtrade/addItem.dart';
import 'package:lebtrade/chatscreen.dart';
import 'package:lebtrade/homepage.dart';
import 'package:lebtrade/inbox.dart';
import 'package:lebtrade/itemList.dart';
import 'package:lebtrade/models/item.dart';
import 'package:lebtrade/models/user.dart';
import 'package:lebtrade/services/auth.dart';
import 'package:lebtrade/services/database.dart';
import 'package:provider/provider.dart';

class ShowItemsCategory extends StatefulWidget {
  User loggedIn;
  String category;
  ShowItemsCategory({this.loggedIn,this.category});
  @override
  _ShowItemsCategoryState createState() => _ShowItemsCategoryState();
}

class _ShowItemsCategoryState extends State<ShowItemsCategory> {
  final AuthService _auth = AuthService();
  String name;

  @override
  Widget build(BuildContext context) {
    DatabaseService().infoCollection.document(widget.loggedIn.uid).get().then((value) async{
      setState(() {
        name = value.data["firstName"] + " " + value.data["lastName"];
      });
    });

    return StreamProvider<List<Item>>.value(
      value: DatabaseService().items,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(234, 233, 226, 100),
          title: Text(widget.category, style: TextStyle(color: Colors.black),),
          centerTitle: true,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton.icon(onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddItem(loggedIn: widget.loggedIn,),
                        ));
                  }, icon: Icon(Icons.transit_enterexit), label: Text("Add an Item")),
                  SizedBox(width: 10,),
                  RaisedButton.icon(onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(usrid: widget.loggedIn.uid,),
                        ));
                  }, icon: Icon(Icons.library_books_sharp), label: Text("Wish List")),
                  SizedBox(width: 10,),
                  RaisedButton.icon(onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Inbox(receiver: name,),
                        ));
                  }, icon: Icon(Icons.inbox), label: Text("Inbox")),
                ],
              ),
              Text("Logged in as $name",textAlign: TextAlign.end,style: TextStyle(fontSize: 14),),
              SizedBox(height: 15,),
              Container(child: ItemListCategory(loggedIn: widget.loggedIn.uid,category: widget.category,)),
            ],
          ),
        ),
      ),
    );

  }
}
