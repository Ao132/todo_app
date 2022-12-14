import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/presentation/shared%20widgets/res_componants.dart';
import 'package:todo_app/presentation/view/home/cubit/app_cubit.dart';
import 'package:todo_app/presentation/view/home/cubit/app_states.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var tasks = AppCubit.get(context).tasks;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        log("asd ${state.toString()}");
        return ListView.separated(
          itemCount: tasks.length,
          itemBuilder: ((context, index) => buildTaskItem(tasks[index],context)),
          separatorBuilder: ((context, index) => Container(width: double.infinity, height: 1, color: Colors.grey.shade300)),
        );
      },
    );
  }
}
