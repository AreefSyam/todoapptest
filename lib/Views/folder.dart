import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/taskModel.dart';
import '../Controllers/Providers/task_provider.dart';

class BrowserWidget extends StatefulWidget {
  const BrowserWidget({super.key});

  @override
  State<BrowserWidget> createState() => _BrowserWidgetState();
}

class _BrowserWidgetState extends State<BrowserWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Tasks>(
      builder: (context, value, child) {
        List<TaskModel> obj = value.userTask;

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Folder',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Container(
                  //margin: const EdgeInsets.all(10),
                  //padding: const EdgeInsets.all(10),
                  child: displayAllFolder(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget displayAllFolder() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Column(
        children: [
          Icon(Icons.folder, size: 80, color: Colors.black, shadows: <Shadow>[
            Shadow(color: Colors.black, blurRadius: 5.0, offset: Offset(5, 5))
          ]),
          Text('Inbox', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      Column(
        children: [
          Icon(Icons.folder,
              size: 80,
              color: Colors.deepPurple,
              shadows: <Shadow>[
                Shadow(
                    color: Colors.black, blurRadius: 5.0, offset: Offset(5, 5))
              ]),
          Text('Folder 1', style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
      Column(
        children: [
          Icon(
            Icons.folder,
            size: 80,
            color: Colors.green,
            shadows: <Shadow>[
              Shadow(color: Colors.black, blurRadius: 5.0, offset: Offset(5, 5))
            ],
          ),
          Text('Folder 2', style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    ],
  );
}
