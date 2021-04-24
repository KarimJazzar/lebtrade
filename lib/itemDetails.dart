import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lebtrade/models/item.dart';
import 'package:lebtrade/files/privatepage.dart';
import 'package:lebtrade/services/database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ItemDetails extends StatefulWidget {
  String loggedIn;
  Item item;
  ItemDetails({this.item,this.loggedIn});

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  String name;
  String loggedInName;
  String estimate = "Estimate Price";
  @override
  Widget build(BuildContext context) {
    String category = widget.item.cat1 + "/" + widget.item.cat2 + "/" + widget.item.cat3;

    DatabaseService().infoCollection.document(widget.item.userid).get().then((value) async{
      setState(() {
        name = value.data["firstName"] + " " + value.data["lastName"];
      });
    });

    DatabaseService().infoCollection.document(widget.loggedIn).get().then((value) async{
      setState(() {
        loggedInName = value.data["firstName"] + " " + value.data["lastName"];
      });
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(234, 233, 226, 100),
        title: Text("Item Details", style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            height: 250,
            child: Center(
              child: Image.network(widget.item.imageUrl),
            ),
          ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Center(
          child: Text(
            //name,
            "Name: " + widget.item.name,
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
        ),
      ),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 10,
                  height: 10,
                  child: RaisedButton.icon(
                    icon: Icon(Icons.analytics_rounded),
                    label: Text(estimate),
                    color: Colors.white70,
                    onPressed: ()async{
                      final response=await http.post('http://10.0.2.2:5000/price',body:json.encode({'name': widget.item.name,
                        'con':widget.item.condition,
                        'cat':category,
                        'brand':widget.item.brand,
                        'shipping':0,
                        'desc':widget.item.description
                      }));
                      final decoded=json.decode(response.body) as Map<String, dynamic>;
                      setState(() {
                        String estimated =decoded['greetings'];
                        estimate=estimated+"\$";
                        //estimate = estimated.substring(0,8);
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "Item owner's name: $name",
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                SizedBox(
                  width: 8.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "Trade For: ${widget.item.tradefor}",
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                SizedBox(
                  width: 8.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "Item Condition: ${widget.item.condition}",
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                SizedBox(
                  width: 8.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
              ],
            ),
          ),
      Column(
        children: <Widget>[
        Container(
      color: Colors.grey[600],
      width: MediaQuery.of(context).size.width,
      height: 0.25,
      ),
      ],
      ),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "Item category 1: ${widget.item.cat1}",
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                SizedBox(
                  width: 8.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "Item category 2: ${widget.item.cat2}",
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                SizedBox(
                  width: 8.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "Item category 3: ${widget.item.cat3}",
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                SizedBox(
                  width: 8.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
              ],
            ),
          ),
          SizedBox(height: 8,),
          Column(
            children: <Widget>[
              Container(
                color: Colors.grey[600],
                width: MediaQuery.of(context).size.width,
                height: 0.25,
              ),
            ],
          ),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "Item Description: ${widget.item.description}",
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                SizedBox(
                  width: 8.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
              ],
            ),
          ),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 10,
                  height: 10,
                  child: RaisedButton.icon(
                    icon: Icon(Icons.message),
                    label: Text("Chat with Owner"),
                    color: Colors.white70,
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivatePage(usertomessage: name,senderName: loggedInName,)
                          ));
                    },
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
