import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ger_garage/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:ger_garage/styles/colors.dart';

class HomePage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 60.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 180.0,
                      width: 270.0,
                      constraints: BoxConstraints.expand(height: 200),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/logos/ger_garage_ss.png'),
                        ),
                      ),
                    ),
                    Text(
                      "Ger's Garage",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 32,
                        fontStyle: FontStyle.italic,
//                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Mechanical Repairs & Service Center',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: Color(dazzledBlue),
                      ),
                    ),
                    _boxImage('assets/cars/bmw-3s.png'),
                    SizedBox(height: 10),
                    Text(
                      'Our Services:',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(dazzledBlue),
                      ),
                    ),
                    _serviceCards(Color(0xFFEAE2B7), Icons.build, Colors.blueAccent, Color(gunmetal), 'Full Service',
                        'Full Service is an engine oil, oil filter, air filter and fuel filter replacement. '
                        'Removal of wheels x 4. Check brakes, steering, suspension and under-body.'),
                    _serviceCards(Color(0xFFFCBF49), Icons.directions_car, Colors.blue, Color(gunmetal), 'Intermediate Service',
                        'Intermediate Service is an engine oil, oil filter & air filter replacement. '
                        'Rotate wheels if necessary. Reset service message on dashboard.'),
                    _serviceCards(Color(0xFFF77F00), Icons.adjust, Color(0xFF003049), Colors.white, 'Brakes & Suspension',
                        'Check brakes, steering, suspension and under-body. Clean & adjust rear brakes and handbrake. '
                            'Rotate wheels if necessary. Check tyres, tyre pressures'),
                    _boxImage('assets/cars/audi-A4.png'),
                    SizedBox(height: 10,),
                    _serviceCards(Color(0xFFD62828), Icons.format_list_bulleted, Colors.lightGreenAccent, Colors.white, 'Pre NCT Test & Repairs',
                        'Pre-NCT check. We are equipped with all the necessary vehicle testing equipment to ensure your car will be '
                            'ready to pass the test. Or NCT Repairs, failure certificate is required.'),
                    _serviceCards(Color(0xFF003049), Icons.settings, Color(0xFFEAE2B7), Colors.white, 'Clutch & Gearbox',
                        'Clutches, gearboxes, drive-trains in general are a very specialized area in which we are very '
                            'experienced and very competitive.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _serviceCards(Color _boxColor, IconData _icon, Color _iconColor, Color _textColor, String _title, String _descr) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      margin: EdgeInsets.only(top: 10, bottom: 15),
      height: 200,
      width: double.infinity,
//                constraints: BoxConstraints.expand(height: 500),
      decoration: BoxDecoration(
        color: _boxColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Color(carolBlue).withOpacity(0.8),
              blurRadius: 7,
              offset: Offset(3, 3)),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Icon(
            _icon,
            size: 35,
            color: _iconColor,
          ),
          Text(
            _title,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: _textColor),
          ),
          SizedBox(height: 20),
          Text(
            _descr,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: _textColor),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _boxImage(String _pathImg) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 140,
      width: double.infinity,
//                constraints: BoxConstraints.expand(height: 500),
      decoration: BoxDecoration(
//                        color: Colors.white60,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.01),
              blurRadius: 3)
        ],
      ),
      child: Image.asset(_pathImg),
    );
  }


}
