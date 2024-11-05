import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Models/taskModel.dart';
import '../Controllers/Providers/task_provider.dart';

// ignore: must_be_immutable
class TodayWidget extends StatefulWidget {
  TodayWidget({super.key});

  @override
  State<TodayWidget> createState() => _TodayWidgetState();
}

class _TodayWidgetState extends State<TodayWidget> {
  TextEditingController controller = TextEditingController();
  TaskCategory category = TaskCategory.inbox;

  void _addTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Task'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Add your task',
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
          MaterialButton(
            child: const Text('Add'),
            onPressed: () {
              TaskModel newTask =
                  TaskModel(taskName: controller.text, taskCategory: category);
              if (controller.text.isNotEmpty) {
                context.read<Tasks>().addTaskModel(newTask);
                controller.clear();
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

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
        List<TaskModel> obj = value.userTask;

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => _addTask(context),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: obj.length,
                    itemBuilder: (context, index) {
                      TaskModel currentTaskModel = obj[index];

                      return Container(
                        padding: const EdgeInsets.all(2.0),
                        margin: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: ListTile(
                          title: Row(
                            children: [
                              Checkbox(
                                  value: false,
                                  onChanged: (value) => context
                                      .read<Tasks>()
                                      .deleteTaskModel(index)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentTaskModel.taskName,
                                    style: GoogleFonts.roboto(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.pink,
                                    ),
                                  ),
                                  displayColouredFolder(currentTaskModel)
                                ],
                              ),
                            ],
                          ),
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
                                          leading: const Icon(Icons.edit),
                                          title: const Text('Edit'),
                                          onTap: () {
                                            String currentTaskInput = "";
                                            setState(() {
                                              controller.text =
                                                  currentTaskModel.taskName;
                                              currentTaskInput =
                                                  controller.text;
                                            });
                                            final editTaskModel = TaskModel(
                                                taskName: currentTaskInput,
                                                taskCategory: currentTaskModel
                                                    .taskCategory);
                                            _changeTask(
                                                context, index, editTaskModel);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }),
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget displayColouredFolder(TaskModel currentTaskModel) {
    Text text2 = const Text("");
    // ignore: unrelated_type_equality_checks
    if (currentTaskModel.taskCategory == TaskCategory.folder2) {
      //return currentTaskModel.taskCategory.toString();
      text2 = Text("Folder 2",
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.displayMedium,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.green,
          ));
      // ignore: unrelated_type_equality_checks
    } else if (currentTaskModel.taskCategory == TaskCategory.folder1) {
      //return currentTaskModel.taskCategory.toString();
      text2 = Text("Folder 1",
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.displayMedium,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.deepPurple,
          ));
    } else {
      text2 = Text("Inbox",
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.displayMedium,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ));
    }
    return text2;
  }
}
