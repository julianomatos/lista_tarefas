// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:lista_compras/task_manager.dart';
import 'create_task.dart';
import 'edit_task.dart';
import 'models/task.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Main(),
    );
  }
}



class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  TaskManager taskManager = TaskManager();
  List<Task> tasks = [];

  void adicionarTarefa(Task task) {
  setState(() {
    tasks.add(task);
  });
 
 }
 void atualizarTarefa(Task updatedTask, int index) {
  setState(() {
    tasks[index] = updatedTask;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: ListView.builder(
  itemCount: tasks.length,
  itemBuilder: (context, index) {
    final task = tasks[index];
    return ListTile(
      title: Text(task.nome),
      subtitle: Text(task.dataHora.toString()),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            tasks.removeAt(index);
          });
        },
      ),
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditTask(
              task: task, 
              index: index, 
              callback: atualizarTarefa,),
          ),
        );
        if (result != null && result is Map) {
          final updatedTask = result['task'] as Task;
          final updatedIndex = result['index'] as int;
          setState(() {
            tasks[updatedIndex] = updatedTask;
          });
        }
      },
    );
  },
),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Abra a tela de criação de tarefa
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTask(callback: adicionarTarefa,)),
          );
        },
      ),
    );
  }
}
