import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firebase%20utils/firebase_utils.dart';

import 'package:to_do/models/task_model.dart';
import 'package:to_do/providers/list_provider.dart';
import 'package:to_do/theme.dart';

class TaskListItem extends StatefulWidget {
  const TaskListItem({super.key, required this.task});
  final Task task;

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Slidable(
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: .25,
          // A motion is a widget used to control how the pane animates.
          motion: const DrawerMotion(),

          // A pane can dismiss the Slidable.

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.circular(16),
              onPressed: (context) {
                FireBaseUtils.deleteTask(widget.task).timeout(
                  const Duration(milliseconds: 500),
                  onTimeout: () {
                    print('Task Deleted Successfully');
                    listProvider.getAllTasks();
                  },
                );
              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: MyTheme.whiteColor,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),

        // The end action pane is the one at the right or the bottom side.
        // endActionPane: const ActionPane(
        //   motion: ScrollMotion(),
        //   children: [
        //     SlidableAction(
        //       // An action can be bigger than the others.
        //       flex: 2,
        //       onPressed: doNothing,
        //       backgroundColor: Color(0xFF7BC043),
        //       foregroundColor: Colors.white,
        //       icon: Icons.archive,
        //       label: 'Archive',
        //     ),
        //     SlidableAction(
        //       onPressed: doNothing,
        //       backgroundColor: Color(0xFF0392CF),
        //       foregroundColor: Colors.white,
        //       icon: Icons.save,
        //       label: 'Save',
        //     ),
        //   ],
        // ),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .135,
          padding: const EdgeInsets.only(
            top: 15,
            left: 8,
            //bottom: 24,
          ),
          decoration: BoxDecoration(
            color: MyTheme.whiteColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .13,
                child: VerticalDivider(
                  thickness: 4,
                  indent: 5,
                  endIndent: 15,
                  color: widget.task.isDone!
                      ? MyTheme.greenColor
                      : MyTheme.primaryColor,
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    widget.task.title ?? 'Unknown',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: widget.task.isDone!
                              ? MyTheme.greenColor
                              : MyTheme.primaryColor,
                        ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      widget.task.description ?? 'Unknown',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: widget.task.isDone!
                                ? MyTheme.greenColor
                                : MyTheme.blackColor,
                          ),
                      maxLines: 1,
                    ),
                  ),
                  trailing: InkWell(
                    onTap: () {
                      FireBaseUtils.updateTaskeIsDone(widget.task).timeout(
                        const Duration(milliseconds: 500),
                        onTimeout: () {
                          setState(() {
                            widget.task.isDone = !widget.task.isDone!;
                          });
                          listProvider.getAllTasks();
                          setState(() {});
                          debugPrint('${widget.task.isDone}');
                        },
                      );
                    },
                    child: widget.task.isDone!
                        ? Container(
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: MyTheme.whiteColor,
                            ),
                            child: const Center(
                              child: Text(
                                'Done!',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: 60,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: MyTheme.primaryColor,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
