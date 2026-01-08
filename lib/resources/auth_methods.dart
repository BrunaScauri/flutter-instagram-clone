import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser({
    //future because it will be asynchronous
    required String email,
    required String password,
    required String username,
    required String bio,
    // required Uint8List photoUrl,
  }) async {
    String res = 'Some error ocurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password
        );
        //currently not uploading to firestore as that requires a paid account :D
        // String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);

        model.User user = model.User(
          username: username,
          email: email,
          uid: cred.user!.uid,
          // photoUrl: photoUrl,
          bio: bio,
          followers: [],
          following: []
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
        res = 'success';
      }
    } catch (err) {
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
          email: email, password: password
        );
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    }  on FirebaseAuthException catch(e) {
      if(e.code == 'invalid-email') {
        res = 'Email not valid. Please try again.';
      }
      if(e.code == 'missing-password') {
        res = 'Please type a password.';
      }
      if(e.code == 'invalid-credential') {
        res = 'Invalid user or password. Please try again.';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }
}
