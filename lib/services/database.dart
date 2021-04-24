import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lebtrade/models/chatsmessage.dart';
import 'package:lebtrade/models/item.dart';
import 'package:lebtrade/models/message.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ this.uid });

  final CollectionReference infoCollection = Firestore.instance.collection('User Info');
  final CollectionReference itemCollection = Firestore.instance.collection('Items');
  final CollectionReference wishlistCollection = Firestore.instance.collection('Wishlist');
  final CollectionReference chatsCollection = Firestore.instance.collection('Chats');

  Future<void> updateUserData(String firstName, String lastName) async {
    return await infoCollection.document(uid).setData({
      'firstName': firstName,
      'lastName': lastName,
    });
  }

  Future<void> updateItem(String name, String userId, int condition, String cat1, String cat2, String cat3, String brand, String tradefor, String description, String imageUrl) async {
    return await itemCollection.document(name).setData({
      'userid': userId,
      'condition': condition,
      'cat1': cat1,
      'cat2': cat2,
      'cat3': cat3,
      'brand': brand,
      'tradefor': tradefor,
      'description': description,
      'imageUrl': imageUrl,
    });
  }

  Future<void> updateWishlist(String message, String name) async {
    return await wishlistCollection.document(uid).setData({
      'message': message,
      'name': name,
    });
  }

  Future<void> updateChats(String contacts, String message1, String message2) async {
    return await chatsCollection.document(contacts).setData({
      'message1': message1,
      'message2': message2,
    });
  }


  List<Message> _wishListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Message(
          user: doc.documentID,
          message: doc.data['message'],
        name: doc.data['name']
      );
    }).toList();
  }

  List<ChatsMessage> _chatsFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return ChatsMessage(
          contacts: doc.documentID,
          message1: doc.data['message1'],
          message2: doc.data['message2'],
      );
    }).toList();
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
          brand: doc.data['brand'],
          tradefor: doc.data['tradefor'],
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

  Stream<List<Message>> get messages {
    return wishlistCollection.snapshots().map(_wishListFromSnapshot);
  }

  Stream<List<ChatsMessage>> get chatsmessages {
    return chatsCollection.snapshots().map(_chatsFromSnapshot);
  }
}