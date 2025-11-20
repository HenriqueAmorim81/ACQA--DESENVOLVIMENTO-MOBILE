import 'package:flutter/material.dart';

class ToDoListPage extends StatefulWidget {
	final DateTime selectedDate;

	ToDoListPage({Key? key, required this.selectedDate}) : super(key: key);

	@override
	_ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
	List<Task> tasks = [];

	@override
	Widget build(BuildContext context) {
		//  AppBar laranja forte
		return Scaffold(
			appBar: AppBar(
				title: Text('To-Do List - ${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}'),
				backgroundColor: Colors.deepOrange, // cor da barra superior
				foregroundColor: Colors.white, // cor do texto
			),
			body: Container(
				color: Colors.orange[50], // cor de fundo
				child: Column(
					children: [
						// Lista de tarefas estilo
						Expanded(
							child: ListView.builder(
								itemCount: tasks.length,
								itemBuilder: (context, index) {
									return Card(
										margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // espaçamento 
										shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
										elevation: 2,
										child: ListTile(
											title: Text(
												tasks[index].name,
												style: TextStyle(
													decoration: tasks[index].isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
													color: Colors.deepOrange, // texto laranja
													fontWeight: FontWeight.w500,
												),
											),
											leading: Icon(
												tasks[index].isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
												color: tasks[index].isCompleted ? Colors.orange : Colors.deepOrange,
											),
											trailing: Row(
												mainAxisSize: MainAxisSize.min,
												children: [
													IconButton(
														icon: Icon(Icons.check),
														color: Colors.deepOrange,
														onPressed: () {
															_toggleTaskCompletion(index);
														},
													),
													IconButton(
														icon: Icon(Icons.delete),
														color: Colors.deepOrange,
														onPressed: () {
															_removeTask(index);
														},
													),
												],
											),
										),
									);
								},
							),
						),
						// Botões de adicionar/remover tarefas 
						Padding(
							padding: const EdgeInsets.all(24.0), 
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceEvenly,
								children: [
									Expanded(
										child: ElevatedButton(
											style: ElevatedButton.styleFrom(
												backgroundColor: Colors.deepOrange,
												foregroundColor: Colors.white,
												padding: EdgeInsets.symmetric(vertical: 16),
												shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
											),
											onPressed: () {
												_showAddTaskDialog(context);
											},
											child: Text('Adicionar Tarefa', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
										),
									),
									SizedBox(width: 16),
									Expanded(
										child: ElevatedButton(
											style: ElevatedButton.styleFrom(
												backgroundColor: Colors.white,
												foregroundColor: Colors.deepOrange,
												padding: EdgeInsets.symmetric(vertical: 16),
												shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
												side: BorderSide(color: Colors.deepOrange, width: 2),
											),
											onPressed: () {
												_showRemoveAllTasksDialog(context);
											},
											child: Text('Remover Todas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
										),
									),
								],
							),
						),
					],
				),
			),
		);
	}

	// Função para mostrar um dialogo para adicionar uma tarefa
	void _showAddTaskDialog(BuildContext context) {
		String newTaskName = '';
		showDialog(
			context: context,
			builder: (BuildContext context) {
				return AlertDialog(
					title: Text('Adicionar Tarefa'),
					content: TextField(
						onChanged: (value) {
							newTaskName = value;
						},
						decoration: InputDecoration(hintText: 'Nome da tarefa'),
					),
					actions: [
						TextButton(
							onPressed: () {
								Navigator.pop(context);
							},
							child: Text('Cancelar'),
						),
						TextButton(
							onPressed: () {
							if (newTaskName != "") {
								setState(() {
									tasks.add(Task(name: newTaskName));
								});
								Navigator.pop(context);
							} else {
								showDialog(
									context: context,
									builder: (context) {
										return AlertDialog(
											title: Text('aviso'),
											content: Text('A tarefa não pode ter o nome vazio'),
											actions: <Widget>[
												TextButton(
													onPressed: () {
														Navigator.pop(context); // "desempilha" o alerta
													},
													child: Text('Fechar'),
												),
											],
										);
									},
								);
							}
						},
						child: Text('Adicionar'),
					),
					],
				);
			},
		);
	}

	// Função para mostrar um diálogo para remover todas as tarefas
	void _showRemoveAllTasksDialog(BuildContext context) {
		showDialog(
			context: context,
			builder: (BuildContext context) {
				return AlertDialog(
					title: Text('Remover Todas as Tarefas'),
					content: Text('Tem certeza de que deseja remover todas as tarefas?'),
					actions: [
						TextButton(
							onPressed: () {
								Navigator.pop(context);
							},
							child: Text('Cancelar'),
						),
						TextButton(
							onPressed: () {
								setState(() {
									tasks.clear();
								});
								Navigator.pop(context);
							},
							child: Text('Remover Todas'),
						),
					],
				);
			},
		);
	}

	// Função para alternar o estado de conclusão de uma tarefa
	void _toggleTaskCompletion(int index) {
		setState(() {
			tasks[index].isCompleted = !tasks[index].isCompleted;
		});
	}

	// Função para remover uma tarefa
	void _removeTask(int index) {
		setState(() {
			tasks.removeAt(index);
		});
	}
}

class Task {
	String name;
	bool isCompleted;

	Task({required this.name, this.isCompleted = false});
}
