import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scopedmodel/week_list_model.dart';
import '../models/week_model.dart';
import '../utils/color_utils.dart';
import '../component/week_badge.dart';
import '../models/hero_id_model.dart';

class AddTodoScreen extends StatefulWidget {
  final String taskId;
  final HeroId heroIds;

  AddTodoScreen({
    @required this.taskId,
    @required this.heroIds,
  });

  @override
  State<StatefulWidget> createState() {
    return _AddTodoScreenState();
  }
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  String newTask;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      newTask = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<WeekListModel>(
      builder: (BuildContext context, Widget child, WeekListModel model) {
        if (model.programs.isEmpty) {
          // Loading
          return Container(
            color: Colors.white,
          );
        }

        var _program = model.programs.firstWhere((it) => it.id == widget.taskId);
        var _color = ColorUtils.getColorFrom(id: _program.color);
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'New Program',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black26),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
          ),
          body: Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What program are you planning to perfrom?',
                  style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0),
                ),
                Container(
                  height: 16.0,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() => newTask = text);
                  },
                  cursorColor: _color,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Your Program...',
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    )),
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 36.0),
                ),
                Container(
                  height: 26.0,
                ),
                Row(
                  children: [
                    TodoBadge(
                      codePoint: _program.codePoint,
                      color: _color,
                      id: widget.heroIds.codePointId,
                      size: 20.0,
                    ),
                    Container(
                      width: 16.0,
                    ),
                    Hero(
                      child: Text(
                        _program.name,
                        style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      tag: "not_using_right_now", //widget.heroIds.titleId,
                    ),
                  ],
                )
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton.extended(
                heroTag: 'fab_new_program',
                icon: Icon(Icons.add),
                backgroundColor: _color,
                label: Text('Create Program'),
                onPressed: () {
                  if (newTask.isEmpty) {
                    final snackBar = SnackBar(
                      content: Text(
                        'Ummm... It seems that you are trying to add an invisible program which is not allowed in this realm.'),
                      backgroundColor: _color,
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                    // _scaffoldKey.currentState.showSnackBar(snackBar);
                  } else {
                    // model.addWeek(Week( newTask, program: _program.id, seq: 8));
                    Navigator.pop(context);
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}

// Reason for wraping fab with builder (to get scafold context)
// https://stackoverflow.com/a/52123080/4934757
