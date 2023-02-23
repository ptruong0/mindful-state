import 'package:flutter/material.dart';
import 'package:mindful_state/settings_page.dart';

// Define a stateful widget called HomePage
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // Return a new state object
  @override
  State<HomePage> createState() => _HomePageState();
}

// Define the state of the HomePage
class _HomePageState extends State<HomePage> {
  // Initialize a variable to keep track of the currently selected page
  int currentPageIndex = 0;

  // A key to uniquely identify the scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Build the HomePage widget
  @override
  Widget build(BuildContext context) {
    // Get current time for greeting
    final now = DateTime.now();
    final currentTimeOfDay = now.hour;

    // Greeting to display
    String greeting;
    if (currentTimeOfDay >= 5 && currentTimeOfDay < 12) {
      greeting = 'good morning';
    } else if (currentTimeOfDay >= 12 && currentTimeOfDay < 18) {
      greeting = 'good afternoon';
    } else {
      greeting = 'good evening';
    }

    // temporary placeholder for user name
    final userName = 'user';
    // Return a Scaffold widget
    return Scaffold(
      key: _scaffoldKey, // Use the scaffold key to identify the scaffold
      appBar: AppBar(
        // Use a gesture detector to allow the user to open the drawer
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          // Display the user's avatar as the leading widget in the app bar
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            child: const CircleAvatar(
              backgroundImage: AssetImage('images/user_avatar.jpg'),
              radius: 15,
            ),
          ),
        ),
      ),
      // Define the bottom navigation bar
      bottomNavigationBar: NavigationBar(
        // Update the current page when a new destination is selected
        onDestinationSelected: (int index) {
          setState(
            () {
              currentPageIndex = index;
            },
          );
        },
        // Use the current page index to determine the selected destination
        selectedIndex: currentPageIndex,
        // Define the destinations in the navigation bar
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
            ),
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.local_activity,
            ),
            icon: Icon(
              Icons.local_activity_outlined,
            ),
            label: 'Activities',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.health_and_safety,
            ),
            icon: Icon(
              Icons.health_and_safety_outlined,
            ),
            label: 'Health',
          ),
        ],
      ),
      // Define the body of the scaffold based on the selected page index
      body: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 50), // add some top padding
            Container(
              alignment: Alignment.center,
              child: Text(
                greeting,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 10), // add some spacing
            Container(
              alignment: Alignment.center,
              child: Text(
                userName,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 100), // add some spacing
            Container(
              alignment: Alignment.center,
              child: const Text(
                'how are you feeling today?',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
        Container(
          // TODO: finish contents for second page
          // ideally this page will call google maps API and recommend local
          // activities that we will rank based on user's mood
          alignment: Alignment.center,
          child: const Text(
            'Page 2',
          ),
        ),
        Container(
          // TODO: finish contents for third page
          // ideally this page will display data gathered from user
          // such as mood, stats, and weather?
          alignment: Alignment.center,
          child: const Text(
            'Page 3',
          ),
        ),
      ][currentPageIndex],
      // Define the drawer of the scaffold
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              // Display the user's avatar in the drawer header
              child: CircleAvatar(
                backgroundImage: AssetImage('images/user_avatar.jpg'),
              ),
            ),
            // Define a list tile for the settings page
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(
                'Settings',
              ),
              onTap: () {
                // Navigate to the settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MaterialSettings(),
                  ),
                );
              },
            ),
            // Define a list tile for the about page
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
