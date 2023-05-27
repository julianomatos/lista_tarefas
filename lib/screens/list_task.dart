// ignore_for_file: prefer_const_constructors, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lista_compras/routes/routes_path.dart';
import '../components/footer.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import 'create_task.dart';
import 'edit_task.dart';
import '../utils/data_utils.dart';
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
              return Card(
                elevation: 8,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: ListTile(
                  title: Text(task.name),
                  //title: Text(getLocation() as String),
                  // subtitle: Text(task.date.toString().substring(0, 10)),
                  subtitle: Text(DataUtils.formatDate(task.date)),
                  // '${widget.transaction.date.day.toString().padLeft(2, '0')}/${widget.transaction.date.month.toString().padLeft(2, '0')}/${widget.transaction.date.year.toString()}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        // color: Colors.black87,
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
                        // color: Colors.amberAccent,
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
          bottomNavigationBar: Footer(),
        );
      },
    );
  }

  // Future<String> getLocation() async {
  //   List<Location> locations =
  //       await locationFromAddress("Rua Dionel Ferro, 415");
  //   return locations[0].latitude.toString();
  // }
}
