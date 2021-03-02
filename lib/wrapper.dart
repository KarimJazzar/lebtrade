import 'package:lebtrade/models/user.dart';
import 'package:flutter/material.dart';
import 'package:lebtrade/services/auth.dart';
import 'package:lebtrade/showItems.dart';
import 'package:provider/provider.dart';
import 'package:lebtrade/sign_in.dart';

class WrapperLogin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    if (user == null){
      return SignIn();
    } else {
        return ShowItemsHome();
    }

  }
}