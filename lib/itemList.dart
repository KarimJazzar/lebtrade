import 'package:flutter/material.dart';
import 'package:lebtrade/models/item.dart';
import 'package:lebtrade/oneItemTile.dart';
import 'package:provider/provider.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<Item>>(context);
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
              return OneItemTile(item:items[i]);
          }
      ),
    );
  }
}
