import 'package:bloc/bloc.dart';
import 'package:sidebar_techbolossom/Pages/homePage.dart';
import 'package:sidebar_techbolossom/Pages/myAccount.dart';
import 'package:sidebar_techbolossom/Pages/myOrders.dart';

enum NavigationEvents{ HomePageClickedEvent, MyAccountClickedEvent, MyOrdersClickedEvent}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates>{
  @override
  get initialState => HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async*{
    switch(event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.MyAccountClickedEvent:
      yield MyAccount();
      break;
      case NavigationEvents.MyOrdersClickedEvent:
      yield MyOrders();
      break;
    }
  }

}