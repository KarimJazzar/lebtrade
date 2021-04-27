import 'package:flutter/material.dart';
import 'package:lebtrade/models/item.dart';
import 'package:lebtrade/oneItemTile.dart';
import 'package:provider/provider.dart';

class ItemList extends StatefulWidget {
  String loggedIn;
  String trade;
  ItemList({this.loggedIn,this.trade});
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<Item>>(context);
    List<Item> items2 = new List<Item>();
    for(int i = 0; i<items.length; i++){
      if(items[i].name.toLowerCase().contains(widget.trade.toLowerCase())){
        items2.add(items[i]);
      }
    }
    if(widget.trade == ""){
      return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height),
            ),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context,i){
              if(widget.trade == ""){
                return OneItemTile(item:items[i],loggedIn: widget.loggedIn,);
              }else{
                if(items[i].name.toLowerCase() == widget.trade.toLowerCase()){
                  return OneItemTile(item:items[i],loggedIn: widget.loggedIn,);
                }else{
                  return SizedBox();
                }
              }
            }
        ),
      );
    }else{
      return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height),
            ),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items2.length,
            itemBuilder: (context,i){
              if(widget.trade == ""){
                return OneItemTile(item:items2[i],loggedIn: widget.loggedIn,);
              }else{
                if(items2[i].name.toLowerCase().contains(widget.trade.toLowerCase())){
                  return OneItemTile(item:items2[i],loggedIn: widget.loggedIn,);
                }else{
                  return SizedBox();
                }
              }
            }
        ),
      );
    }

  }
}
