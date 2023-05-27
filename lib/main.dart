// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:lista_compras/providers/task_provider.dart';
import 'package:lista_compras/screens/create_task.dart';
import 'package:lista_compras/screens/edit_task.dart';
import 'package:provider/provider.dart';
import 'routes/routes_path.dart';
import 'screens/delete_task.dart';
import 'screens/list_task.dart';

void main() {
  //runApp(MyApp());
  runApp(ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MyApp(),
    ));
}

class MyApp extends StatelessWidget {
//  final darkTheme = ThemeData(
//   brightness: Brightness.dark,
//   primaryColor: Colors.blueGrey[800], colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.deepPurple[400]),
// );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  //     theme: ThemeData(
  //   primaryColor: Colors.black12,
  //   secondaryHeaderColor: Colors.white,
  // ),
  theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.amber),
        //
      ),
      routes: {
        RoutePaths.HOME: (context) => ListTask(),
        RoutePaths.TASKTCREATESCREEN: (context) => CreateTask(),
        RoutePaths.TASKTUPDATESCREEN: (context) => EditTask(),
        RoutePaths.TASKDELETESCREEN: (context) => DeleteTask(),
      }
    );
  }
}

