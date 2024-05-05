import 'package:flutter/material.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/theme.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({super.key, required this.task});
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .17,
      margin: const EdgeInsets.all(10),
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
              color: MyTheme.primaryColor,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ListTile(
                  title: Text(
                    task.title ?? 'Unknown',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: MyTheme.primaryColor),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      task.description ?? 'Unknown',
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                    ),
                  ),
                  trailing: Container(
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: MyTheme.primaryColor,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
