import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ger_garage/bloc/navigation_bloc/navigation_bloc.dart';

class MyCars extends StatelessWidget with NavigationStates {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //height: double.infinity,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 45,
            vertical: 90,
          ),
          /*child: ListView(
            *//*child: Text(
              "My Cars",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
            ),*//*
          ),*/
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_rounded),
        onPressed: () {
          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.AddNewCarClickedEvent);
        },
      ),
    );



  }
}
