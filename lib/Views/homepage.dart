import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'folder.dart';
import 'inbox.dart';
import 'today.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  TodoListScreenState createState() => TodoListScreenState();
}

class TodoListScreenState extends State<TodoListScreen> {
  List<String> tasks = [];
  int _selectedIndex = 0;
  List<Widget> pages = [TodayWidget(),InboxWidget(),BrowserWidget()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo App',
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body:
      pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Folder',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
