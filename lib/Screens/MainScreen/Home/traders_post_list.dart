import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:i2i_tradehood/Modules/trader_post.dart';
import 'package:i2i_tradehood/Modules/user.dart';
import 'package:i2i_tradehood/Screens/MainScreen/Message/chat.dart';
import 'package:i2i_tradehood/Screens/splash_screen/color_loader_2.dart';
import 'package:provider/provider.dart';



class TradePostList extends StatefulWidget {
  @override
  _TradePostListState createState() => _TradePostListState();
}

class _TradePostListState extends State<TradePostList> {
  
  @override
  Widget build(BuildContext context) {

    final tradersPost = Provider.of<List<TraderPost>>(context);

    //a fake item poster to check if the uid really works
    UserData fakePoster = UserData(uid: "fakeuid", userName: "kvng alka");
    
    if(tradersPost != null){

      return Container(
      height: MediaQuery.of(context).size.height * 0.735,
      child: ListView.builder(
        itemCount: 2,//,tradersPost.length,
          itemBuilder: (BuildContext context, int index){
            //final traderUid = tradersPost[index].senderUid;
          
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(143, 148, 251, .2),
                      blurRadius: 20.0,
                      offset: Offset(0,10)
                  )
                ]
            ),
            width: MediaQuery.of(context).size.width * 0.65,
            height: 350,

            child: Column(
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 90,
                      child: Carousel(
                        images: [
                            
                          Image(image: AssetImage("Asset/Images/shop image.jpg"),fit: BoxFit.cover,),
                        
                          
                          Image(image: AssetImage("Asset/Images/shop image.jpg"),fit: BoxFit.cover,),
                        ],
                        autoplay: false,
                      )
                    ),
                  ),
                ),

                //profile under the post with some message if interested in the product
                Container(
                    padding: EdgeInsets.only(left: 10.0,bottom: 5.0),
                  height: 60,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20.0,

                        //the picture of who posted
                        backgroundImage: AssetImage('Asset/images/kick image 3.jpg'),
                        
                      ),

                      //the username of the person who posted
                      title: Text( fakePoster.userName,
                        style: TextStyle( fontWeight: FontWeight.bold, fontSize: 20),),
                      subtitle: Text("Ratings"),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          children: <Widget>[
                           
                            IconButton(icon: Icon(Icons.send, color: Theme.of(context).primaryColor,),
                            onPressed: (){
                              Navigator.of(context).push(

                                //owner of post's name get and route to chat screen
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Chat(receiver: fakePoster.uid,),
                                ));
                            },),

                            IconButton(icon: Icon(Icons.more_vert, color: Theme.of(context).primaryColor,),
                            onPressed: (){
                              
                            },)
                          ],
                        ),
                      ),
                    )
                )
              ],
            ),
          ),
        );
      }),
    );

    }else{
      return Container(
        height: 320,
        child: Center(
          child: ColorLoader2(
            color1: Theme.of(context).primaryColor,
            color2: Theme.of(context).primaryColor,
            color3: Theme.of(context).primaryColor,
          ),),
      );
    }

    
  }
}





  
