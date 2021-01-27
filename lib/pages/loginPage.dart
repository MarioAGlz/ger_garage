import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ger_garage/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:ger_garage/services/firebase/firebase_auth_srvc.dart';
import 'package:ger_garage/styles/colors.dart';

import '../widgetTempls.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget with NavigationStates {

  String _password;
  String _email;
  TextEditingController _tFeContrll = TextEditingController();
  TextEditingController _tFpContrll = TextEditingController();
  final _lgFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder (builder: (context) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 45.0,
                      vertical: 90.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text( 'Log In',
                          style: TextStyle(
                            color: Color(gunmetal),
                            //fontFamily: 'OpenSans',
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Icon(Icons.account_circle, color: Color(orangeSoda), size: 60,),
                        SizedBox(height: 20.0),
                        Form(
                          key: _lgFormKey,
                          child: Column(
                            children: <Widget>[
                              buildTextF(_tFeContrll, TextInputType.emailAddress, false,
                                  'Email', Icons.email, 'Enter your Email'),
                              // SizedBox(height: 10.0,),
                              buildTextF(_tFpContrll, TextInputType.visiblePassword, true,
                                  'Password', Icons.lock, 'Enter your password'),
                              _buildForgotPasswordBtn(),
                              // _buildLogInBtn(context),
                              _buildLogInBtn(context),
                            ],
                          ),
                        ),
                        buildTextSignWith('Sign in with'),
                        buildSocialBtnRow(context),
                        // _buildSignUpBtn(context),
                        buildSignBtn(context, NavigationEvents.SigUpClickedEvent,
                            'Don\'t have an Account?  ', 'Sign up'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
    })
    );
  }


  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
//          style: labelStyle,
        ),
      ),
    );
  }


  Widget _buildLogInBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 6.0,
        onPressed: () => {
          print('Login Button Pressed'),
          if(_lgFormKey.currentState.validate()) {
            _email = _tFeContrll.text,
            _password = _tFpContrll.text,
            FirebaseAuthService.firebaseSignIn(context, _email, _password),
            _tFeContrll.clear(),
            _tFpContrll.clear(),
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(carolBlue),
        child: Text( 'LOGIN',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 2,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

}

