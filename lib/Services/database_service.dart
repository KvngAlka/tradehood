import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i2i_tradehood/Modules/message_module.dart';
import 'package:i2i_tradehood/Modules/trader_post.dart';
import 'package:i2i_tradehood/Modules/user.dart';
import 'package:i2i_tradehood/constants/strings.dart';

class DatabaseService{
final String uid;
DatabaseService({this.uid});
//collection reference
  final CollectionReference tradersCollection = Firestore.instance.collection(TRADERS_COLLECTION);


  Future updateUserData(String userName, String country, String phoneNumber, String photoUrl) async{
    return await tradersCollection.document(uid).setData({
      'userName': userName,
      'country': country,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
    });
  }

  

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      userName: snapshot.data['userName'],
      phoneNumber: snapshot.data['phoneNumber'],
      country: snapshot.data['country'],
      photoUrl: snapshot.data['userName'],
      
    );
  }
  

  //get user doc stream
  Stream<UserData> get userData{
    return tradersCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }


//fetching all users also known to be a trader
  Future <List<UserData>> fetchAllUsers(FirebaseUser currentUser) async{
    List<UserData> userList = List<UserData>();

    QuerySnapshot querySnapshot =  
      await tradersCollection.getDocuments() ;

      for(var i = 0; i < querySnapshot.documents.length ; i++){
        if(querySnapshot.documents[i].documentID != currentUser.uid){
          userList.add(UserData.fromMap(querySnapshot.documents[i].data ));
        }
      }
      return userList;
    
  }

  final CollectionReference tradersPostCollection = Firestore.instance.collection(TRADERS_POST_COLLECTION) ;


  //adding post to document trader_post document
  Future addTraderPost( String senderId, String itemName, List<String> itemPhotosUrl,String itemDescription,Timestamp timestamp) async{
    return await tradersPostCollection.document(uid).collection('products').add({
      'sender id': senderId,
      'item name': itemName,
      'item photos' : itemPhotosUrl,
      'item description': itemDescription,
      'time posted' : timestamp,

    }) ;
  }


  //list of traders post from snapshot
  
List<TraderPost> _tradersPostListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return TraderPost(
        senderUid: doc.data['sender id'] ?? '',
        itemName: doc.data['item name']  ?? '',
        itemPhotosUrl: doc.data['item photos'] ?? '',
        itemDescription: doc.data['item description'] ??  '',
        timestamp: doc.data['time posted'] ?? '',
      );
    }).toList();
  }



  Stream<List<TraderPost>> get tradersPost{
    return tradersPostCollection.snapshots()
      .map(_tradersPostListFromSnapshot);
  }


  //the messages database
  CollectionReference messages = Firestore.instance.collection(MESSAGES_COLLECTION);



  Future addMessage(Message message , UserData sender, UserData receiver)async {
    var map = message.toMap();
    await messages.document(message.senderId).collection(message.receiverId).add(map);

    return await messages.document(message.receiverId).collection(message.senderId).add(map);
  }

  
  
}