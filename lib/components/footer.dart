import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: Colors.blue,
      child: const Center(
        child: Text(
          '© Todos os direitos reservados.',
          style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
