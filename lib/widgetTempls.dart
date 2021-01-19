
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ger_garage/services/firebase/firebase_auth_srvc.dart';
import 'package:ger_garage/styles/colors.dart';
import 'bloc/navigation_bloc/navigation_bloc.dart';


Widget buildTextF(TextEditingController _tFContrllr, TextInputType tIType,
    String labelTxt, IconData iconTF, String errorMsg) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 25.0),
      Container(
        alignment: Alignment.center,
        decoration: boxDecorationStyle,
        height: 60.0,
        child: TextFormField(
          controller: _tFContrllr,
          keyboardType: tIType,
          style: textFieldStyle,
          decoration: InputDecoration(
            border: InputBorder.none,
//              contentPadding: EdgeInsets.only(top: 5.0),
            labelText: labelTxt,
            labelStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(
              iconTF,
              color: Color(orangeIcons),
            ),
//              hintText: 'Enter your name',
//              hintStyle: hintTextStyle,
          ),
//            onChanged: (value) => getVal,
          validator: (value) =>
          value.trim().isEmpty ? '     ' + errorMsg : null,
        ),
      ),
    ],
  );
}


Widget buildDropDw(Widget _icon, Widget _dropDwB) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 20.0),
      Container(
        alignment: Alignment.center,
        decoration: boxDecorationStyle,
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _icon,
            _dropDwB,
          ],
        ),
      ),
    ],
  );
}


Widget buildTextSignWith(String txt) {
  return Column(
    children: <Widget>[
      Text(
        '-----  OR  -----',
        style: TextStyle(
          color: Color(gunmetal),
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 10.0),
      Text( txt,
        style: labelStyle,
      ),
    ],
  );
}


Widget buildSocialBtnRow(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 30.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildSocialBtn(
              () {
            print('Sign up with Google');
            FirebaseAuthService.fBSignInWithGoogle(context);
          },
          AssetImage(
            'assets/logos/google.jpg',
          ),
        ),
        /*_buildSocialBtn(
                () => print('Login with Facebook'),
            AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),*/
      ],
    ),
  );
}

Widget _buildSocialBtn(Function onTap, AssetImage logo) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(dazzledBlue),
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
        image: DecorationImage(
          image: logo,
        ),
      ),
    ),
  );
}


Widget buildSignBtn(BuildContext context, NavigationEvents navEvent, String quest, String page) {
  return GestureDetector(
    onTap: () => {
      print('LogIn Button Pressed'),
      BlocProvider.of<NavigationBloc>(context).add(navEvent),
    },
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: quest,
            style: TextStyle(
              color: Color(gunmetal),
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: page,
            style: TextStyle(
              color: Color(carolBlue),
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}