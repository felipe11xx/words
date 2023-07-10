import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../user_session/auth/data/model/sing_in_request.dart';
import '../resources/strings.dart';

class AuthException implements Exception{
  String? message;

  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
 final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthService() {
    _authCheck();
  }

  User? userAuth;

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      userAuth = (user == null) ? null : user;
      notifyListeners();
    });
  }

  _getUser(){
    userAuth = _auth.currentUser;
    notifyListeners();
  }

  signIn(SignInRequest signInRequest)async{
      try {
        await _auth.signInWithEmailAndPassword(email: signInRequest.email, password: signInRequest.password);
        _getUser();
      }  on FirebaseAuthException catch(e){
        if(e.code == 'user-not-found'){
          throw AuthException(Strings.userNotFound);
        }else if(e.code == 'wrong-password'){
          throw AuthException(Strings.incorrectPassword);
        }
        throw AuthException(e.message);
      }
  }

  signUp(SignInRequest signInRequest)async{
      try {
        await _auth.createUserWithEmailAndPassword(email: signInRequest.email, password: signInRequest.password);
        _getUser();
      }  on FirebaseAuthException catch(e){
        if(e.code == 'waek-password'){
          throw AuthException(Strings.weakPassword);
        }else if(e.code == 'email-already-in-use'){
          throw AuthException(Strings.emailIsAlreadyInUse);
        }
        throw AuthException(e.message);
      }
  }

  signOut()async{
      try {
        await _auth.signOut();
        _getUser();
      }  on FirebaseAuthException catch(e){
        throw AuthException(e.message);
      }
  }

}
