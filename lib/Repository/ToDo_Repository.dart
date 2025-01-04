
import 'dart:convert';


import 'package:lista_de_tarefas/Pages/Model/ToDo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class todoRepository {
String _keyd = 'TodoList';


late SharedPreferences sharedPreferencesAsync;


Future<List<ToDo>> GetToDoList() async{

  sharedPreferencesAsync = await SharedPreferences.getInstance();
  String Json = sharedPreferencesAsync.getString(this._keyd) ?? "[]";
  List JsonDecode = jsonDecode(Json) as List;
return  JsonDecode.map((e) => ToDo.fromJson(e)).toList();
}

void SaveTodo(List<ToDo> Todos){
final String json = jsonEncode(Todos);
sharedPreferencesAsync.setString('TodoList', json);

}


}