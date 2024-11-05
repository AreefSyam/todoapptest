import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Controllers/Providers/task_provider.dart';
import 'Views/homepage.dart';

// ignore: prefer_const_constructors
void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ((context) => Tasks())),
          //ChangeNotifierProvider(create: ((context) => Tasks())),
        ],
        child: MaterialApp(

          
            title: 'Simple Todo App',
            home: const TodoListScreen(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.blue,
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.blue,
                ))));
  }

  
}
