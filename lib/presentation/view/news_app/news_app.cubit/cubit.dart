import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/presentation/view/busniess/busniess_screen.dart';
import 'package:todo_app/presentation/view/news_app/news_app.cubit/states.dart';
import 'package:todo_app/presentation/view/science/science_screen.dart';
import 'package:todo_app/presentation/view/settings_screen/settings.dart';
import 'package:todo_app/presentation/view/sports/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings'),
  ];
  List<Widget> Screens = [BusniessScreen(), SportsScreen(), ScienceScreen(),SettingsScreen()];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }
}
