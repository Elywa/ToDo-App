import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:to_do/auth/login/login_view.dart';
import 'package:to_do/firebase%20utils/firebase_utils.dart';
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
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.20,
        title: Text(
          'ToDo App(${user.currentUser?.name! ?? ''})',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              // debugPrint('=============== ${user.currentUser!.name!}');
              // listProvider.tasks = [];
              // user.currentUser = null;
              //Navigator.pushReplacementNamed(context, LoginView.routeName);
              showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  });
              user.currentUser = null;
              listProvider.tasks = [];
              FireBaseUtils.signOut();
              Navigator.of(context).pop();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return LoginView();
              }));
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
        height: 73,
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
                icon: Icon(
                  Icons.list,
                  size: 15,
                ),
                label: 'List',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  size: 15,
                ),
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
