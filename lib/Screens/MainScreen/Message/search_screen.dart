import 'package:flutter/material.dart';
import 'package:i2i_tradehood/Modules/user.dart';
import 'package:i2i_tradehood/Screens/MainScreen/Message/chat.dart';
import 'package:i2i_tradehood/Services/auth.dart';
import 'package:i2i_tradehood/Services/database_service.dart';



class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
DatabaseService _databaseService = DatabaseService();

List<UserData> userList;

String query = '';

TextEditingController searchController = TextEditingController();


@override
  void initState() {
    
    super.initState();

    AuthService().getCurrentUser().then((user){
      _databaseService.fetchAllUsers(user).then((List<UserData> list){
        setState(() {
          userList = list;
        });
      });
       
    });
  }
  @override
  Widget build(BuildContext context) {
    Widget searchAppBar(){
      return AppBar(
        backgroundColor:  Theme.of(context).primaryColor,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, color:Colors.white,),
        onPressed: (){
          Navigator.pop(context);
        },
        ),
        bottom: PreferredSize( preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: Padding(padding: EdgeInsets.only(left: 20),
          child: TextField(
            controller: searchController,
            onChanged: (val){
              setState(() {
                query = val;
              });
            },
            cursorColor: Colors.white,
            autocorrect: true,
            style: TextStyle(fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 35,
          ),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white, fontSize: 35,),
            suffixIcon: IconButton(icon: Icon(Icons.close, color: Colors.white,),
          onPressed: (){
            WidgetsBinding.instance.addPostFrameCallback((_) => searchController.clear());
          },),
          border:InputBorder.none,
           ),
          
        ),
        ),
      ),
     elevation: 0.0,
    );
  }

  Widget buildSuggestions(String query){
    final List<UserData> suggestionList = query.isEmpty
      ? []
      : userList.where( 
        (UserData user){
          String _getUserName = user.userName.toLowerCase();
          String _query = query.toLowerCase();
          bool matchUserName = _getUserName.contains(_query);

          return matchUserName;
        }

        // (UserData user) => (user.userName.toLowerCase().contains(query.toLowerCase() )
        //     || (user.userName.toLowerCase().contains(query.toLowerCase()))),
      ).toList();

      if(suggestionList != null){
        return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index){
          UserData searchedUser = UserData(
            uid: suggestionList[index].uid,
            userName: suggestionList[index].userName,
            photoUrl: suggestionList[index].photoUrl,
          );
        return ListTile(
          leading: CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage(searchedUser.photoUrl),
          ),
          title: Text(searchedUser.userName, style: TextStyle(color: Colors.white),),
          subtitle: Text('some description over here'),
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    Chat(receiver: suggestionList[index].uid,),
              ));
          },
        );
      });
      }else{
        return Center(child: Text('Loading...'),);
      }
      
       
  }


    return Scaffold(
      appBar: searchAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: buildSuggestions(query),
      ),
    );
  }
}