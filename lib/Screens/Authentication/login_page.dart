//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:i2i_tradehood/Screens/MainScreen/home_page.dart';














/*
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _controllerUserName = TextEditingController();
  TextEditingController _controllerUserPass = TextEditingController();

  String userName = " ";
  String userPass = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                height: 150,
                child:Image(image: AssetImage("Asset/Images/tradehoodlogowhite.png"),)
              ),

              Text("Log into your account!", style: TextStyle(fontSize: 30.0,color: Colors.white),),



              //username input
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Container(
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0,),


                        //user name field

                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            color: Colors.white10,
                          ),

                          child: TextFormField(
                            controller: _controllerUserName,
                            decoration: InputDecoration(labelText: "username",labelStyle: TextStyle(color: Colors.white,),
                              icon: Icon(Icons.person_outline,color: Colors.white,),
                              border: InputBorder.none,),
                            style: TextStyle(color: Colors.blueAccent,),

                            onChanged: (val){
                              setState(() {
                                userName = val;
                              });
                            },
                          ),
                        ),

                        SizedBox(height: 20.0,),


                        // password field
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                              color: Colors.white10
                          ),
                          child: TextFormField(
                            controller: _controllerUserPass,
                            decoration: InputDecoration(labelText: "password",
                              labelStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                              icon: Icon(Icons.lock_outline,color: Colors.white,),
                            ),
                            style: TextStyle(color: Colors.blueAccent,),
                            obscureText: true,
                            onChanged: (val){
                              setState(() {
                                userPass = val;
                              });
                            },

                          ),
                        ),

                        SizedBox(height: 20.0,),

                        //the press button for the form field

                        FlatButton(

                          // function for button pressed
                          onPressed: (){
                            setState(() {
                              print(userName + " " + userPass);
                              if(userName == " " && userPass == " "){
                                Navigator.of(context).push( MaterialPageRoute(
                                    builder: (context) => HomePage()
                                ));
                              }
                            });
                            _controllerUserName.text = " ";
                            _controllerUserPass.text = " ";

                            userName = " ";
                            userPass = " ";
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50.0),),
                              color: Colors.white,
                            ),
                            width: 250,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Sign In", style: TextStyle(fontSize: 20.0, color:Theme.of(context).primaryColor),),
                                SizedBox(width: 20,),
                                Container(
                                    height: 30.0,
                                    width: 30.0,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    ),
                                    child: Icon(Icons.arrow_forward_ios, color: Colors.white,)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              //other login option (facebook and google
              SizedBox(height: 30,),
              Text("OR", style: TextStyle(color: Colors.white,fontSize: 20.0),),
              Divider(color: Colors.white,height: 1.0,),


              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    //facebook login button
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        color: Colors.white,
                      ),
                      child: FlatButton(

                        splashColor: Colors.blueAccent,
                        onPressed: (){},
                        child: Row(
                          children: <Widget>[
                            Text("f", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.blue),),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Facebook", style: TextStyle(color: Colors.blue),)
                          ],
                        ),
                      ),
                    ),


                    //google login button
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        color: Colors.white,
                      ),
                      child: FlatButton(
                        splashColor: Colors.redAccent,
                        onPressed: (){},
                        child: Row(
                          children: <Widget>[
                            Text("G", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Google", style: TextStyle(color: Colors.red),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),



              //sign up  route  here
              Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  children: <Widget>[
                    Text("Don't have an account?" ,  style: TextStyle(color:Colors.white),),
                    SizedBox(width: 20,),
                    Container(
                      height: 30,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        color: Colors.white,
                      ),
                      child: FlatButton(
                        onPressed: (){},
                        child: Text("Register Here!", style: TextStyle(color: Theme.of(context).primaryColor),),
                      ),
                    ),

                  ],
                ),
              )



            ],
          ),
        ),
      ),
    );
  }
}

 */
