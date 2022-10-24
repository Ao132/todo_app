import 'app_states.dart';
import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/presentation/view/done_screen.dart';
import 'package:todo_app/presentation/view/tasks_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/presentation/view/archived_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  late final Database database;
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  List<Map> tasks = [];

  List<Widget> screens = [
    const TasksScreen(),
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
    var databasesPath = await getDatabasesPath();
    String path = '$databasesPath/demo.db';
    log(path);

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) async {
        log('database created');
        await database
            .execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .onError((error, stackTrace) {
          log('Error while creating tabl: $error');
          log(stackTrace.toString());
        });
        log('table created');
      },
      onOpen: (database) async {
        tasks = await getDataFromDatabase(database);
        log(tasks.toString());
      },
    );

    log('database: ${database.toString()}');
    emit(AppCreateDatabaseState());
  }

  Future<void> insertToDatabase(
    BuildContext context, {
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")',
      )
          .then((value) async {
        log('raw inserted successfully, id: $value');
        emit(AppInsertState());
        Navigator.of(context).pop();
        tasks = await getDataFromDatabase(database);
        log(tasks.toString());
        emit(AppGetDatabaseState());
      }).onError((error, stackTrace) {
        log('Error while inserting: $error');
        log(stackTrace.toString());
      });
    });
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
