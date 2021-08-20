import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i2i_tradehood/Modules/Users.dart';
import 'package:i2i_tradehood/Screens/MainScreen/Home/home.dart';
import 'package:i2i_tradehood/Screens/MainScreen/Message/messages.dart';
import 'package:i2i_tradehood/Screens/MainScreen/Post/add_post.dart';
import 'package:i2i_tradehood/Screens/MainScreen/Profile/my_profile.dart';
import 'package:i2i_tradehood/Screens/MainScreen/Settings/setting_page.dart';





class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {



  int currentPageNumber = 0;
  int initPage = 0;
  PageController pageController ;
  

  @override
  void initState(){
    pageController = PageController(initialPage: initPage , keepPage: true);

    super.initState();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          PageView(
            pageSnapping: true,
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: <Widget>[
              Home(),
              AddPostPage(),
              Messages(),
              Settings(),
              MyProfile(),
            ],
          ),



          Positioned(
            bottom: 10.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10),
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  color: Theme.of(context).primaryColor,
                ),



                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: <Widget>[
                    IconButton(
                      onPressed: (){
                        setState(() {
                          currentPageNumber = 0;
                          pageController.jumpToPage(currentPageNumber);
                        });
                      },
                      icon: Icon(Icons.home, color: currentPageNumber == 0  ?  Colors.white: Colors.grey,),
                    ),

                    IconButton(
                      onPressed: (){
                        setState(() {
                          currentPageNumber = 1;
                          pageController.jumpToPage(currentPageNumber);
                        });
                      },
                      icon: Icon(Icons.add_circle,color: currentPageNumber == 1 ?  Colors.white: Colors.grey,),
                    ),

                    IconButton(
                      onPressed: (){
                        setState(() {
                          currentPageNumber = 2;
                          pageController.jumpToPage(currentPageNumber);
                        });
                      },
                      icon: Icon(Icons.message,color: currentPageNumber == 2 ?  Colors.white: Colors.grey,),
                    ),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          currentPageNumber = 4;
                          pageController.jumpToPage(currentPageNumber);
                        });
                      },
                      child: FittedBox(
                          child: CircleAvatar(
                            radius: 12.0,
                            backgroundImage: AssetImage(currentUser.imgUrl),
                          )
                      ),
                    ),
                  ],
                ),

              ),
            ),
          ),




        ],
      ),

    );
  }



  
}


