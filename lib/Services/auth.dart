import 'package:firebase_auth/firebase_auth.dart';
import 'package:i2i_tradehood/Modules/user.dart';
import 'package:i2i_tradehood/Services/database_service.dart';



class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user based on FirebaseUser
  User _userFromFireBaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  //getCurrent User
  Future<FirebaseUser> getCurrentUser() async{
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return currentUser;
  }



  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
     // .map((FirebaseUser user) => _userFromFireBaseUser(user));
    .map(_userFromFireBaseUser);
  }





  //sign in anon
  Future signInAnon() async{
    try{
     AuthResult result = await _auth.signInAnonymously();
     FirebaseUser user = result.user;
     return _userFromFireBaseUser(user);

    }catch(e){
      print(e.toString());
      return null;

    }



  }

  // sign in email and pass
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser  user = result.user;
      return _userFromFireBaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //register with email and pass
  Future signUpWithEmailAndPassword(String email, String password, String userName, String phoneNumber, String country) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser  user= result.user;

      //create a document for the user
      await DatabaseService(uid: user.uid).updateUserData(userName, country, phoneNumber,"");
      return _userFromFireBaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  // sign out method
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}