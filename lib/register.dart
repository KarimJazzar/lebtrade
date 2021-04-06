import 'package:lebtrade/services/auth.dart';
import 'package:lebtrade/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String first = '';
  String last = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      //backgroundColor: Colors.brown[100],
      appBar: AppBar(
        //backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to LebTrade',style: TextStyle(color: Colors.black),),
        centerTitle: true,

        actions: <Widget>[
//          FlatButton.icon(
//            icon: Icon(Icons.person),
//            label: Text('Sign In'),
//            onPressed: () => widget.toggleView(),
//          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
//                decoration: textInputDecoration.copyWith(hintText: 'email'),
                  decoration: new InputDecoration(
                    hintText: 'First Name',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 2,color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 2,color: Colors.blue),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 2,color: Colors.red)
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 2,color: Colors.red)
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter a first name' : null,
                  onChanged: (val) {
                    setState(() => first = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
//                decoration: textInputDecoration.copyWith(hintText: 'email'),
                  decoration: new InputDecoration(
                    hintText: 'Last Name',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 2,color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 2,color: Colors.blue),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 2,color: Colors.red)
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 2,color: Colors.red)
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter a last name' : null,
                  onChanged: (val) {
                    setState(() => last = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
//                decoration: textInputDecoration.copyWith(hintText: 'email'),
                  decoration: new InputDecoration(
                    hintText: 'Email',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 2,color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 2,color: Colors.blue),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 2,color: Colors.red)
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 2,color: Colors.red)
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: new InputDecoration(
                    hintText: 'Password',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 2,color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 2,color: Colors.blue),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 2,color: Colors.red)
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 2,color: Colors.red)
                    ),
                  ),
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password, first, last);
                      if(result == null) {
                        setState(() {
                          loading = false;
                          error = 'Please supply a valid email';
                        });
                      }
                    }
                  }
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}