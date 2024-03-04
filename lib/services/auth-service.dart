import 'package:chattingapp/helping/helper_fun.dart';
import 'package:chattingapp/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//login
  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

//register
  Future registerUserWithEmailandPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        //calling database service
        DatabaseService(uid: user.uid).savingteUserData(fullName, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

// sign out

  Future signOut() async {
    try {
      await HelperFunction.saveUSerLoggedInStatus(false);
      await HelperFunction.saveUSerEmailSF("");
      await HelperFunction.saveUSerNameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
//firebaseAuthException is the class used for the handling the exception occurred during firebase authentication