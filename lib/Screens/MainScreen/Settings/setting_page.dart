
import 'package:flutter/material.dart';
import 'package:i2i_tradehood/Modules/user.dart';
import 'package:i2i_tradehood/Screens/splash_screen/color_loader_2.dart';
import 'package:i2i_tradehood/Services/database_service.dart';
import 'package:provider/provider.dart';



class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final _formKey = GlobalKey<FormState>();

  //form values
  String _currentName;
  String _currentCountry;
  int _currentPhoneNumber;
  //String _photoUrl;


  @override
  Widget build(BuildContext context) {

    
    final user = Provider.of<User>(context);


    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot){

        if (snapshot.hasData){
          UserData userData = snapshot.data;

          return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Settings", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
                  child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    elevation: 1.0,
                    child: TextFormField(
                      initialValue: userData.userName,
                      validator: (val) => val.isEmpty ? 'Please enter a a user name' : null,
                      onChanged: (val) => setState(() => _currentName),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "User Name"
                      ),
                    ),
                  ),
                ),

                 Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    elevation: 1.0,
                    child: TextFormField(
                      initialValue: userData.phoneNumber.toString(),
                      validator: (val) => val.isEmpty ? 'Please enter a phone number' : null,
                      onChanged: (val) => setState(() => _currentPhoneNumber),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone Number",
                      ),
                     
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    elevation: 1.0,
                    child: TextFormField(
                      initialValue: userData.country,
                      validator: (val) => val.isEmpty ? 'Please enter a country' : null,
                      onChanged: (val) => setState(() => _currentCountry),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Country",
                      ),
                    ),
                  ),
                ),

                SizedBox( height: 20.0,),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text("Update", style: TextStyle(color: Colors.white),),
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentName ?? userData.userName, 
                          _currentCountry ?? userData.country, 
                          _currentPhoneNumber ?? userData.phoneNumber,
                          //profile picture not implemented yet
                          '');
                      }
                      Navigator.pop(context);
                    },
                  ),





              ],
            ),
          ) ,
          )
      );

        }else{
          return Scaffold(
            body: Center(
              child: ColorLoader2(
                color1: Theme.of(context).primaryColor,
                color2: Theme.of(context).primaryColor,
                color3: Theme.of(context).primaryColor,
              ),
            ),
          );
        }
        

      },
           
    );
  }
}
