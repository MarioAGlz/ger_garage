import 'dart:async';

// import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ger_garage/bloc/navigation_bloc/navigation_bloc.dart';
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
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 45.0,
            vertical: 90.0,
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
                buildTextF(_tFuNContrll, TextInputType.name, 'Name',
                    Icons.person, 'Enter your name'),
                buildTextF(_tFuMContrll, TextInputType.emailAddress, 'Email',
                    Icons.email, 'Enter your e-mail'),
                buildTextF(_tFuPContrll, TextInputType.phone, 'Phone number',
                    Icons.phone, 'Enter your phone number'),
                SizedBox(
                  height: 20,
                ),
                /*Container(
                  alignment: Alignment.center,
                  decoration: boxDecorationStyle,
                  height: 60.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.directions_car,
                          size: 30, color: Color(orangeIcons)),
                      DropdownButton<String>(
                        value: _vehType,
                        icon: Icon(Icons.arrow_drop_down,
                            color: Color(orangeIcons)),
                        iconSize: 45,
                        elevation: 16,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w400),
                        dropdownColor: Color(gunmetal),
                   // isExpanded: true,
                        underline:
                            Container(height: 0.3, color: Color(orangeIcons)),
                        onChanged: (newValue) =>
                            setState(() => _vehType = newValue),
                        items: <String>[
                          'Vehicle type',
                          'Car',
                          'Motorbike',
                          'Van',
                          'Small Bus'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                buildDropDw(
                  Icon(Icons.branding_watermark,
                      size: 30, color: Color(orangeIcons)),
                  DropdownButton<String>(
                    value: _vehMake,
                    icon:
                        Icon(Icons.arrow_drop_down, color: Color(orangeIcons)),
                    iconSize: 45,
                    elevation: 16,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w400),
                    dropdownColor: Color(gunmetal),
//                    isExpanded: true,
                    underline:
                        Container(height: 0.3, color: Color(orangeIcons)),
                    onChanged: (newValue) =>
                        setState(() => _vehMake = newValue),
                    items: <String>[
                      'Vehicle make',
                      'Audi',
                      'Mercedes',
                      'VW',
                      'Smart',
                      'Nissan',
                      'Toyota'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                  ),
                ),
                buildTextF(_tFvMContrll, TextInputType.text, 'Vehicle model',
                    Icons.directions_car, 'Enter the vehicle model'),
                buildTextF(_tFvYContrll, TextInputType.number, 'Vehicle year',
                    Icons.calendar_today, 'Enter the vehicle year'),
                buildDropDw(
                  Icon(Icons.battery_charging_full,
                      size: 30, color: Color(orangeIcons)),
                  DropdownButton<String>(
                    value: _vehFuel,
                    icon:
                    Icon(Icons.arrow_drop_down, color: Color(orangeIcons)),
                    iconSize: 45,
                    elevation: 16,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w400, ),
                    dropdownColor: Color(gunmetal),
//                    isExpanded: true,
                    underline:
                    Container(height: 0.3, color: Color(orangeIcons)),
                    onChanged: (newValue) =>
                        setState(() => _vehFuel = newValue),
                    items: <String>[
                      'Fuel type',
                      'Petrol',
                      'Diesel',
                      'Electric',
                      'Hybrid'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                  ),
                ),
                buildTextF(_tFvLContrll, TextInputType.text, 'License Plate #',
                    Icons.featured_play_list, 'Enter the License plate number'),*/
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
                /*DateTimePicker(
                  controller: _tFtDContrll,
                  type: DateTimePickerType.date,
                  initialValue: '',
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2050),
                  dateLabelText: 'Date',

                ),*/
                buildTextF(_tFuCContrll, TextInputType.text, 'User comments',
                    Icons.comment, 'Enter comments'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
