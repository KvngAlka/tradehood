
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i2i_tradehood/Screens/Authentication/sign_in_page.dart';
import 'package:i2i_tradehood/Screens/Authentication/sign_up.dart';


class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {

     if (showSignIn) {
      return SignIn(toggleView: toggleView);
    }else {
      return SignUp(toggleView: toggleView);
    }

  }
}


// if(showSignIn) {
//  return SignIn(toggleView: toggleView);
// }else{
//  return SignUp(toggleView: toggleView);
// }