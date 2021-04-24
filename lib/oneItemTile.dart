import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lebtrade/itemDetails.dart';
import 'package:lebtrade/models/item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class OneItemTile extends StatefulWidget {
  String loggedIn;
  final Item item;
  OneItemTile({this.item,this.loggedIn});

  @override
  _OneItemTileState createState() => _OneItemTileState();
}

class _OneItemTileState extends State<OneItemTile> {
  String estimate = "Estimate Price";
  @override
  Widget build(BuildContext context) {


    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildProductItemCard(context),
      ],
    );
  }

  _buildProductItemCard(BuildContext context) {
    String category = widget.item.cat1 + "/" + widget.item.cat2 + "/" + widget.item.cat3;
    return InkWell(
      onTap: () async{
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemDetails(item: widget.item,loggedIn: widget.loggedIn,),
              ));
      },
      child: Card(
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Image.network(
                widget.item.imageUrl,
              ),
              height: 250.0,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 2.2,
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.item.name,
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
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
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

