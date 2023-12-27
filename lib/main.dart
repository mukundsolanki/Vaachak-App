import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'pages/connect_screen.dart';
import 'pages/learn_screen.dart';
import 'pages/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 255, 255)),
       
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'VAACHAK'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  final screens = [
    HomeScreen(),
    ConnectScreen(),
    LearnScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
      ),
      body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor:  Colors.white,
           indicatorColor:  Colors.grey[400],
            labelTextStyle: MaterialStateProperty.all(
              TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
            ),
          ),
          child: NavigationBar(
              selectedIndex: index,
              onDestinationSelected: (index) =>
              {setState(() => this.index = index)},
              destinations: [
                NavigationDestination(
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                  ),
                  label: 'Home',
                  selectedIcon: Icon(
                    Icons.home_filled,
                    color: Colors.black,
                  ),
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.connect_without_contact_outlined,
                    color: Colors.black,
                  ),
                  label: 'Connect',
                  selectedIcon: Icon(
                    Icons.connect_without_contact,
                    color: Colors.black,
                  ),
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.language_outlined,
                    color: Colors.black,
                  ),
                  label: 'Learnings',
                  selectedIcon: Icon(
                    Icons.language,
                    color: Colors.black,
                  ),
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.settings_outlined,
                    color: Colors.black,
                  ),
                  label: 'Settings',
                  selectedIcon: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                ),
              ]),
        ),




    );
  }
}
