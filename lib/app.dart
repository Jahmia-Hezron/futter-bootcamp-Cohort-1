import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:script_05_task_tracker_app/methods/log_out_method.dart';

import 'screens/screens_export.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  int pageIndex = 0;
  String pageTitle = 'Active Tasks';
  bool modeChecker = false;
  IconData darkIcon = Icons.nights_stay_rounded;
  IconData lightIcon = Icons.wb_sunny_rounded;

  nextPage(index) {
    setState(() {
      pageIndex = index;
      pageIndex == 1
          ? pageTitle = 'Completed Tasks'
          : pageTitle = 'Active Tasks';
    });
  }

  ThemeData lightTheme = ThemeData(
    // This is the theme of your application.
    //
    // TRY THIS: Try running your application with "flutter run". You'll see
    // the application has a blue toolbar. Then, without quitting the app,
    // try changing the seedColor in the colorScheme below to Colors.green
    // and then invoke "hot reload" (save your changes or press the "hot
    // reload" button in a Flutter-supported IDE, or press "r" if you used
    // the command line to start the app).
    //
    // Notice that the counter didn't reset back to zero; the application
    // state is not lost during the reload. To reset the state, use hot
    // restart instead.
    //
    // This works for code too, not just values: Most code changes can be
    // tested with just a hot reload.
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: Colors.blueAccent,
    ),
    useMaterial3: true,
  );

  ThemeData darkTheme = ThemeData(
    // This is the theme of your application.
    //
    // TRY THIS: Try running your application with "flutter run". You'll see
    // the application has a blue toolbar. Then, without quitting the app,
    // try changing the seedColor in the colorScheme below to Colors.green
    // and then invoke "hot reload" (save your changes or press the "hot
    // reload" button in a Flutter-supported IDE, or press "r" if you used
    // the command line to start the app).
    //
    // Notice that the counter didn't reset back to zero; the application
    // state is not lost during the reload. To reset the state, use hot
    // restart instead.
    //
    // This works for code too, not just values: Most code changes can be
    // tested with just a hot reload.
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Colors.purpleAccent,
    ),
    useMaterial3: true,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: modeChecker ? darkTheme : lightTheme,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              pageTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    modeChecker = !modeChecker;
                  });
                },
                icon: Icon(modeChecker ? darkIcon : lightIcon),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const LogOutDialogue();
                      });
                },
                icon: const Icon(CupertinoIcons.person_crop_circle),
              ),
            ],
          ),
          body: IndexedStack(
            index: pageIndex,
            children: const [
              ActiveTasks(),
              FinishedTasks(),
            ],
          ),
          bottomNavigationBar: SizedBox(
            height: 75,
            child: BottomNavigationBar(
              onTap: nextPage,
              currentIndex: pageIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_customize_outlined),
                  activeIcon: Icon(Icons.dashboard_customize),
                  label: 'Active Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.format_list_bulleted_sharp),
                  activeIcon: Icon(Icons.list_alt_rounded),
                  label: 'Completed Tasks',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
