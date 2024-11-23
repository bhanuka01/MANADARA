// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// // Define Todo Model
// class Todo {
//   final String task;
//   bool isCompleted;
//
//   Todo({required this.task, this.isCompleted = false});
//
//   void toggleCompleted() {
//     isCompleted = !isCompleted;
//   }
// }
//
// // Events
// abstract class TodoEvent {}
//
// class AddTodoEvent extends TodoEvent {
//   final String task;
//   AddTodoEvent(this.task);
// }
//
// class ToggleTodoEvent extends TodoEvent {
//   final int index;
//   ToggleTodoEvent(this.index);
// }
//
// class RemoveTodoEvent extends TodoEvent {
//   final int index;
//   RemoveTodoEvent(this.index);
// }
//
// // State
// class TodoState {
//   final List<Todo> todos;
//
//   TodoState({required this.todos});
// }
//
// // Bloc
// class TodoBloc extends Bloc<TodoEvent, TodoState> {
//   TodoBloc() : super(TodoState(todos: [])) {
//     on<AddTodoEvent>((event, emit) {
//       emit(TodoState(
//           todos: List.from(state.todos)..add(Todo(task: event.task))));
//     });
//
//     on<ToggleTodoEvent>((event, emit) {
//       List<Todo> updatedTodos = List.from(state.todos);
//       updatedTodos[event.index].toggleCompleted();
//       emit(TodoState(todos: updatedTodos));
//     });
//
//     on<RemoveTodoEvent>((event, emit) {
//       List<Todo> updatedTodos = List.from(state.todos);
//       updatedTodos.removeAt(event.index);
//       emit(TodoState(todos: updatedTodos));
//     });
//   }
// }
//
// class Todopage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Todo App',
//       home: BlocProvider(
//         create: (context) => TodoBloc(),
//         child: TodoScreen(),
//       ),
//     );
//   }
// }
//
// class TodoScreen extends StatefulWidget {
//   @override
//   _TodoScreenState createState() => _TodoScreenState();
// }
//
// class _TodoScreenState extends State<TodoScreen> {
//   final TextEditingController _textEditingController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Todo App'),
//         ),
//         body: BlocBuilder<TodoBloc, TodoState>(
//           builder: (context, state) {
//             return ListView.builder(
//               itemCount: state.todos.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(
//                     state.todos[index].task,
//                     style: TextStyle(
//                         decoration: state.todos[index].isCompleted
//                             ? TextDecoration.lineThrough
//                             : null),
//                   ),
//                   leading: Checkbox(
//                     value: state.todos[index].isCompleted,
//                     onChanged: (value) {
//                       context.read<TodoBloc>().add(ToggleTodoEvent(index));
//                     },
//                   ),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () {
//                       context.read<TodoBloc>().add(RemoveTodoEvent(index));
//                     },
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (BuildContext dialogContext) {
//                 // <-- IMPORTANT: Use a different name here, like dialogContext
//                 return AlertDialog(
//                   title: const Text('Add Todo'),
//                   content: TextField(
//                     controller: _textEditingController,
//                     decoration: const InputDecoration(hintText: "Enter todo"),
//                   ),
//                   actions: <Widget>[
//                     TextButton(
//                       child: const Text('CANCEL'),
//                       onPressed: () {
//                         Navigator.of(dialogContext)
//                             .pop(); // <-- Use dialogContext here
//                       },
//                     ),
//                     TextButton(
//                       child: const Text('ADD'),
//                       onPressed: () {
//                         //  Use `Builder` to get the correct context
//                         Builder(builder: (BuildContext context) {
//                           // <--  Access TodoBloc inside this builder
//                           context
//                               .read<TodoBloc>()
//                               .add(AddTodoEvent(_textEditingController.text));
//                           _textEditingController.clear();
//                           Navigator.of(dialogContext)
//                               .pop(); // <-- Use dialogContext here too
//                           return const SizedBox
//                               .shrink(); // <-- Builder requires a return widget, even empty
//                         });
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//           child: Icon(Icons.add),
//         ));
//   }
//
//   @override
//   void dispose() {
//     _textEditingController.dispose();
//     super.dispose();
//   }
// }
