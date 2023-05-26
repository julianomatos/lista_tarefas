// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:lista_compras/routes/routes_path.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import 'create_task.dart';
import 'edit_task.dart';
import 'package:provider/provider.dart';

class ListTask extends StatefulWidget {
  const ListTask({super.key});

  @override
  State<ListTask> createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  @override
  Widget build(BuildContext context) {
    // TaskProvider taskProvider = TaskProvider();
    // List<Task> tasks = taskProvider.tasks;
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        List<Task> tasks = taskProvider.tasks;

        return Scaffold(
          appBar: AppBar(
            title: Text('Lista de Tarefas'),
          ),
          body: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(task.name),
                subtitle: Text(task.date.toString().substring(0, 10)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Abre a tela da edição de tarefas
                        Navigator.of(context).pushNamed(
                          RoutePaths.TASKTUPDATESCREEN,
                          arguments: index,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Abre a tela de exclusão de tarefas
                        Navigator.of(context).pushNamed(
                          RoutePaths.TASKDELETESCREEN,
                          arguments: index,
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              // Abra a tela de criação de tarefa
              Navigator.of(context).pushNamed(RoutePaths.TASKTCREATESCREEN);
            },
          ),
           bottomNavigationBar: Container(
            height: 40,
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Text('Todos os direitos reservados.'),
            ),
          ),
        );
      },
    );
  }
}
