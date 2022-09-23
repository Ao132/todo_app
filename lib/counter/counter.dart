import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/counter/cubit/cubit.dart';
import 'package:todo_app/counter/cubit/states.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: ((BuildContext context) => CounterCubit()),
        child: BlocConsumer<CounterCubit, CounterStates>(
          listener: ((context, state) => {}),
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Counter'),
              ),
              body: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          CounterCubit.get(context).minus();
                        },
                        child: Text('MINUS')),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '${CounterCubit.get(context).counter}',
                        style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          CounterCubit.get(context).plus();
                        },
                        child: Text('PLUS'))
                  ],
                ),
              ),
            );
          },
        ));
  }
}
