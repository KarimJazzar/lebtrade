import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lebtrade/models/item.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ this.uid });

  final CollectionReference infoCollection = Firestore.instance.collection('User Info');
  final CollectionReference itemCollection = Firestore.instance.collection('Items');

  Future<void> updateUserData(String firstName, String lastName) async {
    return await infoCollection.document(uid).setData({
      'firstName': firstName,
      'lastName': lastName,
    });
  }

  Future<void> updateItem(String name, String userId, int condition, String cat1, String cat2, String cat3, dynamic price, String description, String imageUrl) async {
    return await itemCollection.document(name).setData({
      'userid': userId,
      'condition': condition,
      'cat1': cat1,
      'cat2': cat2,
      'cat3': cat3,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
    });
  }

  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Item(
          name: doc.documentID,
          userid: doc.data['userid'],
          condition: doc.data['condition'],
          cat1: doc.data['cat1'],
          cat2: doc.data['cat2'],
          cat3: doc.data['cat3'],
          price: doc.data['price'],
          description: doc.data['description'],
          imageUrl: doc.data['imageUrl']
      );
    }).toList();
  }

  Stream<QuerySnapshot> get info {
    return infoCollection.snapshots();
  }

  Stream<List<Item>> get items {
    return itemCollection.snapshots().map(_itemListFromSnapshot);
  }
}