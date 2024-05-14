import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firebase%20utils/firebase_utils.dart';
import 'package:to_do/functions.dart';
import 'package:to_do/home/task_list/edit_task_view.dart';

import 'package:to_do/models/task_model.dart';
import 'package:to_do/providers/list_provider.dart';
import 'package:to_do/providers/user_provider.dart';
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
    var user = Provider.of<UserProvider>(context);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .25,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16)),
              onPressed: (context) async {
                await FireBaseUtils.deleteTask(
                    widget.task, user.currentUser!.id!);
                listProvider.getAllTasks(user.currentUser!.id!);
                debugPrint('Task deleted !');
              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: MyTheme.whiteColor,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: .25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16)),
              onPressed: (context) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EditTaskView(
                    task: widget.task,
                  );
                }));
              },
              backgroundColor: MyTheme.primaryColor,
              foregroundColor: MyTheme.whiteColor,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      widget.task.description ?? 'Unknown',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: widget.task.isDone!
                                ? MyTheme.greenColor
                                : MyTheme.blackColor,
                          ),
                    ),
                  ),
                  trailing: InkWell(
                    onTap: () {
                      FireBaseUtils.updateTaskeIsDone(
                              widget.task, user.currentUser!.id!)
                          .then((value) {
                        setState(() {
                          widget.task.isDone = !widget.task.isDone!;
                        });
                        listProvider.getAllTasks(user.currentUser!.id!);
                        setState(() {});
                        debugPrint('${widget.task.isDone}');
                      }).timeout(
                        const Duration(milliseconds: 500),
                        onTimeout: () {
                          setState(() {
                            widget.task.isDone = !widget.task.isDone!;
                          });
                          listProvider.getAllTasks(user.currentUser!.id!);
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
