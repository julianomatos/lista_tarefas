// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../models/task.dart';

class CreateTask extends StatefulWidget {
  final Function(Task) callback;
  @override
  _CreateTaskState createState() => _CreateTaskState();
  // ignore: prefer_const_constructors_in_immutables
  CreateTask({required this.callback});
}

class _CreateTaskState extends State<CreateTask> {
  // TextEditingController nomeController = TextEditingController();
  DateTime? selectedDateTime;
  // Position? selectedGeolocalizacao;
  final _date = TextEditingController();
  final _name = TextEditingController();
  final _location = TextEditingController();
  @override
  void initState() {
    super.initState();
    getLocation().then((location) {
      _location.text = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Tarefa'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _name,
              decoration: InputDecoration(
                labelText: 'Nome da Tarefa',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _date,
              decoration: const InputDecoration(
                labelText: "Data da tarefa",
              ),
            ),
            ElevatedButton(
              child: Text('Selecionar Data e Hora'),
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2025),
                );
                if (selectedDate != null) {
                  setState(() {
                    selectedDateTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,

                      // selectedTime.hour,
                      // selectedTime.minute,
                    );
                    _date.text = selectedDateTime.toString().substring(0, 10);
                  });
                }
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _location,
              decoration: const InputDecoration(
                labelText: "Localização",
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Selecionar Geolocalização'),
              onPressed: () async {
                final currentPosition = await getLocation();
                setState(() {
                  _location.text = currentPosition;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Salvar Tarefa'),
              onPressed: () {
                if (_name.text.isNotEmpty &&
                    selectedDateTime != null &&
                    _location.text.isNotEmpty) {
                  final task = Task(
                    nome: _name.text,
                    dataHora: selectedDateTime!,
                    geolocalizacao: _location.text,
                  );
                  widget.callback(task);
                  Navigator.pop(context, task);
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
