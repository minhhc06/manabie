import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_manabie/bloc/home_page_bloc.dart';
import 'package:todo_manabie/pages/home_page/components/home_page_components/home_page_components.dart';
import 'package:todo_manabie/pages/home_page/components/navigation_component.dart';
import 'package:todo_manabie/pages/home_page/model/task_model.dart';
import 'package:todo_manabie/util/base_components.dart';
import 'package:todo_manabie/util/colors_util.dart';
import 'package:todo_manabie/util/convert_color_util.dart';
import 'package:todo_manabie/util/enum_util.dart';
import 'package:todo_manabie/util/shared_preference_util.dart';
import 'package:todo_manabie/util/words_util.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with BaseComponents {
  HomePageBloc bloc;
  List<TaskModel> listTask;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listTask = [];
    listTask.add(new TaskModel(
        id: 1, title: 'Worked out or do exercise', isComplete: false));
    listTask
        .add(new TaskModel(id: 2, title: 'Read something', isComplete: false));
    listTask
        .add(new TaskModel(id: 3, title: 'Cook for dinner', isComplete: false));
    listTask
        .add(new TaskModel(id: 4, title: 'Drink 4l water', isComplete: false));
    listTask.add(new TaskModel(
        id: 5, title: 'Take a break from social media', isComplete: false));
    listTask.add(
        new TaskModel(id: 6, title: 'Do something fun', isComplete: false));
    listTask.add(new TaskModel(
        id: 7, title: 'Wake up early (before 7 AM)', isComplete: false));
    listTask
        .add(new TaskModel(id: 8, title: 'Eat breakfast', isComplete: false));
    listTask.add(new TaskModel(
        id: 9, title: 'Watch a football match', isComplete: false));
    listTask.add(
        new TaskModel(id: 10, title: 'Take a shower twice', isComplete: false));

    getShared();
    bloc = new HomePageBloc(listTask: listTask);
  }

  Future<void> getShared() async {
    String value = await SharedPreferenceUtil()
        .getStringSharePreference(key: WordsUtil.keySaveListCompleted);
    if (value != null) {
      final List<TaskModel> tasks = TaskModel.decode(value);
      for (TaskModel task in listTask) {
        for (TaskModel tasksLocal in tasks) {
          if (tasksLocal.id == task.id) {
            listTask.removeWhere((item) => item.id == tasksLocal.id);
            listTask.add(new TaskModel(
                id: tasksLocal.id,
                title: '${tasksLocal.title}',
                isComplete: tasksLocal.isComplete));
            listTask.sort((a, b) {
              return a.id
                  .toString()
                  .toLowerCase()
                  .compareTo(b.id.toString().toLowerCase());
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return StreamBuilder<TypeCategory>(
        stream: bloc.getIndexNavigationBar,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          }
          return Scaffold(
            appBar: AppBar(
                brightness: Brightness.light,
                centerTitle: true,
                backgroundColor: Colors.white,
                title: Text(
                  '${HomePageComponents().titleAppbar(snapshot.data)}',
                  style: TextStyle(
                      color: ConvertColorUtil(ColorsUtil.blueColorApp),
                      fontWeight: FontWeight.bold),
                )),
            body: HomePageComponents()
                .buildBody(bloc: bloc, typeCategory: snapshot.data),
            bottomNavigationBar: NavigationComponent().bottomNavigationBar(
                stream: bloc.getIndexNavigationBar,
                onTapFunction: (int index) {
                  switch (index) {
                    case 0:
                      bloc.setIndexNavigationBar(
                          typeCategory: TypeCategory.all);
                      break;
                    case 1:
                      bloc.setIndexNavigationBar(
                          typeCategory: TypeCategory.completed);
                      break;
                    case 2:
                      bloc.setIndexNavigationBar(
                          typeCategory: TypeCategory.inComplete);
                      break;
                  }
                }),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }
}
