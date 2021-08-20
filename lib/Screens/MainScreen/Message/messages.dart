import 'package:flutter/material.dart';
import 'package:i2i_tradehood/Screens/MainScreen/Message/chat.dart';
import 'package:i2i_tradehood/Screens/MainScreen/Message/search_screen.dart';
import 'package:i2i_tradehood/Services/auth.dart';


class Messages extends StatefulWidget {

  final currenUser;
  Messages({this.currenUser}); 

  @override
  _MessagesState createState() => _MessagesState();
}

//global

AuthService _authService = AuthService();

class _MessagesState extends State<Messages> {
  int selectedIndex = 0;
    var searchPosition = -100.0;
    var searchWidthPercentage = 0.8;
   // String _currentUserId;


    Curve searchCurve = Curves.fastLinearToSlowEaseIn;

    TextEditingController _textEditingController;
    @override
    void initState() {
      super.initState();
      _textEditingController = TextEditingController();

      _authService.getCurrentUser().then((user){
        setState(() {
         // _currentUserId = user.uid;
        });
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor,),
        ),
        title: Row(
          children: <Widget>[
            Text("MESSAGES",
              style: TextStyle(fontSize: 15.0, color:Theme.of(context).primaryColor),),
            SizedBox(width: 10.0,),
            CircleAvatar(radius: 15.0,

            //implemet the number of messages sent

              child: Text("1",
                style: TextStyle(color: Colors.white, fontSize: 10),),
              backgroundColor: Theme.of(context).primaryColor,),
          ],
        ),
        actions: <Widget>[
          IconButton(
          onPressed: (){
            // setState(() {
            //   searchPosition = searchPosition == -100 ? 10 : -100;
            //   searchCurve = searchCurve == Curves.fastLinearToSlowEaseIn ? Curves.fastOutSlowIn
            //       :
            //   Curves.fastLinearToSlowEaseIn;
            // });
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    SearchScreen(),
              ));
            
          },
            icon: Icon(Icons.search), color: Theme.of(context).primaryColor,),],
        elevation: 0.0,
      ),



      body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                //messages from favourites
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 350.0,
                      child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            
                            return ListTile(
                              //move to chat screen
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Chat(receiver: "Alka",),
                                    ));
                              },
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                    "Asset/Images/shop image 2.jpg"),
                                radius: 30,
                              ),
                              title: Text("Kvng",
                                style: TextStyle(fontWeight: FontWeight.bold),),

                              //now to implement read and unread message
                              subtitle: Text("Hello there",
                                style: TextStyle(
                                  color : Colors.black,
                              ),),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround,
                                children: <Widget>[
                                  CircleAvatar(radius: 10.0,
                                  //the number of messages sent
                                    child: Text("2",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),),
                                    backgroundColor: Theme
                                        .of(context)
                                        .primaryColor,),


                                  SizedBox(height: 10,),
                                  //the time the message was sent
                                  Text("1:20PM",
                                    style: TextStyle(fontSize: 10.0),),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
          

            AnimatedPositioned(
                          duration: Duration(seconds: 1),
                          curve: searchCurve,
                          top: searchPosition,
                          //left: 40,
                          child: Container(
                            width:  MediaQuery.of(context).size.width ,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Material(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  color: Colors.white,
                                  elevation: 2.0,
                                  child: AnimatedContainer(
                                    duration: Duration(seconds: 1),

                                    width: MediaQuery.of(context).size.width * searchWidthPercentage,
                                    padding: EdgeInsets.only(left: 30,),
                                    child: TextField(
                                      controller: _textEditingController,
                                      onSubmitted: (val) async{
                                        setState(() {
                                          print(val);
                                          _textEditingController.clear();
                                          searchPosition = -100;
                                        });
                                      //the value of what was searched

                                    },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Search for products here",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

          ]
      ),
    );
  }
}





/*

        //following online
        Row(mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text("Online", style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            CircleAvatar(backgroundColor: Colors.green,radius: 3.0,)
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          height: 70,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: myFavourites.length,
              itemBuilder: (BuildContext context, int index){
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(backgroundImage: AssetImage("Asset/Images/kick image 3.jpg"),),
                    ),
                    Text(myFavourites[index].userName, style: TextStyle(color: Theme.of(context).primaryColor,),),
                  ],
                );
              }),
        ),

        */