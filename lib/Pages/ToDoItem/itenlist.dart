import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../Model/ToDo.dart';

class ItemList extends StatelessWidget {
  const ItemList({super.key, required this.object, required this.OnDelete});

  final ToDo object;
  final Function(ToDo) OnDelete;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.grey[200],
            ),
            child: Padding(
              padding: EdgeInsets.all(9.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    DateFormat('dd/MM/yyyy - HH:mm').format(object.time),
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    object.Title,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      endActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (Context){
              OnDelete(object);

            },
            padding: EdgeInsets.all(3),
            flex: 1,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            spacing: 3,
            label: "Deletar",
            foregroundColor: Colors.white,
          ),
        ],
        extentRatio: 0.2,
      ),
    );
  }
}
