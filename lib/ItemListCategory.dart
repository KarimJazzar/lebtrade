import 'package:flutter/material.dart';
import 'package:lebtrade/models/item.dart';
import 'package:lebtrade/oneItemTile.dart';
import 'package:provider/provider.dart';

class ItemListCategory extends StatefulWidget {
  String loggedIn;
  String category;
  ItemListCategory({this.loggedIn,this.category});
  @override
  _ItemListCategoryState createState() => _ItemListCategoryState();
}

class _ItemListCategoryState extends State<ItemListCategory> {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<Item>>(context);
    List<Item> items2 = new List<Item>();
    for(int i = 0; i<items.length; i++){
      if(items[i].cat1.toLowerCase().contains(widget.category.toLowerCase())){
        items2.add(items[i]);
      }
    }
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
                return OneItemTile(item:items2[i],loggedIn: widget.loggedIn,);
              }
        ),
      );


  }
}
