import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ger_garage/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:ger_garage/database/booking_model.dart';
import 'package:ger_garage/database/gears_db.dart';
import 'package:ger_garage/styles/colors.dart';

class MyBookings extends StatefulWidget with NavigationStates {

  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  List<Booking> myBookings = [];

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
              Text(' Bookings ',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.event, size: 60, color: Color(orangeSoda)),
              SizedBox(height: 25),
              Container(
                alignment: Alignment.center,
                decoration: boxDecorationStyle,
                // padding: EdgeInsets.symmetric(vertical: 10),
                height: 420,
                child: ListView.builder(
                  itemCount: myBookings.length,
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
          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyBookingClickedEvent);
        },
      ),
    );

  }

  _loadData() async {
    List<Booking> dbBkns = await allBkns();
    setState(() {
      myBookings = dbBkns;
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
        deleteBkn(myBookings[i].id);
      },
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 10, bottom: 10),
        title: Text(myBookings[i].bName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
              fontSize: 20),),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(myBookings[i].bPhone,
              style: TextStyle(color: Colors.white60, fontWeight: FontWeight.w600,
                  fontSize: 16),),
            Text(myBookings[i].bEmail,
              style: TextStyle(color: Colors.white60, fontWeight: FontWeight.w600,
                  fontSize: 16),),
            Text(myBookings[i].bDate,
              style: TextStyle(color: Colors.white60, fontWeight: FontWeight.w600,
                  fontSize: 18),),
            Text(myBookings[i].bServTp,
              style: TextStyle(color: Colors.white60, fontWeight: FontWeight.w600,
                  fontSize: 16),),
            Text(myBookings[i].bComment,
              style: TextStyle(color: Colors.white60, fontWeight: FontWeight.w600,
                  fontSize: 16),),
          ],
        ),
        trailing: MaterialButton(
            minWidth: 20,
            onPressed: () {
              updateBkn(myBookings[i]);
              BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyBookingClickedEvent);
            },
            child: Icon(Icons.edit, color: Color(orangeIcons),)),
      ),
    );
  }

}