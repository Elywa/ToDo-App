import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firebase%20utils/firebase_utils.dart';
import 'package:to_do/functions.dart';
import 'package:to_do/home/task_list/widgets/custom_text_form_field.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/providers/list_provider.dart';
import 'package:to_do/providers/theme_provider.dart';
import 'package:to_do/providers/user_provider.dart';
import 'package:to_do/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  late String title, description;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late ListProvider listProvider;

  var selectedDate = DateTime.now();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      margin: const EdgeInsets.all(20),
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      // width: double.infinity,
      // height: MediaQuery.of(context).size.height * .5,
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: autovalidateMode,
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.add_new_task,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: MyTheme.blackColor, fontSize: 18),
                  ),
                ],
              ),
              CustomTextFormField(
                validator: (data) {
                  if (data == null || data.isEmpty) {
                    return AppLocalizations.of(context)!.field_is_required;
                  } else {
                    return null;
                  }
                },
                hintText: AppLocalizations.of(context)!.task_title_hint_text,
                onChanged: (value) {
                  title = value;
                },
              ),
              CustomTextFormField(
                validator: (data) {
                  if (data == null || data.isEmpty) {
                    return AppLocalizations.of(context)!.field_is_required;
                  } else {
                    return null;
                  }
                },
                hintText: AppLocalizations.of(context)!.task_desc_hint_text,
                maxLines: 4,
                onChanged: (value) {
                  description = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  AppLocalizations.of(context)!.select_date,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: themeProvider.isDark()
                            ? MyTheme.whiteColor
                            : MyTheme.blackColor,
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('dd-MM-yyyy').format(selectedDate),
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: themeProvider.isDark()
                                        ? MyTheme.whiteColor
                                        : MyTheme.blackColor,
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
                    AppLocalizations.of(context)!.add_button,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addTask() async {
    var user = Provider.of<UserProvider>(context, listen: false);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await FireBaseUtils.addTask(
          Task(title: title, description: description, date: selectedDate),
          user.currentUser!.id!);

      listProvider.getAllTasks(user.currentUser!.id!);
      Navigator.pop(context);
      showSnackBar(
        context,
        AppLocalizations.of(context)!.task_added_successfully_snack_bar,
      );
    } else {
      //هنا عشان يفضل يظهر لليوزر مسدج بالايرور
      autovalidateMode = AutovalidateMode.always;
      setState(() {});
    }
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
