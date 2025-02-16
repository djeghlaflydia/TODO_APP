import 'package:hive/hive.dart';

class ToDoDataBase {
  List toDoList = [];

  // Reference our box
  late Box _mybox;

  // Initialize the box
  void initBox(Box box) {
    _mybox = box;
  }

  // Run this method if this is the 1st time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Learning flutter", false],
      ["Make a todo App", false],
      ["Make a Ecommerce AppUI", false],
    ];
    _mybox.put("TODOLIST", toDoList);
  }

  // Load the data from database
  void loadData() {
    toDoList = _mybox.get("TODOLIST", defaultValue: []);
  }

  // Update the database
  void updateDataBase() {
    _mybox.put("TODOLIST", toDoList);
  }
}
