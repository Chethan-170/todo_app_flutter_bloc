import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_flutter_bloc/models/todo_model.dart';

part 'filtered_todo_cubit_state.dart';

class FilteredTodoCubit extends Cubit<FilteredTodoCubitState> {
  final List<Todo> initialTodos;

  FilteredTodoCubit({
    required this.initialTodos,
  }) : super(FilteredTodoCubitState(filteredTodos: initialTodos));

  void setFilteredTodos({
    required List<Todo> todos,
    required Filter filter,
    required String searchTerm,
  }) {
    List<Todo> filteredTodos;
    switch (filter) {
      case Filter.active:
        filteredTodos = todos.where((Todo todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        filteredTodos = todos.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all:
      default:
        filteredTodos = todos;
        break;
    }
    if (searchTerm.isNotEmpty) {
      filteredTodos = filteredTodos
          .where((Todo todo) =>
              todo.desc.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }
    emit(state.copyWith(filteredTodos));
  }
}
