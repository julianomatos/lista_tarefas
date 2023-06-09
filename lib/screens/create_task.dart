// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api, use_key_in_widget_constructors, unused_import, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:lista_compras/providers/task_provider.dart';
import '../components/footer.dart';
import '../models/task.dart';
import 'package:provider/provider.dart';
import '../utils/data_utils.dart';

// import 'package:geocoding/geocoding.dart';

class CreateTask extends StatelessWidget {
  DateTime? selectedDateTime;
  // TimeOfDay? selectedTime;
  final _date = TextEditingController();
  final _name = TextEditingController();
  final _location = TextEditingController();
  // @override
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Criar Tarefa'),
          ),
          body:
              // Padding(
              //   padding: EdgeInsets.all(20),
              // child:
              Column(
            children: [
              Card(
                elevation: 8,
                child: ListTile(
                  title: TextField(
                    style: TextStyle(fontSize: 18),
                    controller: _name,
                    decoration: InputDecoration(
                      labelText: 'Nome da Tarefa',
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 16.0),
              //  Row(
              //   children: [
              //     Expanded(
              //       child:
              Card(
                elevation: 8,
                child: ListTile(
                  // 0minLeadingWidth: 0,
                  title: TextField(
                    enabled: false,
                    controller: _date,
                    decoration: const InputDecoration(
                      labelText: "Data da tarefa",
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit_calendar),
                    iconSize: 32,
                    color: Colors.black87,
                    onPressed: () async {
                      
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021),
                        lastDate: DateTime(2024),
                      );
                      final selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now());
                      if (selectedDate != null && selectedTime != null) {
                        selectedDateTime = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            selectedTime.hour,
                            selectedTime.minute,
                          );
                        _date.text = DataUtils.formatDate(selectedDateTime!);
                      }
                    },
                  ),
                ),
              ),
              // ),
              SizedBox(height: 16.0), //Criando espaço entre os campos.

              Card(
                elevation: 8,
                child: ListTile(
                  title: TextField(
                    enabled: false,
                    controller: _location,
                    decoration: const InputDecoration(
                      labelText: "Localização",
                    ),
                  ),
                  trailing: IconButton(
                    // style: ElevatedButton.styleFrom(
                    //   minimumSize: Size(double.infinity, 40),
                    // ),
                    iconSize: 32,
                    color: Colors.black87,
                    icon: Icon(Icons.location_on),
                    onPressed: () async {
                      final currentPosition = await DataUtils.getLocation();
                      _location.text = currentPosition;
                    },
                  ),
                ),
              ),
            ],
            // ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.save),
            onPressed: () {
              if (_name.text.isNotEmpty &&
                  _date.text.isNotEmpty &&
                  _location.text.isNotEmpty) {
                final task = Task(
                  name: _name.text,
                  date: selectedDateTime!,
                  location: _location.text,
                );

                taskProvider.addTask(task);
                Navigator.pop(context);
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Erro'),
                    content: Text('Por favor, preencha todos os campos.'),
                    actions: [
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          bottomNavigationBar: Footer(),
        );
      },
    );
  }
}
