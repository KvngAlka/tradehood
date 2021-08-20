import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i2i_tradehood/Modules/trader_post.dart';
import 'package:i2i_tradehood/Screens/MainScreen/Home/traders_post_list.dart';
import 'package:i2i_tradehood/Services/database_service.dart';
import 'package:provider/provider.dart';



class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  //selected index not toggling
  int selectedIndex = 0;
  var searchPosition = -100.0;
  var searchWidthPercentage = 0.8;



  Curve searchCurve = Curves.fastLinearToSlowEaseIn;

  TextEditingController _textEditingController;
  final dbService  =  DatabaseService();
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<TraderPost>>.value(
      value: dbService.tradersPost,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
                        elevation: 2.0,
                        child: Container(
                          height: 70.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("TRADEHOOD", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                    letterSpacing: 1.0,
                                  fontSize: 20,
                                ),),
                                Material(
                            borderRadius:  BorderRadius.all(Radius.circular(50.0)),
                            elevation: 2.0,
                                    child: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        searchPosition = searchPosition == -100 ? 10 : -100;
                                        searchCurve = searchCurve == Curves.fastLinearToSlowEaseIn ? Curves.fastOutSlowIn
                                            :
                                        Curves.fastLinearToSlowEaseIn;
                                      });
                                    },
                                      icon: Icon(Icons.search), color: Theme.of(context).primaryColor,)
                                      ),
                                      ]
                              ),
                          ),
                        ),
                      ),
                      


                      //Post from followers and a search field to query product

                      Stack(
                        children: <Widget>[

                        //List of Trader's Post
                        TradePostList(),

                          //search field
                          AnimatedPositioned(
                            duration: Duration(seconds: 2),
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
                      )

                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}








//replaced by a search field

//page toggling
/*
                    Container(
                      height: 20.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: homePageNav.length,
                          itemBuilder: (BuildContext context, int index){
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                selectedIndex = index;
                                currentPageName = homePageNav[selectedIndex];
                                print(selectedIndex);

                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 10.0),
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                color: index == selectedIndex ? Theme.of(context).primaryColor: Colors.white,
                              ),
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 30.0,
                              child: Text(homePageNav[index] ,textAlign: TextAlign.center, style: TextStyle(
                                color:  index == selectedIndex ? Colors.white : Colors.blueGrey
                              ),),
                            ),
                          ),
                        );
                      }),
                    ),

                     */
                    