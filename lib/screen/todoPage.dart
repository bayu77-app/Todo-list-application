import 'package:flutter/material.dart';
import 'package:to_do_list/database_helper.dart';
import 'package:to_do_list/screen/todo.dart';
import 'package:to_do_list/shared/theme.dart';

class Todopage extends StatelessWidget {
  const Todopage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TodoList();
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _namaCtrl = TextEditingController();
  final TextEditingController _deskrisiCtrl = TextEditingController();
  final TextEditingController _searchCtrl = TextEditingController();
  final TextEditingController _tanggalTenggatCtrl = TextEditingController();
  List<Todo> todoList = [];

  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  void refreshList() async {
    final todos = await dbHelper.getAllTodos();
    setState(() {
      todoList = todos;
    });
  }

  void addItem() async {
    await dbHelper.addTodo(
      Todo(_namaCtrl.text, _deskrisiCtrl.text,),
    );

    //TodoList.add(Todo(_namaCtrl.text, _deskrisiCtrl.text,),);
    refreshList();

    _namaCtrl.text = '';
    _deskrisiCtrl.text = '';
  }

 void updateItem(int index, bool done) async {
  setState(() {
    todoList[index].done = done;
  });

  await dbHelper.updateTodo(todoList[index]); 
}
  void deleteItem(int id) async {
    // TodoList.removeAt(index);
    await dbHelper.deleteTodo(id);
    refreshList();
  }

  void cariTodo() async {
    String teks = _searchCtrl.text;
    List<Todo> todos = [];
    if (teks.isEmpty) {
      todos = await dbHelper.getAllTodos();
    } else {
      todos = await dbHelper.searchTodo(teks);
    }

    setState(() {
      todoList = todos;
    });
  }

  void tampilForm() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            insetPadding: EdgeInsets.all(20),
            title: Text("Tambah Todo"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Tutup"),
              ),
              ElevatedButton(
                onPressed: () {
                  addItem();
                  Navigator.pop(context);
                },
                child: Text("Tambah"),
              ),
            ],

            content: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  TextField(
                    controller: _namaCtrl,
                    decoration: InputDecoration(hintText: 'Nama Todo'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _deskrisiCtrl,
                    decoration: InputDecoration(
                      hintText: 'Deskripsi Pekerjaan',
                    ),
                  ),
                  SizedBox(height: 10),

                 
                ],
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Aplikasi Todo List',
          style: BlackTextStyle.copyWith(fontWeight: bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          tampilForm();
        },
        child: Icon(Icons.add_box),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (_) {
                cariTodo();
              },
              decoration: InputDecoration(
                hintText: 'Cari Sesuatu ?',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading:
                      todoList[index].done
                          ? IconButton(
                            icon: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            onPressed:
                                () => {
                                  updateItem(index, !todoList[index].done),
                                },
                          )
                          : IconButton(
                            icon: const Icon(Icons.radio_button_unchecked),
                            onPressed:
                                () => {
                                  updateItem(index, !todoList[index].done),
                                },
                          ),
                  title: Text(todoList[index].nama),
                  subtitle: Text((todoList[index].deskripsi)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteItem(todoList[index].id ?? 0);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
