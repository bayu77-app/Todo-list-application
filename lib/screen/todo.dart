class Todo {
  int? id;
  String nama;
  String deskripsi;
  bool done;


  Todo(this.nama, this.deskripsi, {this.done = false, this.id});

  static List<Todo> dummyData = [
    Todo("Selamat datang", "Semoga anda puas",),
  ];

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'deskripsi': deskripsi,
      'done': done ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map){
    return Todo(
      map['nama'] as String,
      map['deskripsi'] as String,
      done: map['done'] == 1 ? false :true,
      id: map['id'],
    );
  }
}
