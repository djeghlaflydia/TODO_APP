import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/database.dart';
import 'package:todo_app/dialog_box.dart';
import 'package:todo_app/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Reference the box
  late final Box _mybox; // Utilisez "late" pour initialiser plus tard
  late ToDoDataBase db; // Utilisez "late" pour initialiser plus tard

  @override
  void initState() {
    super.initState();

    // Initialiser Hive et la base de données
    _initializeHive();
  }

  // Méthode pour initialiser Hive et la base de données
  Future<void> _initializeHive() async {
    // Ouvrir la boîte Hive
    _mybox = await Hive.openBox('mybox');

    // Initialiser la base de données
    db = ToDoDataBase();
    db.initBox(_mybox); // Passer la boîte ouverte à la base de données

    // Si c'est la première fois que l'application est ouverte, créer des données par défaut
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // Sinon, charger les données existantes
      db.loadData();
    }

    // Mettre à jour l'interface utilisateur
    if (mounted) {
      setState(() {});
    }
  }

  // Text controller
  final _controller = TextEditingController();

  // Checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // Save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // Create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // Delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 229, 252),
      appBar: AppBar(
        title: const Text(
          "My Todo List",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: db.toDoList.isEmpty
          ? const Center(
              child: Text(
                "No tasks yet!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: db.toDoList.length,
              itemBuilder: (context, index) {
                return TodoTile(
                  taskName: db.toDoList[index][0],
                  taskCompleted: db.toDoList[index][1],
                  onChanged: (value) => checkBoxChanged(value, index),
                  deleteFunction: (context) => deleteTask(index),
                );
              },
            ),
    );
  }
}