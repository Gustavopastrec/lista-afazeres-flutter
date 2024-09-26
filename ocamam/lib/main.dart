import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Afazeres',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      home: TaskManager(),
    );
  }
}

class TaskManager extends StatefulWidget {
  @override
  _TaskManagerState createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  List<String> tarefas = [
    'Estudar para a prova',
    'Praticar exercícios',
    'Enviar trabalho'
  ];

  TextEditingController _novaTarefaController = TextEditingController();

  // Função para adicionar nova tarefa
  void _adicionarTarefa() {
    if (_novaTarefaController.text.isNotEmpty) {
      setState(() {
        tarefas.add(_novaTarefaController.text);
      });
      _novaTarefaController.clear();
    }
  }

  // Função para editar tarefa
  void _editarTarefa(BuildContext context, int index) {
    TextEditingController _controller = TextEditingController();
    _controller.text = tarefas[index];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[850],
          title: Text('Editar Tarefa', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: _controller,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Digite a nova tarefa",
              hintStyle: TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.grey[800],
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar',
                  style: TextStyle(color: Colors.purpleAccent)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:
                  Text('Salvar', style: TextStyle(color: Colors.purpleAccent)),
              onPressed: () {
                setState(() {
                  tarefas[index] = _controller.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Função para excluir tarefa
  void _excluirTarefa(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[850],
          title: Text('Excluir Tarefa', style: TextStyle(color: Colors.white)),
          content: Text('Tem certeza que deseja excluir esta tarefa?',
              style: TextStyle(color: Colors.white70)),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar',
                  style: TextStyle(color: Colors.purpleAccent)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Excluir', style: TextStyle(color: Colors.redAccent)),
              onPressed: () {
                setState(() {
                  tarefas.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Afazeres'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _novaTarefaController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Adicionar nova tarefa',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add,
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  onPressed: _adicionarTarefa,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[850],
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: ListTile(
                    title: Text(
                      tarefas[index],
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit,
                              color: const Color.fromARGB(255, 255, 255, 255)),
                          onPressed: () {
                            _editarTarefa(context, index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () {
                            _excluirTarefa(index);
                          },
                        ),
                      ],
                    ),
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
