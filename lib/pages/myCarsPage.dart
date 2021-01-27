import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ger_garage/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:ger_garage/database/car_model.dart';
import 'package:ger_garage/database/gears_db.dart';
import 'package:ger_garage/styles/colors.dart';
import 'package:ger_garage/widgetTempls.dart';

class MyCars extends StatefulWidget with NavigationStates {

  @override
  _MyCarsState createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  List<Car> myCars = [];

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 45,
            vertical: 90,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('My  Cars',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              Icon(CupertinoIcons.car_detailed, size: 60, color: Color(orangeSoda)),
              SizedBox(height: 25),
              Container(
                alignment: Alignment.center,
                decoration: boxDecorationStyle,
                // padding: EdgeInsets.symmetric(vertical: 10),
                height: 580,
                child: ListView.builder(
                    itemCount: myCars.length,
                    itemBuilder: (cont, i) => _createItem(i),
                ),
              ),
            ],
          ),
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

  _loadData() async {
    List<Car> dbCars = await allCars();
    setState(() {
      myCars = dbCars;
    });
  }

  _createItem(int i) {
    return Dismissible(
      key: Key(i.toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.redAccent,
        padding: EdgeInsets.only(left: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      onDismissed: (direction) {
        print('item deleted: $i');
        deleteCar(myCars[i].id);
      },
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 10, bottom: 10),
        title: Text(myCars[i].vMake,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
              fontSize: 20),),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(myCars[i].vModel,
                  style: TextStyle(color: Colors.white60, fontWeight: FontWeight.w600,
                      fontSize: 18),),
                Text(myCars[i].vYear,
                  style: TextStyle(color: Colors.white60, fontWeight: FontWeight.w600,
                      fontSize: 18),),
                SizedBox(width: 8)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(myCars[i].vType,
                  style: TextStyle(color: Colors.white60, fontWeight: FontWeight.w600,
                      fontSize: 16),),
                Text(myCars[i].vFuelTp,
                  style: TextStyle(color: Colors.white60, fontWeight: FontWeight.w600,
                      fontSize: 16),),
                Text(myCars[i].vLPlate,
                  style: TextStyle(color: Colors.white60, fontWeight: FontWeight.w600,
                      fontSize: 16),),
              ],
            ),
          ],
        ),
        trailing: MaterialButton(
          minWidth: 20,
            onPressed: () {
              BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.AddNewCarClickedEvent);
            },
            child: Icon(Icons.edit, color: Color(orangeIcons),)),
      ),
    );
  }

  
}
