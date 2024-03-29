import 'package:geolocator/geolocator.dart';
import 'package:mindful_state/services/activity.dart';
import 'package:weather/weather.dart';

import 'activities_tab.dart';
import 'services/weather_service.dart';
import 'home_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindful_state/settings_page.dart';

import 'services/db.dart';

// Define a stateful widget called HomePage
class HomePage extends StatefulWidget {
  final User? user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  // Return a new state object
  @override
  State<HomePage> createState() => _HomePageState();
}

List<Map<String, dynamic>> myData = [];

// Define the state of the HomePage
class _HomePageState extends State<HomePage> {
  Position? position;
  Future<Weather>? weather;
  // recommended activities (empty at first)
  late List<Activity> activities = [];

// calls WeatherService to get current position and weather
  @override
  initState() {
    super.initState();
    // get position
    WeatherService.getCurrentPosition().then((value) {
      setState(() {
        position = value;
      });
      return position;
    })
        // get weather
        .then((pos) {
      setState(() {
        weather =
            WeatherService.getCurrentWeather(pos!.latitude, pos.longitude);
        print(weather);
      });
    });
    _refreshData();
  }

// refreshes data from database
  void _refreshData() async {
    await Database.db();
    final data = await Database.getItems();
    setState(() {
      myData = data;
    });
  }

  // navigates to activities tab with recommendation data
  void toActivitiesTab(List<Activity> activitiesSorted) {
    setState(() {
      currentPageIndex = 1;
      activities = activitiesSorted;
    });
  }

  // STATE VARIABLES
  // -----------------------------------------------------------------------
  // Initialize a variable to keep track of the currently selected page
  int currentPageIndex = 0;

  // A key to uniquely identify the scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // -----------------------------------------------------------------------

  // Build the HomePage widget
  @override
  Widget build(BuildContext context) {
    String userName = widget.user?.displayName ?? 'BYPASS';
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
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: widget.user != null && widget.user?.photoURL != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(widget.user!.photoURL!),
                          radius: 15,
                        )
                      : const CircleAvatar(
                          backgroundImage: AssetImage('images/user_avatar.jpg'),
                          radius: 15,
                        ),
                ),
              ],
            ),
          ),
          // title of app
          title: const Text('Mindful State')),
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
          // NavigationDestination(
          //   selectedIcon: Icon(
          //     Icons.health_and_safety,
          //   ),
          //   icon: Icon(
          //     Icons.health_and_safety_outlined,
          //   ),
          //   label: 'Health',
          // ),
        ],
      ),
      // Define the body of the scaffold based on the selected page index
      body: <Widget>[
        HomeTab(
            weather: weather,
            activityData: myData,
            toActivitiesTab: toActivitiesTab,
            userName: userName),
        ActivitiesTab(activities: activities),
        Container(
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
            DrawerHeader(
              // Display the user's avatar in the drawer header
              child: CircleAvatar(
                backgroundImage: widget.user?.photoURL != null
                    ? NetworkImage(
                        widget.user!.photoURL!,
                      )
                    : const AssetImage('images/user_avatar.jpg')
                        as ImageProvider,
                radius: 50,
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
