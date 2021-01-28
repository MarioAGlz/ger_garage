import 'dart:async';
import 'dart:ui';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ger_garage/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:ger_garage/database/booking_model.dart';
import 'package:ger_garage/database/gears_db.dart';
import 'package:ger_garage/services/firebase/firebase_auth_srvc.dart';
import 'package:ger_garage/styles/colors.dart';
import 'package:ger_garage/widgetTempls.dart';

class Bookings extends StatefulWidget with NavigationStates {
  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  String _userName;
  String _userMail;
  int _userPhone;
  String _vehType = 'Vehicle type';
  String _vehMake = 'Vehicle make';
  String _vehModel;
  int _vehYear;
  String _vehFuel = 'Fuel type';
  String _vehLicence;
  String _vehEngine;
  String _servType = 'Service type';
  String _daTime;
  String _userCommt;

  TextEditingController _tFuNContrll = TextEditingController();
  TextEditingController _tFuMContrll = TextEditingController();
  TextEditingController _tFuPContrll = TextEditingController();
  // TextEditingController _tFvTContrll = TextEditingController();
  TextEditingController _tFvMContrll = TextEditingController();
  TextEditingController _tFvYContrll = TextEditingController();
  TextEditingController _tFvFtContrll = TextEditingController();
  TextEditingController _tFvLContrll = TextEditingController();
  TextEditingController _tFvEContrll = TextEditingController();
  TextEditingController _tFtDContrll = TextEditingController();
  TextEditingController _tFtTContrll = TextEditingController();
  TextEditingController _tFuCContrll = TextEditingController();
  final _bFormKey = GlobalKey<FormState>();


  void _setData() {
    _userName = _tFuNContrll.text;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(azureBlue),
        title: Text('Bookings ',),
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back), iconSize: 30,
          onPressed: () {
            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.BookingsClickedEvent);},
        ),
      ),
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 45.0,
            vertical: 15.0,
          ),
          child: Form(
            key: _bFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Book a Service",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
                ),
                Icon(
                  Icons.build,
                  size: 40,
                  color: Color(orangeSoda),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                buildTextF(_tFuNContrll, TextInputType.name, false,
                    'Name', Icons.person, 'Enter your name'),
                buildTextF(_tFuMContrll, TextInputType.emailAddress, false,
                    'Email', Icons.email, 'Enter your e-mail'),
                buildTextF(_tFuPContrll, TextInputType.phone, false,
                    'Phone number', Icons.phone, 'Enter your phone number'),
                SizedBox(
                  height: 5,
                ),
                buildDropDw(
                  Icon(Icons.build,
                      size: 25, color: Color(orangeIcons)),
                  DropdownButton<String>(
                    value: _servType,
                    icon:
                    Icon(Icons.arrow_drop_down, color: Color(orangeIcons)),
                    iconSize: 45,
                    elevation: 16,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400, ),
                    dropdownColor: Color(gunmetal),
//                    isExpanded: true,
                    underline:
                    Container(height: 0.3, color: Color(orangeIcons)),
                    onChanged: (newValue) =>
                        setState(() => _servType = newValue),
                    items: <String>[
                      'Service type',
                      'Full service',
                      'Intermediate service',
                      'Brakes & Suspension',
                      'Clutch & Gearbox',
                      'Pre NTC & Repairs'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 8),
                  alignment: Alignment.center,
                  decoration: boxDecorationDate,
                  height: 65,
                  child: DateTimePicker(
                    controller: _tFtDContrll,
                    type: DateTimePickerType.dateTimeSeparate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2050),
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    dateLabelText: 'Date',
                    dateMask: 'd MMM, yyyy',
                    timeLabelText: 'Time',
                    icon: Icon(Icons.event, color: Color(orangeIcons), size: 27),
                    selectableDayPredicate: (date) {
                      if(date.weekday == 7) {
                        return false;
                      }
                      return true;
                    },
                  ),
                ),
                buildTextF(_tFuCContrll, TextInputType.text, false,
                    'User comments', Icons.comment, 'Enter comments'),
                SizedBox(height: 25),
                Container(
                  decoration: boxDecorationDate,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  // height: 60,
                  child: Column(
                    children: [
                      Text('Select your car:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),

                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 10,
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Color(carolBlue),
                    child: Text( 'SEND',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    onPressed: () {
                      if(_bFormKey.currentState.validate()) {
                        print('validated: '+_tFuNContrll.text+' '+_tFtDContrll.text);
                        insertBkn(Booking(bName: _tFuNContrll.text, bEmail: _tFuMContrll.text,
                            bPhone: _tFuPContrll.text, bServTp: _servType, bDate: _tFtDContrll.text,
                            bComment: _tFuCContrll.text)
                        );
                        FirebaseAuthService.mySnackBar(context, 'A Booking saved');
                        BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.BookingsClickedEvent);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
