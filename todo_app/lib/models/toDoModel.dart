// ignore_for_file: public_member_api_docs, sort_constructors_first
class ToDoModel {
  String? id;
  String? toDoText;
  bool isDone;

  ToDoModel({
    required this.id,
    required this.toDoText,
    this.isDone = false,
  });

  static List<ToDoModel> toDoList() {
    return [
      ToDoModel(id: '01', toDoText: 'toDoText1', isDone: true),
      ToDoModel(id: '02', toDoText: 'toDoText2'),
      ToDoModel(id: '03', toDoText: 'toDoText3'),
    ];
  }
}
