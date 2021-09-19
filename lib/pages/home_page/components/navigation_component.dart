import 'package:flutter/material.dart';
import 'package:todo_manabie/util/colors_util.dart';
import 'package:todo_manabie/util/convert_color_util.dart';
import 'package:todo_manabie/util/enum_util.dart';
import 'package:todo_manabie/util/words_util.dart';


class NavigationComponent{
  Widget bottomNavigationBar(
      { Function(int) onTapFunction,  Stream<TypeCategory> stream }) {
    return StreamBuilder<TypeCategory>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return BottomNavigationBar(
              backgroundColor: ConvertColorUtil(ColorsUtil.blueColorApp),
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.wallet_travel_sharp,

                  ),
                  label: '${WordsUtil.all}',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.done_all,
                  ),
                  label: '${WordsUtil.complete}',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.gps_not_fixed,
                  ),
                  label: '${WordsUtil.incomplete}',
                ),

              ],
              currentIndex: snapshot.data.index,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              onTap: onTapFunction,
            );
          }
          return Container();
        });
  }
}