
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderId;
  String receiverId;
  String type;
  String message;
  Timestamp timestamp;
  String photoUrl;
  bool unread;


  Message({this.senderId, this.receiverId, this.type, this.message, this.timestamp, this.unread});


//only be called when sending an image
Message.imageMessage({this.senderId, this.receiverId, this.message, this.type, this.photoUrl, this.timestamp, this.unread});


Map toMap(){
  var map = Map<String, dynamic>();
  map['senderId'] = this.senderId;
  map['receiverId'] = this.receiverId;
  map['type'] = this.type;
  map['message'] = this.message;
  map['timestamp'] = this.timestamp;
  map['unread'] = this.unread;
  return map;
}

//temporary message for unread something




Message.fromMap(Map<String, dynamic> map){
  this.senderId = map['senderId'];
  this.receiverId = map['receiverId'];
  this.type = map['type'] ;
  this.message = map['message'];
  this.timestamp = map['timestamp'];
  this.unread = map['unread'];
}


}

