import 'package:flutter/material.dart';
import 'package:lebtrade/loginOrRegister.dart';
import 'package:lebtrade/models/user.dart';
import 'package:lebtrade/loading.dart';
import 'package:lebtrade/predict.dart';
import 'package:lebtrade/sign_in.dart';
import 'package:lebtrade/register.dart';
import 'package:lebtrade/services/auth.dart';
import 'package:lebtrade/wrapper.dart';
import 'package:lebtrade/wrapperRegister.dart';
import 'package:provider/provider.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        navigatorKey: key,
        routes: {
          '/loading': (context) => Loading(),
          '/Login': (context) => WrapperLogin(),
          '/Register': (context) => WrapperRegister(),
        },
        home: LoginRegister(),
      ),
    );
  }
}