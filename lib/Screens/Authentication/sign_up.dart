import 'package:flutter/material.dart';
import 'package:i2i_tradehood/Screens/splash_screen/color_loader_2.dart';
import 'package:i2i_tradehood/Services/auth.dart';

class SignUp extends StatefulWidget {

  final Function toggleView;
  SignUp({this.toggleView});


  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String userName = "";
  String email = "";
  String password = "";
  String phoneNmber = "";
  String country = "";
  String error = "";


  @override
  Widget build(BuildContext context) {
    return   loading ?  Scaffold(
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
        body: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [Column(
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Container(
                      width: 300,
                      height: 100,
                      child: Image(image: AssetImage("Asset/Images/tradehood.png"),),
                    ),
                  ),

                  Text("Sign Up Here!", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 30),),
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
                            validator:(val) => val.isEmpty ? 'Enter an user name' : null,
                            onChanged: (val){
                              setState(() {
                                userName = val;
                              });
                            },
                            decoration: InputDecoration(
                              icon: Icon(Icons.person),
                              hintText: ("User Name"),
                              hintStyle: TextStyle(color: Colors.blueGrey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Divider(),

                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 2.0),
                          child: TextFormField(
                            validator:(val) => val.isEmpty ? 'Enter an email' : null,
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
                            validator:(val) => val.length < 6 ? 'Your password should have 6+ characters' : null,
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
                        Divider(),


                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 2.0),
                          child: TextFormField(
                            validator:(val) => val.isEmpty ? 'Enter a phone number' : null,
                            onChanged: (val){
                              setState(() {
                                phoneNmber = val;
                              });
                            },
                            decoration: InputDecoration(
                              icon: Icon(Icons.phone),
                              hintText: ("Phone Number"),
                              hintStyle: TextStyle(color: Colors.blueGrey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Divider(),

                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 2.0),
                          child: TextFormField(
                            validator:(val) => val.isEmpty ? 'Enter a country' : null,
                            onChanged: (val){
                              setState(() {
                                country = val;
                              });
                            },
                            decoration: InputDecoration(
                              icon: Icon(Icons.my_location),
                              hintText: ("Country"),
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
                    child: Text("Sign Up", style: TextStyle(color: Colors.white),),
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.signUpWithEmailAndPassword(email, password, userName, phoneNmber, country);
                        if(result == null){
                          setState(() {
                            error = 'Please Supply a valid email account';
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
                      Text("Already  have an account?"),

                      FlatButton(
                        onPressed: () {
                          widget.toggleView();
                          print("tap");

                        },
                        child: Text("Sign In", style: TextStyle(fontSize: 20.0, color: Theme.of(context).primaryColor),),
                      )
                    ],
                  ),
                ]
              ),]
            )
          ),
        ),
      ),
    );

  }
}
