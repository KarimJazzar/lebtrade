import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromRGBO(234, 233, 226, 100),
        title: Text("Select an option", style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Container(
        width: 800,
        color: Color.fromRGBO(234, 233, 226, 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text("Do you want to login or register?",
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            SizedBox(height: 25,),
            Container(
              child: OutlineButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Login');
                },
                child: Text("                 Login                 ",style: TextStyle(fontSize: 22),),
                borderSide: BorderSide(color: Colors.blue),
                shape: StadiumBorder(),
              ),
            ),
            SizedBox(height: 10,),
            OutlineButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Register');
              },
              child: Text("               Register               ",style: TextStyle(fontSize: 22),),
              borderSide: BorderSide(color: Colors.blue),
              shape: StadiumBorder(),
            ),
          ],
        ),
      ),
    );
  }
}
