// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:lista_compras/models/task.dart';
import 'package:location/location.dart';

class EditTask extends StatefulWidget {
  final Task task;
  final int index;
  final Function(Task, int) callback;

  EditTask({required this.task, required this.index, required this.callback});

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController nameController;
  late TextEditingController dateController;

  late DateTime selectedDateTime;
  late String selectedGeolocalizacao;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.task.nome);
    dateController = TextEditingController(text: widget.task.dataHora.toString().substring(0,10));
    selectedDateTime = widget.task.dataHora;
    selectedGeolocalizacao = widget.task.geolocalizacao;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Tarefa'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nome da Tarefa',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: 'Data da Tarefa',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Selecione a Data'),
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDateTime,
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2025),
                );
                if (selectedDate != null) {
                  setState(() {
                    selectedDateTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                    );
                  });
                }
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Selecionar Geolocalização'),
              onPressed: () async {
                final currentPosition = await getLocation();
                setState(() {
                  selectedGeolocalizacao = currentPosition;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Salvar Alterações'),
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    selectedGeolocalizacao.isNotEmpty) {
                  final updatedTask = Task(
                    nome: nameController.text,
                    dataHora: selectedDateTime,
                    geolocalizacao: selectedGeolocalizacao,
                  );
                  widget.callback(updatedTask, widget.index);
                  Navigator.pop(
                      context, {'index': widget.index, 'task': updatedTask});
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
          ],
        ),
      ),
    );
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
