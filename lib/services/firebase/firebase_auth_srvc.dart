import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ger_garage/SideBar/sidebar.dart';
import 'package:ger_garage/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:ger_garage/styles/colors.dart';
import 'package:google_sign_in/google_sign_in.dart';


class FirebaseAuthService {

  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();

  static Stream<User> firebaseListener =
      _firebaseAuth.authStateChanges();

  static void mySnackBar(BuildContext context, String str) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(str),
        elevation: 10.0, backgroundColor: Color(gunmetal),
        behavior: SnackBarBehavior.floating,));

  static void firebaseSignIn(BuildContext context, String email, String password) async {
    try {
      final _authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print(_authResult.user.email);
      mySnackBar(context, 'Log in Successful');
      BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickedEvent);
    } catch (e) {
      print(e);
      mySnackBar(context, e.toString());
    }
  }

  static void firebaseSignUp(BuildContext context, String email, String password) async {
    try {
      final _authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(_authResult);
      mySnackBar(context, 'Sign up Successful');
      BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickedEvent);
    } catch (e) {
      print(e);
      mySnackBar(context, e.toString());
    }
  }

  static void fBSignInWithGoogle(BuildContext context) async {
    try {
      fBGoogleUserDetail()
        .then((UserCredential user) => print(user.user.email));
      mySnackBar(context, 'Signed in with Google');
    } catch (e) {
      print(e);
      mySnackBar(context, e.toString());
    }
  }

  static Future<UserCredential> fBGoogleUserDetail() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken
    );
    final userDetails = await _firebaseAuth.signInWithCredential(credential);
    return userDetails;
  }


  static Future<User> firebaseUserDetail() async =>
      await _firebaseAuth.currentUser;

  static void firebaseLogout(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      mySnackBar(context, 'Logged out');
    } catch (e) {
      print(e);
    }
  }


  final DocumentReference bookingReference =
      FirebaseFirestore.instance.collection('bookings').doc('');

  final DocumentReference carsReference =
      FirebaseFirestore.instance.collection('cars').doc('');



}