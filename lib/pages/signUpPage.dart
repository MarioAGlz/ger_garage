
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ger_garage/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:ger_garage/services/firebase/firebase_auth_srvc.dart';
import 'package:ger_garage/styles/colors.dart';
import 'package:ger_garage/widgetTempls.dart';

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget with NavigationStates {

  String _name;
  String _email;
  String _password;
  TextEditingController _tFnContrll = TextEditingController();
  TextEditingController _tFeContrll = TextEditingController();
  TextEditingController _tFpContrll = TextEditingController();
  final _snFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
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
                      Text( 'Sign Up',
                        style: TextStyle(
                          color: Color(gunmetal),
                          fontFamily: 'OpenSans',
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Icon(Icons.person_add, color: Color(orangeSoda), size: 60,),
                      SizedBox(height: 20.0),
                      Form(
                        key: _snFormKey,
                        child: Column(
                          children: <Widget>[
                            buildTextF(_tFnContrll, TextInputType.name, 'Name',
                                Icons.person, 'Enter your name'),
                            // SizedBox(height: 10.0,),
                            buildTextF(_tFeContrll, TextInputType.emailAddress, 'Email',
                                Icons.email, 'Enter your Email'),
                            // SizedBox(height: 10.0,),
                            buildTextF(_tFpContrll, TextInputType.visiblePassword, 'Password',
                                Icons.lock, 'Enter your password'),
                            _buildSignUpBtn(context),
                          ],
                        ),
                      ),
                      buildTextSignWith('Sign up with'),
                      buildSocialBtnRow(context),
                      buildSignBtn(context, NavigationEvents.LoginClickedEvent,
                          'Already have an Account?  ', 'Log in'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSignUpBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 35.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 6.0,
        onPressed: () => {
          print('SignUp Button Pressed'),
          if(_snFormKey.currentState.validate()) {
            FirebaseAuthService.firebaseSignUp(context, _email, _password),
            _tFnContrll.clear(),
            _tFeContrll.clear(),
            _tFpContrll.clear(),
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(carolBlue),
        child: Text( 'SIGN UP',
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
