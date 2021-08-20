import 'package:cloud_firestore/cloud_firestore.dart';



class TraderPost{
  final String senderUid ;
  final String itemName;
  final List<String> itemPhotosUrl;
  final String itemDescription;
  final Timestamp timestamp;

  TraderPost({this.senderUid, this.itemName, this.itemPhotosUrl,this.itemDescription, this.timestamp});
}