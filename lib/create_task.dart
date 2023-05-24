// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'models/task.dart';

class CreateTask extends StatefulWidget {
  final Function(Task) callback;
  @override
  _CreateTaskState createState() => _CreateTaskState();
   // ignore: prefer_const_constructors_in_immutables
   CreateTask({required this.callback});

 
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController nomeController = TextEditingController();
  DateTime? selectedDateTime;
  Position? selectedGeolocalizacao;

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
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Nome da Tarefa',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Selecionar Data e Hora'),
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2025),
                );
                if (selectedDate != null) 
                // {
                //   final selectedTime = await showTimePicker(
                //     context: context,
                //     initialTime: TimeOfDay.now(),
                //   );
                //   if (selectedTime != null)
                   {
                    setState(() {
                      selectedDateTime = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        // selectedTime.hour,
                        // selectedTime.minute,
                      );
                    });
                  }
                
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Selecionar Geolocalização'),
              onPressed: () async {
                final currentPosition = await Geolocator.getCurrentPosition();
                setState(() {
                  selectedGeolocalizacao = currentPosition;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Salvar Tarefa'),
              onPressed: () {
                if (nomeController.text.isNotEmpty && selectedDateTime != null && selectedGeolocalizacao != null) {
                  final task = Task(
                    nome: nomeController.text,
                    dataHora: selectedDateTime!,
                    geolocalizacao: selectedGeolocalizacao!,
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
}
