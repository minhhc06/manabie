import 'package:todo_manabie/util/words_util.dart';

enum TypeCategory{
  all,
  completed,
  inComplete
}

extension TypeExtension on TypeCategory {

  String get name {
    switch (this) {
      case TypeCategory.all:
        return '${WordsUtil.all}';
      case TypeCategory.completed:
        return '${WordsUtil.completeTasks}';
      case TypeCategory.inComplete:
        return '${WordsUtil.incompleteTasks}';
      default:
        return null;
    }
  }

  int get index {
    switch (this) {
      case TypeCategory.all:
        return 0;
      case TypeCategory.completed:
        return 1;
      case TypeCategory.inComplete:
        return 2;
      default:
        return null;
    }
  }

}