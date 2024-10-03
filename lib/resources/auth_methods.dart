import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user.dart' as model;
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
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        // .doc(cred.user!.uid) ensures the user.id is the same one that firebase creates 'randomly'. the 'add' method doesnt do this.

        //add user to database
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          email: email,
          bio: bio,
          following: [],
          followers: [],
        );

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
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
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error ocurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }
}
