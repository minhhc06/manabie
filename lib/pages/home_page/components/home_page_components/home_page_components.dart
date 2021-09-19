
import 'package:flutter/material.dart';
import 'package:todo_manabie/bloc/home_page_bloc.dart';
import 'package:todo_manabie/pages/home_page/model/task_model.dart';
import 'package:todo_manabie/util/enum_util.dart';
import 'package:todo_manabie/util/shared_preference_util.dart';
import 'package:todo_manabie/util/size_util.dart';
import 'package:todo_manabie/util/words_util.dart';

class HomePageComponents {
  List<TaskModel> listTask = [];

  String titleAppbar(TypeCategory typeCategory) {
    return typeCategory.name;
  }

  Widget buildBody({@required HomePageBloc bloc, TypeCategory typeCategory}) {
    return StreamBuilder<List<TaskModel>>(
        stream: bloc.getListTaskModel,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          }

          switch (typeCategory) {
            case TypeCategory.all:
              listTask = snapshot.data;
              break;

            case TypeCategory.completed:
              listTask = [];
              for (TaskModel item in snapshot.data) {
                if (item.isComplete == true) {
                  listTask.add(item);
                }
              }
              break;

            case TypeCategory.inComplete:
              listTask = [];
              for (TaskModel item in snapshot.data) {
                if (item.isComplete == false) {
                  listTask.add(item);
                }
              }
              break;
          }

          return listTask.length > 0 ? new ListView.builder(
              padding: const EdgeInsets.all(SizeUtil.padding8),
              itemCount: listTask.length,
              itemBuilder: (BuildContext context, int index) {
                return new CheckboxListTile(
                    title: new Text(listTask[index].title),
                    value: listTask[index].isComplete,
                    onChanged: (bool onChangeValue) async {
                      String value = await SharedPreferenceUtil()
                          .getStringSharePreference(
                              key: WordsUtil.keySaveListCompleted);
                      if (value != null) {
                        final List<TaskModel> listTaskLocal =
                            TaskModel.decode(value);
                        if (onChangeValue == true) {
                          listTaskLocal.add(new TaskModel(
                              id: listTask[index].id,
                              title: listTask[index].title,
                              isComplete: onChangeValue));
                        } else {
                          for (int i = 0; i < listTaskLocal.length; i++) {
                            if (listTaskLocal[i].id == listTask[index].id) {
                              listTaskLocal.removeAt(i);
                            }
                          }
                        }

                        final String encodedData =
                            TaskModel.encode(listTaskLocal);

                        SharedPreferenceUtil().setStringSharePreference(
                            key: WordsUtil.keySaveListCompleted,
                            value: encodedData);
                      } else {
                        final String encodedData = TaskModel.encode([
                          TaskModel(
                              id: listTask[index].id,
                              title: listTask[index].title,
                              isComplete: onChangeValue)
                        ]);

                        SharedPreferenceUtil().setStringSharePreference(
                            key: WordsUtil.keySaveListCompleted,
                            value: encodedData);
                      }
                      bloc.updateIsCompleted(taskModel: listTask[index]);
                    });
              }) : Center(
                child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Icon(Icons.assignment_outlined, color: Colors.black,size: SizeUtil.sizeImageDoNotHave,),
                Text('${WordsUtil.doNotHaveTask}', style: TextStyle(fontSize: SizeUtil.sizeTextDoNotHave),)
            ],
          ),
              );
        });
  }
}
