// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class DeleteTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;
    String name = "";
    String date = "";
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        if (taskProvider.tasks.isNotEmpty) {
          Task task = taskProvider.showTask(index);
          name = task.name;
          date = task.date.toString().substring(0, 10);
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Deletar Tarefa'),
          ),
          body: Container(
            margin: EdgeInsetsDirectional.all(50),
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue, // Cor da borda
                width: 2.0,
                // Espessura da borda
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 120,
            child: Center(
              child: Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    date,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Exclusão'),
                  content: Text('Tem certeza que deseja excluir? '),
                  actions: [
                    TextButton(
                      child: Text('SIM'),
                      onPressed: () {
                        taskProvider.deleteTask(index);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: Text('Não'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
            //Navigator.pop(context);
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
