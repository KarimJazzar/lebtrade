import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lebtrade/models/user.dart';
import 'package:lebtrade/services/database.dart';
import 'package:lebtrade/showItems.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddItem extends StatefulWidget {
  User loggedIn;
  AddItem({this.loggedIn});
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  String estimate = "Estimate Price";

  String name;

  int itemCondition = 0;

  String generalCategory = "";

  String sub1 = "";

  String sub2 = "";

  dynamic price = "Not specified";

  String description = "";

  File _image;
  String _url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(234, 233, 226, 100),
        title: Text("Add Item", style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BeautyTextfield(width: double.maxFinite, height: 44, prefixIcon: Icon(Icons.article_rounded), inputType: TextInputType.text,
            placeholder: "Enter name of Item",
            backgroundColor: Colors.white24,
              accentColor: Colors.white70,
            autofocus: true,
            textColor: Colors.black,
            onChanged: (text){
              name = text;
            },),
            BeautyTextfield(width: double.maxFinite, height: 44, prefixIcon: Icon(Icons.article_rounded), inputType: TextInputType.text,
              placeholder: "Trade For",
              backgroundColor: Colors.white24,
              accentColor: Colors.white70,
              textColor: Colors.black,
              onChanged: (item){
                price = item;
              },),
            DropDown(
              items: [1, 2, 3, 4, 5],
              hint: Text("Enter Item Condition"),
              onChanged: (cond){
                itemCondition = cond;
              },
            ),
            DropDown(
              items: ["Women", "Beauty", "Kids", "Electronics", "Men", "Home", "Vintage & Collectibles", "Other", "Handmade", "Sports & Outdoors"],
              hint: Text("Enter General Category"),
              onChanged: (cat){
                generalCategory = cat;
              },
            ),
            DropDown(
              items: ["Athletic Apparel", "Makeup", "Top & Blouses", "Shoes", "Jewelry", "Tops", "Cell Phones & Accessories"],
              hint: Text("Enter Sub-Category 1"),
              onChanged: (cat){
                sub1 = cat;
              },
            ),
            DropDown(
              items: ["Pants, Tights, Leggings", "Other", "Face", "T-Shirts", "Shoes", "Games", "Lips"],
              hint: Text("Enter Sub-Category 2"),
              onChanged: (cat){
                sub2 = cat;
              },
            ),
            BeautyTextfield(width: double.maxFinite, height: 44, prefixIcon: Icon(Icons.article_rounded), inputType: TextInputType.text,
              placeholder: "Enter description of Item",
              backgroundColor: Colors.white24,
              accentColor: Colors.white70,
              textColor: Colors.black,
              onChanged: (text){
                description = text;
              },),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: _image == null ? null : FileImage(_image),
                  radius: 80,
                  backgroundColor: Colors.black,
                ),
                GestureDetector(onTap: pickImage, child: Icon(Icons.camera_alt))
              ],
            ),
            ButtonTheme(
              minWidth: 10,
              height: 10,
              child: RaisedButton.icon(
                icon: Icon(Icons.analytics_rounded),
                label: Text(estimate),
                color: Colors.white70,
                onPressed: ()async{
                  final response=await http.post('http://10.0.2.2:5000/price',body:json.encode({'name': name,
                    'con':itemCondition,
                    'cat':generalCategory + "/" + sub1 + "/" + sub2,
                    'brand':'',
                    'shipping':0,
                    'desc':description
                  }));
                  final decoded=json.decode(response.body) as Map<String, dynamic>;
                  setState(() {
                    String estimated =decoded['greetings'];
                    estimate = estimated.substring(0,8);
                  });
                },
              ),
            ),
            RaisedButton.icon(onPressed: () async {
              await uploadImage(context);
              await DatabaseService(uid: widget.loggedIn.uid).updateItem(name,widget.loggedIn.uid, itemCondition, generalCategory,sub1, sub2, price,description,_url);
              Navigator.pop(context);

            }, icon: Icon(Icons.transit_enterexit), label: Text("Add Item")),
          ],
        ),
      ),
    );
  }
  void pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future<void> uploadImage(context) async {
    try {
      FirebaseStorage storage =
      FirebaseStorage(storageBucket: 'gs://lebtrade-86cd2.appspot.com');
      StorageReference ref = storage.ref().child(_image.path);
      StorageUploadTask storageUploadTask = ref.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      //Scaffold.of(context).showSnackBar(SnackBar(
      //  content: Text('success'),
     // ));
      //print('url $url');
      setState(() {
        _url = url;
      });
    } catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ));
    }
  }
}

