import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.deepPurple[200],
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.laptop,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.laptop_outlined,
              color: Colors.white,
            ),
            label: 'Journal',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.local_activity,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.local_activity_outlined,
              color: Colors.white,
            ),
            label: 'Activities',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          color: Colors.deepPurple[300],
          alignment: Alignment.center,
          child: const Text(
            'Page 1',
          ),
        ),
        Container(
          color: Colors.deepPurple[300],
          alignment: Alignment.center,
          child: const Text(
            'Page 2',
          ),
        ),
        Container(
          color: Colors.deepPurple[300],
          alignment: Alignment.center,
          child: const Text(
            'Page 3',
          ),
        ),
      ][currentPageIndex],
    );
  }
}
