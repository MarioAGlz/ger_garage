
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:ger_garage/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:ger_garage/styles/colors.dart';
import 'package:ger_garage/widgetTempls.dart';


// ignore: must_be_immutable
class AddNewCar extends StatefulWidget with NavigationStates {
  @override
  _AddNewCarState createState() => _AddNewCarState();
}

class _AddNewCarState extends State<AddNewCar> {

  String _vehType = 'Vehicle type';
  String _vehMake = 'Vehicle make';
  String _vehModel = 'Vehicle Model';
  int _vehYear = 0;
  String _vehFuel = 'Fuel type';
  String _vehLicense = 'License Number';
  String _vehEngine = '';

  TextEditingController _tFvTContrllr = TextEditingController();
  TextEditingController _tFvMkContrllr = TextEditingController();
  TextEditingController _tFvMdContrllr = TextEditingController();
  TextEditingController _tFvYContrllr = TextEditingController();
  TextEditingController _tFvFContrllr = TextEditingController();
  TextEditingController _tFvLContrllr = TextEditingController();
  final _ncFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        //height: double.infinity,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 45.0,
            vertical: 100.0,
          ),
          child: Form(
            key: _ncFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Add New Car',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),),
                SizedBox(height: 10),
                Icon(Icons.car_repair,
                  size: 60, color: Color(orangeSoda),),
                SizedBox(height: 20,),
                Container(
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
                buildTextF(_tFvMdContrllr, TextInputType.text, 'Vehicle model',
                    Icons.directions_car, 'Enter the vehicle model'),
                buildTextF(_tFvYContrllr, TextInputType.number, 'Vehicle year',
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
                buildTextF(_tFvLContrllr, TextInputType.text, 'License Plate #',
                    Icons.featured_play_list, 'Enter the License plate number'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
