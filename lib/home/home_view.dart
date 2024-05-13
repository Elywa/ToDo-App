import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/auth/login/login_view.dart';
import 'package:to_do/home/settings/settings_tab.dart';
import 'package:to_do/home/task_list/add_task_bottom_sheet.dart';
import 'package:to_do/home/task_list/task_list_tab.dart';
import 'package:to_do/providers/list_provider.dart';
import 'package:to_do/providers/user_provider.dart';
import 'package:to_do/theme.dart';

class HomeView extends StatefulWidget {
  static const String routeName = 'HomeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.20,
        title: Text(
          'ToDo App(${user.currentUser!.name!})',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              user.currentUser = null;
              listProvider.tasks = [];

              Navigator.pushReplacementNamed(context, LoginView.routeName);
            },
            icon: Icon(
              Icons.logout,
              size: 30,
              color: MyTheme.whiteColor,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * .108,
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'List',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Setting',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const AddTaskBottomSheet();
              });
        },
        child: Icon(
          Icons.add,
          size: 40,
          color: MyTheme.whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: widgets[selectedIndex],
    );
  }

  List<Widget> widgets = [
    TaskListTab(),
    const SettingsTab(),
  ];
}
