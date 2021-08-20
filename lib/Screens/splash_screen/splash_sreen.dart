import 'dart:async';
import 'package:flutter/material.dart';
import 'package:i2i_tradehood/Screens/MainScreen/Home/wrapper.dart';
import 'package:i2i_tradehood/Screens/splash_screen/color_loader_2.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    
    super.initState();

    startTime();
  }

  startTime() async{
    var duration = Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Wrapper(),
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.blue,
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("WELCOME TO",style: TextStyle(fontSize: 20.0, color: Colors.white),),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 200,
                    child: Image(image: AssetImage("Asset/Images/tradehoodlogowhite.png", ),)),
                SizedBox(
                  height: 30.0,
                ),
                ColorLoader2(color1: Colors.white, color2: Colors.white, color3: Colors.white,)

              ],
            ),

      ),
    );
  }
}
