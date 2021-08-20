import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i2i_tradehood/Modules/message_module.dart';
import 'package:i2i_tradehood/Modules/user.dart';
import 'package:i2i_tradehood/Screens/MainScreen/Message/send_message_field.dart';
import 'package:i2i_tradehood/Screens/splash_screen/color_loader_2.dart';
import 'package:i2i_tradehood/Services/auth.dart';

class Chat extends StatefulWidget {
  final receiver;
  Chat({ this.receiver});
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController _textEditingController = TextEditingController();
   AuthService _authService = AuthService();

  String _currentUserId;

  UserData sender;



  @override
void initState(){

  super.initState();
  _authService.getCurrentUser().then((user){
      _currentUserId = user.uid;

      setState(() {
        sender = UserData(
          uid:  user.uid,
          userName: user.displayName,
          photoUrl: user.photoUrl,
        );
      });
    });

}
  
   
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: (){ 
              Navigator.pop(context); 
            },
            icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor,),
          ),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 5.0,
              backgroundColor: Colors.green,
            ),

            //we paste the username of the receiver here
            Text(widget.receiver, style: TextStyle(color:Theme.of(context).primaryColor, fontFamily: "arial",fontSize: 20),),
          ],
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Theme.of(context).primaryColor,
              child: IconButton(
                onPressed: (){},
                icon: Icon(Icons.video_call,  color: Colors.white,size: 15.0,),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Theme.of(context).primaryColor,
              child: IconButton(
                onPressed: (){},
                icon: Icon(Icons.call, color: Colors.white,size: 15.0,),
              ),
            ),
          ),
        ],
        elevation: 0.0,
      ),


      body: Column(
        children: <Widget>[
          Flexible(
            child: messageList(),
          ),

          

          //sender text field input

          SendField(textEditingController:_textEditingController ,receiver: widget.receiver, sender: sender,)
        ],
      ),
    );
  }


Widget messageList(){
  return StreamBuilder(
    stream: Firestore.instance.collection('messages').document(_currentUserId)
    .collection(widget.receiver.uid).orderBy('timestamp', descending: true).snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){


      if(snapshot.hasData == null){
        return Center(
          child: ColorLoader2(
            color1: Theme.of(context).primaryColor,
            color2: Theme.of(context).primaryColor,
            color3: Theme.of(context).primaryColor,
          ),
        );
      }else{


        return  ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index){
            return chatMessageItem(snapshot.data.documents[index]);
          },
          
        );
      }
    },
  );
}


Widget chatMessageItem(DocumentSnapshot snapshot){
  Message _message = Message.fromMap(snapshot.data);

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    child: Container( 
      alignment: _message.senderId == _currentUserId 
              ? Alignment.centerRight
              :Alignment.centerLeft,

      child: _message.senderId == _currentUserId 
            ? senderLayout(_message)
            : receiverLayout(_message)
    ),
  );
}



  Widget senderLayout(Message message){

  Radius messageRadius = Radius.circular(10);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container( 
          margin: EdgeInsets.only(top: 8.0,bottom: 8.0),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.65,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: messageRadius,
              topRight: messageRadius,
              bottomLeft: messageRadius,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: getMessage(message),
            ),
        ),

        

        Column(children: <Widget>[
          CircleAvatar(radius: 20, backgroundColor: Theme.of(context).primaryColor,),
          Row(children: <Widget>[
             Icon(Icons.done_all),
            Text("1:20PM", style: TextStyle(color: Colors.blueGrey),)
            ],)
        ],)
      ],
    );
  }
  getMessage(Message message){
    return Text(
      message.message,
      style: TextStyle(color: Colors.white,fontSize: 20.0),
    );
  }


  Widget receiverLayout( Message message){

  Radius messageRadius = Radius.circular(10);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container( 
          margin: EdgeInsets.only(top: 12,),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.65,
          ),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.only(
              topLeft: messageRadius,
              topRight: messageRadius,
              bottomLeft: messageRadius,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: getMessage(message),
            ),
        ),
      ],
    );
  }

}
