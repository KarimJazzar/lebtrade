import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lebtrade/models/item.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ this.uid });

  final CollectionReference itemCollection = Firestore.instance.collection('Items');

  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Item(
          name: doc.documentID,
          uid: doc.data['uid'],
          type: doc.data['type'],
          image: doc.data['image'],
          price: doc.data['price']
      );
    }).toList();
  }

  Stream<List<Item>> get items {
    return itemCollection.snapshots().map(_itemListFromSnapshot);
  }
}