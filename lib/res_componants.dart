import 'package:flutter/material.dart';

Widget defualtFormFeild(
        {required TextEditingController controller,
        required TextInputType keyboardType,
        Function? validate,
        required String label,
        bool isPassword = false,
        Function? onTap,
        IconData? suffix,
        Function? suffixPressed,
        required IconData prefix}) =>
    TextFormField(
      onTap: () {
        onTap!();
      },
      obscureText: isPassword,
      validator: (v) {
        return validate!(v);
      },
      controller: controller,
      onFieldSubmitted: ((value) => print(value)),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(suffix))
            : null,
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefix),
      ),
    );

Widget buildTaskItem(Map model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text('${model['time']}'),
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisSize: MainAxisSize.min,
            children:  [
              Text(
                '${model['title']}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
               Text(
                '${model['date']}',
                style: const TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
