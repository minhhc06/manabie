import 'package:flutter/material.dart';
import 'package:todo_manabie/pages/home_page/home_page.dart';
import 'package:todo_manabie/util/assets_path_util.dart';
import 'package:todo_manabie/util/colors_util.dart';
import 'package:todo_manabie/util/convert_color_util.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(seconds: 2),
          () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConvertColorUtil(ColorsUtil.blueColorApp),

      body: Center(
        child: Container(
          child: Image.asset(
            '${AssetPathUtil.bgAppBar}',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
