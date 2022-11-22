import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/models/toDoModel.dart';
import 'package:todo_app/widgets/user_avatar.dart';

import '../providers/todo_provider.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDoModel.toDoList();
  List<ToDoModel> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ToDoProvider myProvider = Provider.of<ToDoProvider>(context);
    final todoController = TextEditingController(text: myProvider.getAddName());
    final searchController =
        TextEditingController(text: myProvider.getSearchName());

    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.menu, color: tdBlack, size: 30),
            UserAvatar(),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Consumer<ToDoProvider>(
                    builder: (context, result, child) {
                      return TextField(
                        controller: searchController,
                        onChanged: (val) {
                          myProvider.setSearchName(val);
                          runFilter(val, result);

                          searchController.selection = TextSelection(
                              baseOffset: searchController.text.length,
                              extentOffset: searchController.text.length);
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          prefixIcon: Icon(
                            Icons.search,
                            color: tdBlack,
                            size: 20,
                          ),
                          prefixIconConstraints:
                              BoxConstraints(maxHeight: 20, minWidth: 25),
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle: TextStyle(color: tdGrey),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          HeaderString.header,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.black),
                        ),
                      ),
                      for (ToDoModel todo in _foundToDo.reversed)
                        Consumer<ToDoProvider>(
                          builder: (context, value, child) {
                            return ToDoItem(
                              todo: todo,
                              onToDoChanged: _handleToDoChange,
                              onDeleteItem: _handleToDoDelete,
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: todoController,
                      decoration: const InputDecoration(
                        hintText: "Add a new todo item",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: Consumer<ToDoProvider>(
                    builder: (context, value, child) {
                      return ElevatedButton(
                        onPressed: () {
                          addToDoItem(todoController, value);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: tdBlue,
                            minimumSize: const Size(60, 60),
                            elevation: 10),
                        child: const Icon(Icons.add),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDoModel todo, ToDoProvider provider) {
    provider.setIsCheck(todo.isDone);
    todo.isDone = provider.getIsCheck();
  }

  void _handleToDoDelete(String id, ToDoProvider provider) {
    runFilter("", provider);
    provider.deleteById(id);
  }

  void addToDoItem(TextEditingController controller, ToDoProvider provider) {
    runFilter("", provider);
    provider.addNote(controller.text);
    // setState(() {
    //   todosList.add(ToDoModel(
    //       id: DateTime.now().millisecondsSinceEpoch.toString(),
    //       toDoText: controller.text));
    // });
    controller.clear();
  }

  void runFilter(String input, ToDoProvider result) {
    if (input.isEmpty) {
      result.changeList(todosList);
    } else {
      result.changeList(todosList
          .where((element) =>
              element.toDoText!.toLowerCase().contains(input.toLowerCase()))
          .toList());
    }
    _foundToDo = result.getList();
  }
}

class HeaderString {
  static String header = "All ToDos";
}
