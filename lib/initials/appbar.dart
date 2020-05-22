import 'package:flutter/material.dart';
import 'package:solens/constants/appbarChoice.dart';


  Widget AppBarMain(Function select, List<Choice> choices) {
    return AppBar(
      title: Image.asset('assets/images/logo.png',
          height: 80.0,
          width: 100.0
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(choices[1].icon),
            onPressed: null
        ),
        PopupMenuButton<Choice>(
            onSelected: select,
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(choice.icon, color: Colors.black26),
                      Text(choice.title)
                    ],
                  ),
                );
              }
              ).toList();
            }),
      ],
    );
  }




