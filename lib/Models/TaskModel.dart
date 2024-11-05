// ignore_for_file: file_names

class TaskModel {
  final String taskName;
  final TaskCategory taskCategory;

  TaskModel({
    required this.taskName,
    required this.taskCategory,
  });
}

enum TaskCategory {
  inbox,
  folder1,
  folder2;

  String get taskCategory {
    switch (this) {
      case TaskCategory.inbox:
        return 'Inbox';
      case TaskCategory.folder1:
        return 'Folder 1';
      case TaskCategory.folder2:
        return 'Folder 2';
    }
  }
}
