import 'package:i2i_tradehood/Modules/Users.dart';

class Post{
  User sender;
  String time;
  String image;
  String description;
  int numberOfViews;
  String postType;

  Post({this.sender, this.time, this.postType, this.image, this.description, this.numberOfViews});
}


List<Post> followersPost = [
  Post(
    sender: kvng,
    time: "1:00 AM"
  ),
  Post(
      sender: emma,
      time: "3:35 PM"
  ),
  Post(
      sender: gloria,
      time: "5:10 AM"
  ),
  Post(
      sender: kvng,
      time: "7:00PM"
  )
];

