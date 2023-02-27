import 'package:flutter/material.dart';
import 'package:mindful_state/settings_page.dart';

import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

// todo: move to .env file
const String API_KEY = "1de7ad2a308533972c23dfef0fe9693a";

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

  double moodValue = 1;
  double energyValue = 1;

  Position? position;
  WeatherFactory wf = WeatherFactory(API_KEY);
  // late Weather weather;
  Future<Weather>? weather;

  // recommendation algorithm here
  void getActivity() {
    // ignore: avoid_print
    print(moodValue);
    // ignore: avoid_print
    print(energyValue);

    // print(weather.sunset);
    // print(weather.tempFeelsLike);
    // print(weather.weatherIcon);
    // print(weather.weatherDescription);
    // print(weather.weatherMain);

    // look through activities in the database (or index ideally)
  }

  /// Determine the current position of the device.
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print(serviceEnabled);
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    print(permission);
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('denied');
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<Weather> _getWeather(wf, lat, lon) async {
    // ignore: avoid_print
    print('$lat $lon');
    return wf.currentWeatherByLocation(lat, lon);
  }

  @override
  initState() {
    super.initState();
    _determinePosition().then((value) {
      // ignore: avoid_print
      print(value);
      setState(() {
        position = value;
      });
      return position;
    }).then((pos) {
      // _getWeather(wf, pos!.latitude, pos.longitude).then((resp) {
      //   // ignore: avoid_print
      //   print(resp);
      //   setState(() {
      //     weather = resp;
      //   });
      // });
      setState(() {
        weather = _getWeather(wf, pos!.latitude, pos.longitude);
      });
    });
  }

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
    const userName = 'user';
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
                padding: const EdgeInsets.only(left: 10),
                child: const CircleAvatar(
                  backgroundImage: AssetImage('images/user_avatar.jpg'),
                  radius: 15,
                ),
              ),
            ],
          ),
        ),
        title: Text('Mindful State')
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
            // const SizedBox(height: 20), // add some top padding
            Container(
                    // margin: const EdgeInsets.symmetric(horizontal: 40.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 40.0),
                    color: Theme.of(context).colorScheme.shadow,
                    child: FutureBuilder<Weather>(
                      future: weather,
                      initialData: null,
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<Weather> snapshot,
                      ) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(),
                              Visibility(
                                visible: snapshot.hasData,
                                child: const Text(
                                  'Loading',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 24),
                                ),
                              )
                            ],
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const Text('Error');
                          } else if (snapshot.hasData) {
                            return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                            '${snapshot.data!.temperature!.fahrenheit!.round()}\u2109',
                                            style: const TextStyle(fontSize: 30),
                                          ),
                                  const SizedBox(width: 5),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                          'http://openweathermap.org/img/w/${snapshot.data!.weatherIcon}.png'),
                                    ],
                                  ),

                                    ],
                                  ),
                                  
                                  
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${snapshot.data!.weatherMain ?? 'Loading...'}',
                                            style: const TextStyle(fontSize: 18),
                                          ),
                                          Text('${snapshot.data!.areaName}'),
                                        ],
                                      ),
                              
                                ]);
                          } else {
                            return const Text('Empty data');
                          }
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
            const SizedBox(height: 20), // add some top padding

            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          greeting,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          userName,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                 
            ),
            const SizedBox(height: 20), // add some spacing
            Container(
              alignment: Alignment.center,
              child: const Text(
                'how are you feeling today?',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10), // add some spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.sentiment_very_dissatisfied,
                                    size: 30.0

                ),
                SizedBox(
                  // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  width: 250,
                  child: Expanded(
                    child: Slider(
                      value: moodValue,
                      min: 1,
                      max: 5,
                      divisions: 4, // divisions = num possible values - 1
                      label: moodValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          moodValue = value;
                        });
                      },
                    ),
                  ),
                ),
                const Icon(
                  Icons.sentiment_very_satisfied,
                  size: 30.0
                ),
              ],
            ),
            const SizedBox(height: 10), // add some spacing
            Container(
              alignment: Alignment.center,
              child: const Text(
                'how much energy do you have today?',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.bed,
                                    size: 30.0

                ),
                SizedBox(
                  width: 250,
                  child: Expanded(
                    child: Slider(
                      value: energyValue,
                      min: 1,
                      max: 5,
                      divisions: 4, // divisions = num possible values - 1
                      label: energyValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          energyValue = value;
                        });
                      },
                    ),
                  ),
                ),
                const Icon(
                  Icons.bolt,                  size: 30.0

                ),
              ],
            ),
            const SizedBox(height: 10), // add some spacing
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.background,
                elevation: 1,
              ),
              onPressed: getActivity,
              child: const Text("give me an activity"),
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
