import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do/firebase%20utils/firebase_utils.dart';
import 'package:to_do/home/task_list/task_list_item.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/theme.dart';

class TaskListTab extends StatefulWidget {
  TaskListTab({super.key});

  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      getAllTasks();
    }
    return Container(
      color: MyTheme.backgroundColor,
      child: Column(
        children: [
          EasyDateTimeLine(
            locale: 'en',
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              //`selectedDate` the new date selected.
            },
            headerProps: const EasyHeaderProps(
              monthPickerType: MonthPickerType.switcher,
              dateFormatter: DateFormatter.fullDateDMY(),
            ),
            dayProps: const EasyDayProps(
              dayStructure: DayStructure.dayStrDayNum,
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff3371FF),
                      Color(0xff8426D6),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskListItem(
                      task: tasks[index],
                    );
                  })),
        ],
      ),
    );
  }

  void getAllTasks() async {
    var taskCollectionRef = FireBaseUtils.getCollectionRef();
    QuerySnapshot<Task> querySnapshots = await taskCollectionRef.get();
    tasks = querySnapshots.docs.map((docs) {
      return docs.data();
    }).toList();
    setState(() {});
  }
}
