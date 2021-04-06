import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Predict extends StatefulWidget {
  @override
  _PredictState createState() => _PredictState();
}

class _PredictState extends State<Predict> {
  String name = "";

  int itemCondition = 0;

  String generalCategory = "";

  String sub1 = "";

  String sub2 = "";

  String flaskTest = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Predict Price of Item"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BeautyTextfield(width: double.maxFinite, height: 50, prefixIcon: Icon(Icons.article_rounded), inputType: TextInputType.text,
          placeholder: "Enter name of Item",
          backgroundColor: Colors.white70,
          textColor: Colors.black,
          onChanged: (text){
            name = text;
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
          RaisedButton.icon(onPressed: () async {
            final response = await http.get("http://10.0.2.2:5000/price");
            print(flaskTest);
            final decoded = json.decode(response.body) as Map<String, dynamic>;
            setState(() {
              flaskTest = decoded["greetings"];
            });
            //print(sub2)
          }, icon: Icon(Icons.transit_enterexit), label: Text("Enter")),
          Text(flaskTest)
        ],
      ),
    );
  }
}
