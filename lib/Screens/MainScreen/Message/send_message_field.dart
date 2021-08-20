import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:i2i_tradehood/Modules/message_module.dart';
import 'package:i2i_tradehood/Services/database_service.dart';


class SendField extends StatefulWidget {

 final TextEditingController textEditingController;
 final  receiver;
 final sender;
 
 
 SendField({this.textEditingController, this.receiver,this.sender });

  @override
  _SendFieldState createState() => _SendFieldState();
}

class _SendFieldState extends State<SendField> {

 
 DatabaseService  _databaseService = DatabaseService();

bool isWritting = false;





  @override
  Widget build(BuildContext context) {

      sendMessage(){
        var text = widget.textEditingController.text;

        Message _message = Message(
          receiverId: widget.receiver.uid,
          senderId:  widget.sender.uid,
          message: text,
          timestamp: Timestamp.now(),
          type: 'text',
          unread: true,
        );

        setState(() {
          isWritting = false;
        });

        widget.textEditingController.text = '';

        _databaseService.addMessage(_message, widget.sender, widget.receiver);
      }

     setWritingTo(bool val){
      setState(() {
        isWritting = val;
      });
    }

    return Container(
      child: Row(
        children: <Widget>[
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.face),
                onPressed: (){},
                color: Theme.of(context).primaryColor,
              ),
            ),
            color: Colors.white,
          ),


          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onChanged: (val){
                  (val.length > 0 && val.trim() != "") ? setWritingTo( true) : setWritingTo( false);
                },
                style: TextStyle(color: Theme
                    .of(context)
                    .primaryColor, fontSize: 15.0),
                controller: widget.textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),

          // Button send message
          isWritting ?
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () {
                  sendMessage();
                },
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
            ),
            color: Colors.white,
          )
          : 
          Container(),

          // Button send image through gallery
          isWritting ? Container()
          :
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.image),
                onPressed: () {},
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
            ),
            color: Colors.white,
          ),

          // Button send image through camera
          isWritting ? Container()
          :
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.camera_alt),
                onPressed: () {},
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border:
          new Border(top: new BorderSide(color: Theme
              .of(context)
              .primaryColor, width: 0.5)),
          color: Colors.white),
    );
  }
}