import 'dart:convert';

class TaskModel {
  int id;
  String title;
  bool isComplete;

  TaskModel({this.id, this.title, this.isComplete});

  factory TaskModel.fromJson(dynamic json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      isComplete: json['isComplete'],
    );
  }

  static Map<String, dynamic> toMap(TaskModel taskModel) => {
        'id': taskModel.id,
        'title': "${taskModel.title}",
        'isComplete': taskModel.isComplete,
      };

  static String encode(List<TaskModel> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>((music) => TaskModel.toMap(music))
            .toList(),
      );

  static List<TaskModel> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<TaskModel>((item) => TaskModel.fromJson(item))
          .toList();
}
