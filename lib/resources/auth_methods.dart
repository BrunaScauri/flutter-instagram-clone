import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser({
    //future because it will be asynchronous
    required String username,
    required String email,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    String res = 'Some error ocurred';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        UserCredential cred = _auth.createUserWithEmailAndPassword(
            email: email, password: password) as UserCredential;
        String photoUrl =
            await StorageMethods().uploadImageToStorage('profilePics', file, false);
        // .doc(cred.user!.uid) ensurs the user.id is the same one that firebase creates 'randomly'. the 'add' method doesnt do this.

        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          // 'password': password,
          'bio': bio,
          'followers': [],
          'following': [],
          'photo': photoUrl
        });
        res = 'success';
      }
    } 
    // on FirebaseAuthException catch(err) { //example of error handling specific for FirebaseAuth
    //   if(err.code == 'invalid-email') {
    //     res = 'Please input a valid email.';
    //   } else if (err.code == 'weak-password') {
    //     res = 'Password is too weak. Please try again.';
    //   }
    // } 
    catch(err) {

      res = err.toString();
    }
    return res;
  }
}
