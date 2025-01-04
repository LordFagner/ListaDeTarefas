import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/Pages/to_do_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ToDoPage(),
    );
  }
}
