import 'package:geolocator/geolocator.dart';

class Task {
  String nome;
  DateTime dataHora;
  Position geolocalizacao;

  Task({required this.nome, required this.dataHora, required this.geolocalizacao});
}
