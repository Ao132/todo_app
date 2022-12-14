import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/network/remote/dio_helper.dart';
import 'package:todo_app/presentation/view/news_app/news_app.cubit/cubit.dart';
import 'package:todo_app/presentation/view/news_app/news_app.cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: ((BuildContext context) => NewsCubit()),
        child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: ((context, state) {
            NewsCubit cubit = NewsCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: const Text('News App'),
                actions: [Icon(Icons.search)],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  DioHelper.getData(url: 'v2/top-headlines', query: {
                    'country': 'eg',
                    'category': 'business',
                    'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
                  }).then((value) {
                    print(value.data.toString());
                    log('affff');
                  }).catchError((error) {
                    print(error.toString());
                  });
                },
                child: Icon(Icons.add),
              ),
              body: cubit.Screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                items: cubit.bottomItems,
                onTap: (index) {
                  cubit.changeBottomNavBar(index);
                },
              ),
            );
          }),
        ));
  }
}
