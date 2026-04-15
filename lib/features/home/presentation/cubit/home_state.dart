part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class GetAllTodosLoading extends HomeState {}

class GetAllTodosSuccess extends HomeState {
  // final List<TodosResponseEntity> todos;
  // const GetAllTodosSuccess(this.todos);

  // @override
  // List<Object> get props => [todos];
}

class GetAllTodosFailure extends HomeState {
  final String errorMsg;
  const GetAllTodosFailure(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}

class ChangeSelectedTab extends HomeState {
  final int selectedIndex;

  const ChangeSelectedTab(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}


class GetOneTodoLoading extends HomeState {}

class GetOneTodoSuccess extends HomeState {
  final TodosResponseEntity todo;
  const GetOneTodoSuccess(this.todo);

  @override
  List<Object> get props => [todo];
}

class GetOneTodoFailure extends HomeState {
  final String errorMsg;
  const GetOneTodoFailure(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}

class UploadImageSuccess extends HomeState {}
class ChangeLevelSuccess extends HomeState {
  final String level;

  const ChangeLevelSuccess(this.level);

  @override
  List<Object> get props => [level];
}
class ChooseDateSuccess extends HomeState {}

class CreateTodoLoading extends HomeState {}

class CreateTodoSuccess extends HomeState {
  final CreateTodoResponseEntity todo;
  const CreateTodoSuccess(this.todo);

  @override
  List<Object> get props => [todo];
}

class CreateTodoFailure extends HomeState {
  final String errorMsg;
  const CreateTodoFailure(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}

class DeleteTodoLoading extends HomeState {}
class DeleteTodoSuccess extends HomeState {
final  CreateTodoResponseEntity todo;
  const DeleteTodoSuccess(this.todo);
  @override
  List<Object> get props => [todo];
}

class DeleteTodoFailure extends HomeState {
  final String errorMsg;
  const DeleteTodoFailure(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}