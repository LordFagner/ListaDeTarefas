import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/Pages/Model/ToDo.dart';
import 'package:lista_de_tarefas/Repository/ToDo_Repository.dart';
import 'ToDoItem/itenlist.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final TextEditingController controller = TextEditingController();
  final List<ToDo> ToDos = [];
  ToDo? TodoRemvoed;
  int? ToDoPosition;
  final todoRepository Repository = todoRepository();
  String? TextError;

  @override
  void initState() {
    super.initState();

    Repository.GetToDoList().then((value) {
      setState(() {
        ToDos.addAll(value); // Usando addAll para adicionar múltiplos elementos
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("Assets/Images/Casal.jpeg")),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              hoverColor: const Color(0xff00d7f3),
                              border: const OutlineInputBorder(),
                              labelText: "Insira uma tarefa",
                              labelStyle: TextStyle(color: Colors.blue),
                              hintText: "Ex: da uns beijinhos no meu amo",
                              errorText: TextError,
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff00d7f3),
                                  width: 2,
                                ),
                              ),
                            ),
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            String text = controller.text;

                            if (text.isEmpty) {
                              setState(() {
                                TextError = "o Campo Está vazio";
                              });
                              return;
                            }

                            setState(() {
                              final ToDo todo =
                              ToDo(controller.text, DateTime.now());
                              ToDos.add(todo);
                              TextError = null;
                            });
                            Repository.SaveTodo(ToDos);
                            controller.clear();
                          },
                          child: const Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.white,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                            backgroundColor: const Color(0xff00d7f3),
                            padding: const EdgeInsets.all(13),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (final ToDo i in ToDos)
                          ItemList(object: i, OnDelete: Ondelete),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "você tem ${ToDos.length} Tarefas Pendentes",
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: ElevatedButton(
                            onPressed: ShowDeletedDialog,
                            child: const Text(
                              "Limpar Tudo ",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2),
                                ),
                              ),
                              backgroundColor: const Color(0xff00d7f3),
                              padding: const EdgeInsets.all(13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void Ondelete(ToDo todo) {
    TodoRemvoed = todo;
    ToDoPosition = ToDos.indexOf(todo);
    setState(() {
      ToDos.remove(todo);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tarefa " ${todo.Title} " removida com sucesso',
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: "desfazer",
          onPressed: () {
            setState(() {
              if (TodoRemvoed != null && ToDoPosition != null) {
                ToDos.insert(ToDoPosition!, TodoRemvoed!);
              }
            });
          },
          textColor: const Color(0xff00d7f3),
        ),
      ),
    );
  }

  void ShowDeletedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Deletar tudo ?"),
        content: const Text("você tem certeza que quer deletar tudo ? "),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Cancelar",
              style: TextStyle(color: Color(0xff00d7f3)),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                ToDos.clear();
                Navigator.of(context).pop();
              });
            },
            child: const Text(
              "Deletar",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

//algumas funcitons postas
//Scaffold(
//   appBar: AppBar(
//     backgroundColor: Colors.red,
//     title: Text("lista de tarefas"),
//   ),
//   drawer: Drawer(),
//   body: Center(
//     child: Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             controller: controller,
//             decoration: InputDecoration(
//               labelText: "Email",
//               hintText: "email@email.com",
//               border: OutlineInputBorder(),
//               // prefixText: "R\$ :",
//             ),
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.w800,
//              ),//onChanged: OnChanged,
//             onSubmitted: onSubmted,
//             // keyboardType: TextInputType.number,
//             // obscureText: true ,
//           ),
//           ElevatedButton(
//             onPressed: printController,
//             child: Text("entrar"),
//           )
//         ],
//       ),
//     ),
//   ),
// );
