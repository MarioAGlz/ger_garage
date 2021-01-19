import 'package:bloc/bloc.dart';
import 'package:ger_garage/pages/homePage.dart';
import 'package:ger_garage/pages/loginPage.dart';
import 'package:ger_garage/pages/myCarsPage.dart';
import 'package:ger_garage/pages/bookingPage.dart';
import 'package:ger_garage/pages/newCarPage.dart';
import 'package:ger_garage/pages/signUpPage.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyCarsClickedEvent,
  AddNewCarClickedEvent,
  MyBookingClickedEvent,
  LoginClickedEvent,
  LogoutClickedEvent,
  SigUpClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  // TODO: implement initialState
  NavigationStates get initialState => HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    // TODO: implement mapEventToState
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.MyCarsClickedEvent:
        yield MyCars();
        break;
      case NavigationEvents.AddNewCarClickedEvent:
        yield AddNewCar();
        break;
      case NavigationEvents.MyBookingClickedEvent:
        yield Bookings();
        break;
      case NavigationEvents.LoginClickedEvent:
        yield LoginPage();
        break;
      case NavigationEvents.SigUpClickedEvent:
        yield SignUpPage();
        break;
    }
  }
}

class Login {
}
