// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lista_compras/models/task.dart';

class EditTask extends StatefulWidget {
  final Task task;
  final int index;
  final Function(Task, int) callback; 

  EditTask({required this.task, required this.index, required this.callback});

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController nomeController;
  DateTime? selectedDateTime;
  Position? selectedGeolocalizacao;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.task.nome);
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
                  initialDate: selectedDateTime!,
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2025),
                );
                if (selectedDate != null) {
                  final selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(selectedDateTime!),
                  );
                  if (selectedTime != null) {
                    setState(() {
                      selectedDateTime = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      );
                    });
                  }
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
              child: Text('Salvar Alterações'),
              onPressed: () {
                if (nomeController.text.isNotEmpty && selectedDateTime != null && selectedGeolocalizacao != null) {
                  final updatedTask = Task(
                    nome: nomeController.text,
                    dataHora: selectedDateTime!,
                    geolocalizacao: selectedGeolocalizacao!,
                  );
                  widget.callback(updatedTask, widget.index);
                  Navigator.pop(context, {'index': widget.index, 'task': updatedTask});
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
