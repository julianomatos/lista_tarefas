// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:lista_compras/models/task.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class EditTask extends StatelessWidget {
  DateTime? selectedDateTime;
  final _date = TextEditingController();
  final _name = TextEditingController();
  final _location = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;

    return Consumer<TaskProvider>(builder: (context, taskProvider, _) {
      Task task = taskProvider.showTask(index);
      _name.text = task.name;
      _date.text = task.date.toString().substring(0, 10);
      selectedDateTime = task.date;
      _location.text = task.location;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Editar Tarefa'),
        ),
        body:
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child:
            Column(
          children: [
            ListTile(
              title:TextField(
                  style: const TextStyle(fontSize: 20),
                  controller: _name,
                  decoration: const InputDecoration(
                    labelText: 'Nome da Tarefa',
                  ),
                ),
            ),
            const SizedBox(height: 16.0),
            ListTile(
              title: TextField(
                enabled: false,
                controller: _date,
                decoration: const InputDecoration(
                  labelText: 'Data da Tarefa',
                ),
              ),
              trailing: IconButton(
              icon: const Icon(Icons.edit_calendar),
              iconSize: 32,
              color: Colors.black87,
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDateTime!,
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2025),
                );
                if (selectedDate != null) {
                  selectedDateTime = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                  );
                  _date.text = selectedDateTime.toString().substring(0, 10);
                }
              },
            ),
            ),
            const SizedBox(height: 16.0),
            ListTile(
                  title: TextField(
                    enabled: false,
                    controller: _location,
                    decoration: const InputDecoration(
                      labelText: "Localização",
                    ),
                  ),
                  trailing:IconButton(
                  iconSize: 32,
                  color: Colors.black87,
                  icon: const Icon(Icons.location_on),
                  onPressed: () async {
                    final currentPosition = await getLocation();
                    _location.text = currentPosition;
                  },
                ), 
                ),
            // ElevatedButton(

            //   child: const Text('Selecionar Geolocalização'),
            //   onPressed: () async {
            //     final currentPosition = await getLocation();
            //       _location.text = currentPosition;
            //   },
            // ),
            // const SizedBox(height: 16.0),
          ],
          // ),
        ),
        floatingActionButton: FloatingActionButton(
          // style: ElevatedButton.styleFrom(
          //   minimumSize: const Size(double.infinity, 50)),
          // child: const Text('Salvar Alterações'),

          child: const Icon(Icons.save),
          onPressed: () {
            if (_name.text.isNotEmpty && _location.text.isNotEmpty) {
              final updatedTask = Task(
                name: _name.text,
                date: selectedDateTime!,
                location: _location.text,
              );
              taskProvider.editTask(index, updatedTask);
              Navigator.pop(context);
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Erro'),
                  content: const Text('Por favor, preencha todos os campos.'),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
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
         bottomNavigationBar: Container(
            height: 40,
            color: Theme.of(context).primaryColor,
            child: const Center(
              child: Text('Todos os direitos reservados.'),
            ),
          ),
      );
    });
  }

  Future<String> getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) Future.value("");
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) Future.value("");
    }
    locationData = await location.getLocation();
    return "${locationData.latitude} : ${locationData.longitude}";
  }
}
