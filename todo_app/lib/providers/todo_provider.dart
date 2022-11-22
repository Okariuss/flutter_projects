import 'package:flutter/widgets.dart';

import '../models/toDoModel.dart';

class ToDoProvider extends ChangeNotifier {
  List<ToDoModel> list = [];
  late String _searchName = "";
  late String _addName = "";
  late final String _isRemoved = "";
  late bool _isCheck = false;

  bool getIsCheck() {
    return _isCheck;
  }

  setIsCheck(bool check) {
    _isCheck = !check;
    notifyListeners();
  }

  String getSearchName() {
    return _searchName;
  }

  setSearchName(String name) {
    _searchName = name;
    notifyListeners();
  }

  String getAddName() {
    return _addName;
  }

  setAddName(String name) {
    _addName = name;
    notifyListeners();
  }

  changeList(List<ToDoModel> newList) {
    list = newList;
    notifyListeners();
  }

  List<ToDoModel> getList() {
    return list;
  }

  deleteById(String id) {
    list.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  addNote(String text) {
    list.add(ToDoModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(), toDoText: text));
    notifyListeners();
  }
}
