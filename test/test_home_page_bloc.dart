
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_manabie/bloc/home_page_bloc.dart';
import 'package:todo_manabie/pages/home_page/model/task_model.dart';
import 'package:todo_manabie/util/enum_util.dart';

void main(){

  test('setIndexNavigationBar type all', (){
    var result = HomePageBloc().setIndexNavigationBar(typeCategory: TypeCategory.all);
    expect(result, true);
  });

  test('setIndexNavigationBar type completed', (){
    var result = HomePageBloc().setIndexNavigationBar(typeCategory: TypeCategory.completed);
    expect(result, true);
  });

  test('setIndexNavigationBar type incomplete', (){
    var result = HomePageBloc().setIndexNavigationBar(typeCategory: TypeCategory.inComplete);
    expect(result, true);
  });

  test('setListTaskModel', (){
    var result = HomePageBloc().setListTaskModel([]);
    expect(result, true);
  });

  test('updateIsCompleted', (){
    var result = HomePageBloc().updateIsCompleted(taskModel: new TaskModel(id: 1, title: 'Task 2', isComplete: true));
    expect(result, false);
  });

  test('dispose', (){
    var result = HomePageBloc().dispose();
    expect(result, true);
  });


  
}