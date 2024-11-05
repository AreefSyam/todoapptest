import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Controllers/Providers/task_provider.dart';
import '../Models/taskModel.dart';

class InboxWidget extends StatefulWidget {
  const InboxWidget({super.key});

  @override
  State<InboxWidget> createState() => _InboxWidgetState();
}

class _InboxWidgetState extends State<InboxWidget> {
  TextEditingController controller = TextEditingController();
  TaskCategory category = TaskCategory.inbox;

  void _changeTask(
      BuildContext context, int index, TaskModel currentTaskModel) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Edit current Task'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Add your new task',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                PopupMenuButton<TaskCategory>(
                  icon: const Icon(Icons.folder),
                  initialValue: TaskCategory.inbox,
                  onSelected: (TaskCategory value) {
                    setState(() {
                      category = value;
                    });
                  },
                  itemBuilder: (context) => [
                    // popUpMenu item 1
                    const PopupMenuItem(
                      value: TaskCategory.inbox,
                      child: Row(
                        children: [
                          Icon(Icons.inbox),
                          SizedBox(
                            // sized box with width 10
                            width: 10,
                          ),
                          Text("Inbox"),
                        ],
                      ),
                    ),
                    // popUpMenu item 2
                    const PopupMenuItem(
                      value: TaskCategory.folder1,
                      child: Row(
                        children: [
                          Icon(Icons.folder),
                          SizedBox(
                            // sized box with width 10
                            width: 10,
                          ),
                          Text("My Folder 1")
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: TaskCategory.folder2,
                      // row has two child icon and text
                      child: Row(
                        children: [
                          Icon(Icons.folder),
                          SizedBox(
                            // sized box with width 10
                            width: 10,
                          ),
                          Text("My Folder 2")
                        ],
                      ),
                    ),
                  ],
                  offset: const Offset(0, 100),
                  color: Colors.grey,
                  elevation: 2,
                ),
              ],
            ),
            actions: <Widget>[
              Row(
                children: [
                  MaterialButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        controller.clear();
                        Navigator.of(context).pop();
                      }),
                  MaterialButton(
                    child: const Text('Save'),
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        TaskModel newTask = TaskModel(
                            taskName: controller.text,
                            //taskCategory: currentTaskModel.taskCategory);
                            //change the category of task
                            taskCategory: category);
                        context.read<Tasks>().editTaskModel(index, newTask);
                        controller.clear();
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Tasks>(
      builder: (context, value, child) {
        // to filter inbox only
        final inboxTasks = value.userTask
            .where((task) => task.taskCategory == TaskCategory.inbox)
            .toList();

        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: inboxTasks.isEmpty
                    ? const Center(
                        child: Text(
                        'No Inbox Tasks',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      )) // Display empty message
                    : ListView.builder(
                        itemCount: inboxTasks.length,
                        itemBuilder: (context, index) {
                          final currentTaskModel = inboxTasks[index];
                          return Column(
                            children: [
                              const SizedBox(
                                  child: Text("Inbox",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold))),
                              Container(
                                padding: const EdgeInsets.all(2.0),
                                margin: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)),
                                ),
                                child: ListTile(
                                  title:
                                      display(currentTaskModel, context, index),
                                  trailing: IconButton(
                                      icon: const Icon(Icons.more_vert),
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Wrap(
                                              children: [
                                                const ListTile(
                                                  leading: Icon(Icons.share),
                                                  title: Text('Share'),
                                                ),
                                                ListTile(
                                                  leading:
                                                      const Icon(Icons.edit),
                                                  title: const Text('Edit'),
                                                  onTap: () {
                                                    String currentTaskInput =
                                                        "";
                                                    setState(() {
                                                      controller.text =
                                                          currentTaskModel
                                                              .taskName;
                                                      currentTaskInput =
                                                          controller.text;
                                                    });
                                                    final editTaskModel =
                                                        TaskModel(
                                                            taskName:
                                                                currentTaskInput,
                                                            //input,
                                                            taskCategory:
                                                                currentTaskModel
                                                                    .taskCategory);
                                                    _changeTask(context, index,
                                                        editTaskModel);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget display(TaskModel currentTaskModel, BuildContext context, int index) {
  return Row(
    children: [
      Checkbox(
        value: false,
        onChanged: (value) => context.read<Tasks>().deleteTaskModel(index),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentTaskModel.taskName,
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.displayMedium,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.pink,
            ),
          ),
          Text(
            DisplayFolder(currentTaskModel),
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.displayMedium,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ],
  );
}

// ignore: non_constant_identifier_names
String DisplayFolder(TaskModel currentTaskModel) {
  // ignore: unrelated_type_equality_checks
  if (currentTaskModel.taskCategory == TaskCategory.folder2) {
    //return currentTaskModel.taskCategory.toString();
    return "Folder 2";

    // ignore: unrelated_type_equality_checks
  } else if (currentTaskModel.taskCategory == TaskCategory.folder1) {
    //return currentTaskModel.taskCategory.toString();
    return "Folder 1";
  } else {
    return "Inbox";
  }
}
