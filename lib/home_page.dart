import 'package:flutter/material.dart';
import 'package:mindful_state/settings_page.dart';
import 'package:dynamic_color/dynamic_color.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.deepPurple[300],
        ),
        // Enable Material 3 (Material You) design.
        useMaterial3: true,
      ),
      home: const MaterialNavigationBar(),
    );
  }
}

class MaterialNavigationBar extends StatefulWidget {
  const MaterialNavigationBar({super.key});

  @override
  State<MaterialNavigationBar> createState() => _MaterialNavigationBarState();
}

class _MaterialNavigationBarState extends State<MaterialNavigationBar> {
  int currentPageIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            child: const CircleAvatar(
              backgroundImage: AssetImage('images/user_avatar.jpg'),
              radius: 15,
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.deepPurple[200],
        onDestinationSelected: (int index) {
          setState(
            () {
              currentPageIndex = index;
            },
          );
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              child: CircleAvatar(
                backgroundImage: AssetImage('images/user_avatar.jpg'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(
                'Settings',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MaterialSettings(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                // navigation to the about page
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}