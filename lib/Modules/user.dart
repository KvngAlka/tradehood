class User{

  final String uid;
  User({ this.uid});
}

class UserData{

 String uid;
 String userName;
 String phoneNumber;
 String country;
 String photoUrl;

UserData({this.uid, this.userName,this.phoneNumber, this.country, this.photoUrl});

UserData.fromMap(Map<String,  dynamic> mapData){
  this.uid = mapData['uid'];
  this.userName = mapData['uid'];
  this.phoneNumber = mapData['phoneNumber'];
  this.country = mapData['country'];
  this.photoUrl = mapData['photoUrl'];
}


}