
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ger_garage/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:ger_garage/database/car_model.dart';
import 'package:ger_garage/database/gears_db.dart';
import 'package:ger_garage/styles/colors.dart';
import 'package:ger_garage/widgetTempls.dart';
import 'package:ger_garage/services/firebase/firebase_auth_srvc.dart';


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
      appBar: AppBar(
        backgroundColor: Color(azureBlue),
        title: IconButton(icon: Icon(Icons.arrow_back_rounded), iconSize: 30,
        onPressed: () {
          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyCarsClickedEvent);
        },),
        elevation: 0,
        // leading:,
      ),
      body: Container(
        //height: double.infinity,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 45.0,
            vertical: 15.0,
          ),
          child: Form(
            key: _ncFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Add New Car',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
                SizedBox(height: 10),
                Icon(Icons.car_repair,
                  size: 60, color: Color(orangeSoda),),
                SizedBox(height: 20),
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
                      'BMW',
                      'Nissan',
                      'Toyota',
                      'Tesla'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                  ),
                ),
                buildTextF(_tFvMdContrllr, TextInputType.text, false,
                    'Vehicle model', Icons.directions_car, 'Enter the vehicle model'),
                buildTextF(_tFvYContrllr, TextInputType.number, false,
                    'Vehicle year', Icons.calendar_today, 'Enter the vehicle year'),
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
                buildTextF(_tFvLContrllr, TextInputType.text, false,
                    'License Plate #', Icons.featured_play_list, 'Enter the License plate number'),
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
                    child: Text( 'SAVE',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    onPressed: () {
                      if(_ncFormKey.currentState.validate()) {
                        print("validado: "+ _tFvMdContrllr.text+" "+_vehMake );
                        insertCar(Car(vType: _vehType, vMake: _vehMake,
                            vModel: _tFvMdContrllr.text, vYear: _tFvYContrllr.text,
                            vFuelTp: _vehFuel, vLPlate: _tFvLContrllr.text));
                        FirebaseAuthService.mySnackBar(context, 'A new car saved');
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.MyCarsClickedEvent);
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

