import 'package:flutter/material.dart';
import 'package:todo_manabie/pages/splash_page/splash_page.dart';

import 'util/words_util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${WordsUtil.toDoManabie}',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}

