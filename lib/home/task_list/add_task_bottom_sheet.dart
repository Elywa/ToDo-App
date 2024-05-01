import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do/home/task_list/custom_text_form_field.dart';
import 'package:to_do/theme.dart';


class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  late String title, description;
  var selectedDate = DateTime.now();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      height: 550,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add New Task',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: MyTheme.blackColor, fontSize: 18),
                ),
              ],
            ),
            CustomTextFormField(
              hintText: 'Enter Task title',
              onChanged: (value) {
                title = value;
              },
            ),
            CustomTextFormField(
              hintText: 'Enter Task decription',
              maxLines: 4,
              onChanged: (value) {
                title = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                'Select Date',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: MyTheme.blackColor,
                      fontSize: 18,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: InkWell(
                onTap: () {
                  showCalender();
                },
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    DateFormat('dd-MM-yyyy').format(selectedDate),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: MyTheme.blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyTheme.primaryColor,
                  minimumSize: Size(double.infinity, 40),
                ),
                onPressed: () {
                  addTask();
                },
                child: Text(
                  'Add',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addTask() {
    if (formKey.currentState!.validate()) {}
  }

  void showCalender() async {
    var choosedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: DateTime.now(),
    );
    if (choosedDate != null) {
      selectedDate = choosedDate;
      setState(() {});
    }
  }
}
