import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/archived_screen.dart';
import 'package:todo_app/done_screen.dart';
import 'package:todo_app/home/cubit/states.dart';
import 'package:todo_app/tasks_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  dynamic context = BuildContext;
  int currentIndex = 0;
  Database? database;
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  List<Map> tasks = [];

  List<Widget> screens = [
    TasksScreen(),
    const DoneScreen(),
    const ArchivedScreen(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        // id integer
        // title String
        // date String
        // time String
        // status String

        print('database created');
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)').then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database).then((value) {
          tasks = value;
          print(tasks);
        });
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
      print(database);
    });
  }

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    database != null?
      await database!.transaction((txn) {
        return txn
            .rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")',
        )
            .then((value) {
          print('$value inserted successfully');
          emit(AppInsertState());
          Navigator.of(context).pop();

          getDataFromDatabase(database).then((value) {
            tasks = value;
            print(tasks);
            emit(AppGetDatabaseState());
          });
        }).catchError((error) {
          print('Error When Inserting New Record ${error.toString()}');
        });
        // return null;
      }):print('database is empty $database');
    } 

    Future<List<Map>> getDataFromDatabase(database) async {
      return await database.rawQuery('SELECT * FROM tasks');
    }

    void chngeBottomSheetState({required bool isShow, required IconData icon}) {
      isBottomSheetShown = isShow;
      fabIcon = icon;
      emit(AppChangeBottomSheetState());
    }
  }

