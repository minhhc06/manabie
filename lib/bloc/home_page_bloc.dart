import 'package:rxdart/rxdart.dart';
import 'package:todo_manabie/pages/home_page/model/task_model.dart';
import 'package:todo_manabie/util/enum_util.dart';

class HomePageBloc {
  HomePageBloc({List<TaskModel> listTask}) {
    setIndexNavigationBar(typeCategory: TypeCategory.all);
    setListTaskModel(listTask);
  }

  BehaviorSubject<TypeCategory> _setIndexNavigationBar =
      BehaviorSubject<TypeCategory>();

  Stream<TypeCategory> get getIndexNavigationBar =>
      _setIndexNavigationBar.stream;

  setIndexNavigationBar({TypeCategory typeCategory}) {
    try {
      _setIndexNavigationBar.sink.add(typeCategory);
      return true;
    } catch (ex) {
      return false;
    }
  }

  BehaviorSubject<List<TaskModel>> _setListTaskModel =
      BehaviorSubject<List<TaskModel>>();

  Stream<List<TaskModel>> get getListTaskModel => _setListTaskModel.stream;

  setListTaskModel(List<TaskModel> listTask) {
    try {
      _setListTaskModel.sink.add(listTask);
      return true;
    } catch (ex) {
      return false;
    }
  }

  updateIsCompleted({TaskModel taskModel}) {
    try {
      var model = _setListTaskModel.stream.value;

      int index = model.indexOf(taskModel);
      model[index].isComplete = !model[index].isComplete;

      _setListTaskModel.sink.add(model);

      return true;
    } catch (ex) {
      return false;
    }
  }

  dispose() {
    try {
      _setIndexNavigationBar.close();
      _setListTaskModel.close();
      return true;
    } catch (ex) {
      return false;
    }
  }
}
