import 'package:flutter/material.dart';


class ProfileTopHeader extends StatefulWidget {
  final name;
  ProfileTopHeader({this.name});
  @override
  _ProfileTopHeaderState createState() => _ProfileTopHeaderState();
}

class _ProfileTopHeaderState extends State<ProfileTopHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.black,
                    child: Text('A', style: TextStyle(color: Colors.white),)),
              ),
              Text(widget.name, style: TextStyle(fontSize: 20,),)
              
            ],
          ),


          Container(child: Text("This is Alka, A very cool guy who doesn't like talking too much",
            style: TextStyle( color: Colors.blueGrey, fontSize: 15, fontWeight: FontWeight.bold),)
          ),

          Padding(padding: EdgeInsets.all(8.0),
            child: Row(children: <Widget>[
              Expanded(child: Container(height: 30,
              color: Colors.white,
                child: FlatButton(child: Text('Following'),onPressed: (){},)),
              ),


              SizedBox(width: 10,),

              Expanded(child: Container(height: 30,
              color: Colors.white,
                child: FlatButton(child: Text('Message'),onPressed: (){},)),
              ),
              
            ],),
          )


        ],
      ),
    );
  }
}