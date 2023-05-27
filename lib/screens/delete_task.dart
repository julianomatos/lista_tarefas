// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/footer.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import 'package:geocoding/geocoding.dart';

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
          body: Card(
            elevation: 10,
            margin: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: SizedBox(
              // margin: EdgeInsetsDirectional.all(10),
              // padding: EdgeInsets.all(20),
              
              // decoration: BoxDecoration(
              //   border: Border.all(
              //     color: Colors.blue, // Cor da borda
              //     width: 2.0,
              //   ),
              //   borderRadius: BorderRadius.circular(10),
              // ),
              height: 150,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
          bottomNavigationBar: Footer(),
        );
      },
    );
  }
}
