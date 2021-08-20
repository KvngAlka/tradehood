import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i2i_tradehood/Modules/user.dart';
import 'package:i2i_tradehood/Screens/MainScreen/Profile/profile_header.dart';
import 'package:i2i_tradehood/Screens/MainScreen/Profile/profile_top_header.dart';
import 'package:i2i_tradehood/Screens/MainScreen/Settings/setting_page.dart';
import 'package:i2i_tradehood/Services/auth.dart';
import 'package:i2i_tradehood/Services/database_service.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    
    //a modal for setting, about and logout
    void _showMoreOption(){
      showModalBottomSheet(context: (context), builder: (context){
        
        return Container(
          padding: EdgeInsets.only(top: 10.0, left: 10,right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0)),
              color: Colors.white
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                child: Text("More"),
                ),
              Flexible(
                child: ListView(
                  children: <Widget>[

                    //profile setting
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => Settings(),
                          ));

                          //Navigator.pop(context);
                        },
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all( Radius.circular(10.0),),
                            color: Theme.of(context).primaryColor,
                          ),
                          height: 50,
                          width: 50,
                          child: Icon(Icons.settings, size: 30, color: Colors.white,),
                        ),
                        title: Text("Settings", style: TextStyle(fontWeight: FontWeight.bold,
                         color: Theme.of(context).primaryColor),),

                         subtitle: Text("Manipaulate your profile"),
                      ),
                    ),
                    Divider(color: Theme.of(context).primaryColor,),

                    //about 
                    ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all( Radius.circular(10.0),),
                          color: Theme.of(context).primaryColor,
                        ),
                        height: 50,
                        width: 50,
                        child: Icon(Icons.error, size: 30, color: Colors.white),
                      ),
                      title: Text("About", style: TextStyle(fontWeight: FontWeight.bold,
                       color: Theme.of(context).primaryColor),),

                       subtitle: Text("Details.."),
                    ),
                    Divider(color: Theme.of(context).primaryColor,),


                    GestureDetector(
                      onTap: () async{
                        await _auth.signOut();
                        Navigator.pop(context);
                      },
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            color: Theme.of(context).primaryColor,
                          ),
                          height: 50,
                          width: 50,
                          child: Icon(Icons.person, size: 30,color: Colors.white,),
                        ),
                        title: Text("LogOut", style: TextStyle(fontWeight: FontWeight.bold,
                         color: Theme.of(context).primaryColor),),

                         subtitle: Text("SignOut Profile"),
                      ),
                    ),
                  


                  ],
                ),
              ),

            ],
          ), 
        );
      });
    }
  final user = Provider.of<User>(context);
  
  //the profile itself
    return  StreamBuilder(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context,snapshot){

        if (snapshot.hasData){
          UserData userData = snapshot.data;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text('Profile',//userData.userName,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),),
              elevation: 0.0,
              actions: <Widget>[
                IconButton(
                  onPressed: (){
                    _showMoreOption();
                  },
                  icon: Icon(Icons.more_vert, color: Theme.of(context).primaryColor,),
                ),

              ],
            
            ),

            body: CustomScrollView(
              slivers: <Widget>[


                SliverList(delegate: SliverChildListDelegate(
                  [
                    ProfileTopHeader(name: userData.userName,),
                  ]
                ),),
                SliverPersistentHeader(
                  delegate: ProfileHeader(maxExtent: 50.0,
                  minExtent: 50.0),
                  pinned: true,
                  floating: false,
                  ),

                  
                
              
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {

                      

                      return Container(

                        height: 100,
                        alignment: Alignment.center,
                        color: Colors.amberAccent,
                        child: Image.asset('Asset/Images/kick image 3.jpg',fit: BoxFit.cover,),//Text('grid item $index'),
                      );
                    },
                    childCount: 11,
                  ),
                ),

                
                
              ],
            )
            
          );
        }else{
          return Container();
        }
      },
    );
    
  }
}




