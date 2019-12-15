import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/services/database.dart';


class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // create User object based on FireBAseUser object
  User _userFromFirebaseUSer(FirebaseUser firebaseUser){
      return firebaseUser != null ? User(userId: firebaseUser.uid): null;

  }

  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUSer(user));
    //we can also type instead of that map : .map(_userFromFirebaseUSer);
  }


  Future signInAnonymously() async {
    try {
      AuthResult result =  await _firebaseAuth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUSer(user);
    } catch(e) {
      print(e.toString());
      return null;
    }

  }

  // sign out function

  Future signOut() async{
    try {
      return await _firebaseAuth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  // register with email and password function 

  Future signUpWithEmailAndPassword(String email, String password) async{
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email,password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserDate('0', 'new brew crew', 100);
      return _userFromFirebaseUSer(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in Using an email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email,password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUSer(user);
    } catch (e) {
      print(e.toString());
      return null;
    }

  }
}