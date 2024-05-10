import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/home/task_list/widgets/custom_text_field.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/providers/list_provider.dart';
import 'package:to_do/theme.dart';

class EditTaskView extends StatefulWidget {
  EditTaskView({super.key, required this.task});
  Task task;
  static String routeName = 'EditTaskView';
  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  // AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  // GlobalKey<FormState> formKey = GlobalKey();
  late DateTime? choosedDate;
  String? title, desc;
  @override
  Widget build(BuildContext context) {
    ListProvider provider = Provider.of<ListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.20,
        title: Text(
          'ToDo List',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: MyTheme.whiteColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: MyTheme.primaryColor)),
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .7,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Edit Task',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: MyTheme.blackColor,
                          fontSize: 18,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  hintText: widget.task.title!,
                  onChanged: (value) {
                    title = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  hintText: widget.task.description!,
                  onChanged: (value) {
                    desc = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Select Date',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: MyTheme.blackColor,
                          fontSize: 18,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: InkWell(
                    onTap: () async {
                      await showCalender(context);
                    },
                    child: Center(
                      child: Text(
                        DateFormat('dd-MM-yyyy').format(widget.task.date!),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: MyTheme.blackColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyTheme.primaryColor,
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  onPressed: () {
                    provider.updateUser(widget.task, title, desc, choosedDate);
                    provider.getAllTasks();
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Save Changes',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showCalender(BuildContext context) async {
    choosedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: DateTime.now(),
    );
    if (choosedDate != null) {
      widget.task.date = choosedDate;
      setState(() {});
    }
  }
}
