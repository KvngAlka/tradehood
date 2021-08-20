import 'package:flutter/material.dart';
import 'package:i2i_tradehood/Modules/user.dart';
import 'package:i2i_tradehood/Screens/Authentication/authentication_page.dart';
import 'package:i2i_tradehood/Screens/MainScreen/home_page.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if(user == null){
      return AuthenticationPage();
    }else{
      return HomePage();
    }
   // return AuthenticationPage();
  }
}
