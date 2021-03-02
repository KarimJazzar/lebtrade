import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lebtrade/models/item.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  ItemTile({this.item});

  @override
  Widget build(BuildContext context) {
    return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: [
      GridTile(
        header: Text("${item.price}\$", textAlign: TextAlign.center,),
          child: Image(
            image: AssetImage("assets/ps4.png"),
            width: 50,
            height: 50,
          ),
      footer: Text("${item.name}",textAlign: TextAlign.center,),),
      ],);
  }
}
