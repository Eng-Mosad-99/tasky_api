import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tasky_api/features/home/domain/usecases/create_todo_use_case.dart';
import 'package:tasky_api/features/home/domain/usecases/delete_todo_use_case.dart';
import 'package:tasky_api/features/home/domain/usecases/get_one_todo_use_case.dart';
import 'package:tasky_api/features/home/domain/usecases/todos_use_case.dart';
import 'package:tasky_api/features/home/domain/usecases/upload_todo_image_use_case.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../domain/entities/create_todo_response_entity.dart';
import '../../domain/entities/todos_response_entity.dart';
import '../../requests/create_todo_request_body.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this.todosUseCase,
    this.getOneTodoUseCase,
    this.uploadTodoImageUseCase,
    this.createTodoUseCase,
    this.deleteTodoUseCase,
  ) : super(HomeInitial());
  final TodosUseCase todosUseCase;
  final CreateTodoUseCase createTodoUseCase;
  final GetOneTodoUseCase getOneTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final UploadTodoImageUseCase uploadTodoImageUseCase;
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  List<TodosResponseEntity> todosList = [];
  List<TodosResponseEntity> filteredTodosList = [];
  final List<String> todoNameList = const [
    'All',
    'inProgress',
    'waiting',
    'finished',
  ];
  int selectedIndex = 0;
  void changeSelectedTab(int index) {
    selectedIndex = index;
    filterTodos();
    emit(ChangeSelectedTab(selectedIndex));
  }

  Future<void> getAllTodos() async {
    emit(GetAllTodosLoading());
    final response = await todosUseCase.call();
    response.fold((l) => emit(GetAllTodosFailure(l.errorMessage)), (r) {
      todosList = r;
      filterTodos();
      emit(GetAllTodosSuccess());
    });
  }

  void filterTodos() {
    if (selectedIndex == 0) {
      filteredTodosList = todosList;
    } else {
      filteredTodosList = todosList
          .where(
            (todo) =>
                todo.status?.toLowerCase() ==
                todoNameList[selectedIndex].toLowerCase(),
          )
          .toList();
    }

    log('Filtered: ${filteredTodosList.length}');
  }

  void getOneTodo(String todoID) async {
    emit(GetOneTodoLoading());
    final response = await getOneTodoUseCase.call(todoID);
    response.fold((l) => emit(GetOneTodoFailure(l.errorMessage)), (r) {
      emit(GetOneTodoSuccess(r));
    });
  }

  String? selectedImagePath;
  String? uploadedImageName;

  Future<void> uploadImage() async {
    if (selectedImagePath == null) return;

    final result = await uploadTodoImageUseCase.call(selectedImagePath!);

    result.fold(
      (failure) {
        print(failure.errorMessage);
      },
      (success) {
        uploadedImageName = success.image;
        print("Image Name: $uploadedImageName");
      },
    );
  }

  Future<void> pickImage() async {
    var status = await Permission.photos.request();

    if (status.isGranted) {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        selectedImagePath = image.path;
        log("selectedImagePath: ==> $selectedImagePath");
        emit(UploadImageSuccess());
        uploadImage();
      }
    } else {
      print("Permission denied");
    }
  }

  final List<String> priorityLevels = ['low', 'medium', 'high'];
  String? selectedLevel;

  changeLevel(String? newValue) {
    selectedLevel = newValue;
    log('selectedLevel: $selectedLevel');
    emit(ChangeLevelSuccess(selectedLevel!));
  }

  DateTime? selectedDate;
  String formatDate = '';

  void chooseDate(BuildContext context) async {
    DateTime? selectedDateTime = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedDateTime != null) {
      selectedDate = selectedDateTime;
      formatDate = DateFormat('dd-MM-yyyy').format(selectedDateTime);

      print("Selected Date After: $formatDate");
      emit(ChooseDateSuccess());
    }
  }

  createTodo() async {
    if (formKey.currentState!.validate()) {
      emit(CreateTodoLoading());
      final result = await createTodoUseCase.call(
        CreateTodoRequestBody(
          title: titleController.text,
          desc: descriptionController.text,
          priority: selectedLevel!,
          dueDate: selectedDate!.toIso8601String(),
          image: uploadedImageName!,
        ),
      );
      log('Format Date ==> $formatDate');
      result.fold(
        (l) => emit(CreateTodoFailure(l.errorMessage)),
        (r) => emit(CreateTodoSuccess(r)),
      );
    }
  }

   void deleteTodo(String todoID) async {
    emit(DeleteTodoLoading());
    final response = await deleteTodoUseCase.call(todoID);
    response.fold((l) => emit(DeleteTodoFailure(l.errorMessage)), (r) {
      emit(DeleteTodoSuccess(r));
      getAllTodos();
    });
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    return super.close();
  }
}
