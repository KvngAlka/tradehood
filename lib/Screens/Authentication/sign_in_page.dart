import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:i2i_tradehood/Screens/MainScreen/home_page.dart';
import 'package:i2i_tradehood/Screens/splash_screen/color_loader_2.dart';
import 'package:i2i_tradehood/Services/auth.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = "";
  String password = "";
  String error = "";


  @override
  Widget build(BuildContext context) {

    return loading ? Scaffold(
                body: Center(
                child: ColorLoader2(
                  color1: Theme.of(context).primaryColor,
                  color2: Theme.of(context).primaryColor,
                  color3: Theme.of(context).primaryColor,
                ),
              ),
    )
        :
    SafeArea(
      child: Scaffold(
        body: Stack(
          children:<Widget>[
            Center(
              child: Form(
                key: _formKey,
                child: ListView(
                    children: [Column(
                      children: <Widget>[
                        
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: SizedBox(
                            width: 300,
                            height: 150,
                          ),
                        ),

                        SizedBox(height: 10,),
                        Text("Log In Here!", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
    
    
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .2),
                                blurRadius: 20.0,
                                offset: Offset(0,10)
                              )
                            ]
                          ),
                          width: 300,
    
                          child: Column(
                            children: <Widget>[
                              SizedBox( height: 20.0,),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 2.0),
                                child: TextFormField(
                                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                                  onChanged: (val){
                                    setState(() {
                                      email = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.email),
                                    hintText: ("Email"),
                                    hintStyle: TextStyle(color: Colors.blueGrey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Divider(),

  
                            SizedBox( height: 20.0,),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 2.0),
                              child: TextFormField(
                                validator:  (val) => val.length < 6 ? 'Your password should have 6+ characters' : null,
                                obscureText: true,
                                onChanged: (val){
                                  setState(() {
                                    password = val;
                                  });
                                },
                                decoration: InputDecoration(
                                  icon: Icon(Icons.lock),
                                  hintText: ("Password"),
                                  hintStyle: TextStyle(color: Colors.blueGrey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

    
                        SizedBox( height: 20.0,),
                        RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text("Signin", style: TextStyle(color: Colors.white),),
                          onPressed: () async{
                            if(_formKey.currentState.validate()){
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                              if(result == null){
                                setState(() {
                                  error = 'Could not Sign In';
                                  loading = false;
                                });
                              }
                            }
                          },
                        ),

                        SizedBox( height: 10.0,),
                        Text(error, style: TextStyle(color: Colors.red),),
    
                        SizedBox( height: 10.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Don't have an account?"),
    
                            FlatButton(
                              onPressed: () {
                                  widget.toggleView();
                                  print("tap");
    
                              },
                              child: Text("Sign Up", style: TextStyle(fontSize: 20.0, color: Theme.of(context).primaryColor),),
                            )
                      ],
                    ),


    
                        RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text("Sign Up here", style: TextStyle(color: Colors.white),),
                          onPressed: () {
                            Navigator.of(context).push( MaterialPageRoute(
                                builder: (context) => HomePage()));
                        },
                      ),
                    ],
                  ),]
                ),

              ),
            ),


            Positioned(
                top: 0.0,
                child: Image.asset("Asset/Images/tradehoodLogin1.png",fit: BoxFit.fitWidth,
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                )),

        ]),
      ),
    );
  }
}
