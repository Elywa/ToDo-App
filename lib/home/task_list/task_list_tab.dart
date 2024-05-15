import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:to_do/home/task_list/task_list_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/providers/language_provider.dart';
import 'package:to_do/providers/list_provider.dart';
import 'package:to_do/providers/user_provider.dart';
import 'package:to_do/theme.dart';

class TaskListTab extends StatefulWidget {
  TaskListTab({super.key});

  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var user = Provider.of<UserProvider>(context);
    var appLanguage = Provider.of<LanguageProvider>(context);
    if (listProvider.tasks.isEmpty) {
      listProvider.getAllTasks(user.currentUser!.id!);
    }

    return Column(
      children: [
        EasyDateTimeLine(
          locale: appLanguage.appLanguage,
          initialDate: listProvider.selectedDate,
          onDateChange: (selectedDate) {
            listProvider.cahngeSelectedDate(
                selectedDate, user.currentUser!.id!);
            print(listProvider.selectedDate);
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
          child: listProvider.tasks.isEmpty
              ? Center(
                  child: Text(
                  AppLocalizations.of(context)!.no_tasks,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: MyTheme.primaryColor),
                ))
              : ListView.builder(
                  itemCount: listProvider.tasks.length,
                  itemBuilder: (context, index) {
                    return TaskListItem(
                      task: listProvider.tasks[index],
                    );
                  },
                ),
        ),
      ],
    );
  }
}
