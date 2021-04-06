import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lebtrade/models/item.dart';
import 'package:lebtrade/services/database.dart';

class ItemDetails extends StatefulWidget {
  Item item;
  ItemDetails({this.item});

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  String name;
  @override
  Widget build(BuildContext context) {
    DatabaseService().infoCollection.document(widget.item.userid).get().then((value) async{
      setState(() {
        name = value.data["firstName"] + " " + value.data["lastName"];
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
            Text(
              "Price input by user: \$${widget.item.price}",
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
                  "Price estimated by the system: \$${widget.item.price}",
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
        ],
      ),
    );
  }
}
