
import 'package:flutter/material.dart';
import 'package:to_do/theme.dart';



class TaskListItem extends StatelessWidget {
  const TaskListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .15,
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
                    'Task Title',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: MyTheme.primaryColor),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Task decription',
                        style: Theme.of(context).textTheme.titleMedium),
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
