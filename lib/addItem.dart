import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:http/http.dart' as http;
import 'package:lebtrade/itemrecommendation.dart';
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

  String brand="";

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
              placeholder: "Brand",
              backgroundColor: Colors.white24,
              accentColor: Colors.white70,
              autofocus: true,
              textColor: Colors.black,
              onChanged: (text){
                brand = text;
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
              items: ["New", "Used-like new", "Used-good condition", "Used-acceptable condition", "Used"],
              hint: Text("Enter Item Condition"),
              onChanged: (cond){
                var stat=2;
                if (cond=="New"){stat=1;}
                else if (cond=="Used-like new")
                {
                  stat=2;
                }
                else if (cond=="Used-good condition")
                {
                  stat=3;
                }
                else if (cond=="Used-acceptable condition")
                {
                  stat=4;
                }
                else if (cond=="Used")
                {
                  stat=5;
                }
                itemCondition = stat;
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
              items: ["Athletic Apparel", "Makeup", "Computers & Tablets","TV, Audio & Surveillance", "Top & Blouses", "Shoes", "Jewelry", "Tops", "Cell Phones & Accessories"],
              hint: Text("Enter Sub-Category 1"),
              onChanged: (cat){
                sub1 = cat;
              },
            ),
            DropDown(
              items: ["Pants, Tights, Leggings", "Laptops & Netbooks","Headphones","Other", "Face", "T-Shirts", "Shoes", "Games", "Cell Phone Accessories","Lips","Cell Phones & Smartphones"],
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
                  //child: Image.network("https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-12-red-select-2020?wid=940&hei=1112&fmt=png-alpha&qlt=80&.v=1604343703000",height: 220,),
                  radius: 75,
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
                    'brand':brand,
                    'shipping':0,
                    'desc':description
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
            RaisedButton.icon(onPressed: () async {
              await uploadImage(context);
              await DatabaseService(uid: widget.loggedIn.uid).updateItem(name,widget.loggedIn.uid, itemCondition, generalCategory,sub1, sub2, brand, price,description,_url);
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemRecommendation(loggedIn: widget.loggedIn,trade: price,),
                  ));
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


