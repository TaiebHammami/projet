import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled25/screens/home.dart';
import 'package:untitled25/screens/login.dart';

class FirebaseBackend {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  /// function save student
  Future<void> saveStudent(BuildContext context, String Id, String name,
      String lastName, String email, String age) async {
    try {
      User? cureentUser = _auth.currentUser;
      print(cureentUser!.uid);
      await db.collection("students").doc(cureentUser!.uid).set({
        'Id': Id,
        'name': name,
        'lastName': lastName,
        'email': email,
        'age': age
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Student saved successfully')));
      });
    } catch (e) {
      print(e.toString());
    }
  }

  /// function register
  Future<void> signUpWithEmailAndPassword(String email, String password,
      String name, String date, BuildContext context) async {
    try {
      // store in firebase auth
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;

      // store in fireStore
      await db.collection('users').doc(user!.uid).set(
          {'name': name, 'email': email, 'birth_date': date}).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('sign up success')));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }).onError((error, stackTrace) {
        print(error.toString() + "***************************");
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The email address is already in use.')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An error occurred: ${e.code}')));
      }
    }
  }

  /// function sign in
  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      // test on firebase auth
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Login success')));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User not found. please sign up')));
      }
      if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Verify your password')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('a error occurred')));
      }
    }
    return null;
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut().then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }
}
