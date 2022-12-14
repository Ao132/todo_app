import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/data/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/network/remote/dio_helper.dart';
import 'package:todo_app/presentation/view/news_app/news_layout.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(type: BottomNavigationBarType.fixed, selectedItemColor: Colors.deepOrange),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
            elevation: 0,
            color: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarBrightness: Brightness.dark)),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(scaffoldBackgroundColor: Colors.pink),
      home: const NewsLayout(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
