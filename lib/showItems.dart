import 'package:flutter/material.dart';
import 'package:lebtrade/itemList.dart';
import 'package:lebtrade/models/item.dart';
import 'package:lebtrade/services/auth.dart';
import 'package:lebtrade/services/database.dart';
import 'package:provider/provider.dart';

class ShowItemsHome extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Item>>.value(
      value: DatabaseService().items,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(234, 233, 226, 100),
          title: Text("Browse Items", style: TextStyle(color: Colors.black),),
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
              Container(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    FlatButton.icon(onPressed: null, icon: Icon(Icons.adb_rounded), label: Text("Electronics")),
                    FlatButton.icon(onPressed: null, icon: Icon(Icons.accessibility), label: Text("Vehicles")),
                    FlatButton.icon(onPressed: null, icon: Icon(Icons.airport_shuttle), label: Text("Fashion")),
                    FlatButton.icon(onPressed: null, icon: Icon(Icons.android), label: Text("Home & Games"))
                  ],
                ),
              ),
              Container(height: 1000,child: ItemList()),
            ],
          ),
        ),
      ),
    );

  }
}
