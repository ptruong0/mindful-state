import 'package:flutter/material.dart';
import 'package:mindful_state/activity.dart';
import 'package:mindful_state/settings_page.dart';

import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Define a stateful widget called HomePage
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // Return a new state object
  @override
  State<HomePage> createState() => _HomePageState();
}

// activity type dropdown content
const List<String> typeList = ['fitness', 'relaxation', 'fun', 'productivity'];

// slider labels
// const List<String> _moodSliderLabels = [
//   'bad',
//   'not good',
//   'ok',
//   'good',
//   'great'
// ];
const List<String> _energySliderLabels = [
  'very low',
  'low',
  'medium',
  'high',
  'very high'
];

// list of weather values that should lead to indoor activity recommendations
const List<String> indoorWeather = ['Rain', 'Snow', 'Extreme'];

// number of activities that will be displayed on the recommendation page
const int numResultsShown = 3;

// Define the state of the HomePage
class _HomePageState extends State<HomePage> {
  // object used to access weather API
  final WeatherFactory wf = WeatherFactory(
      dotenv.env['WEATHER_API_KEY'] ?? ''); // read api key from .env file

  // STATE VARIABLES
  // -----------------------------------------------------------------------
  // Initialize a variable to keep track of the currently selected page
  int currentPageIndex = 0;

  // A key to uniquely identify the scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // value binded to dropdown
  String activityType = 'fitness';

  // values binded to sliders
  // double moodValue = 3;
  double energyValue = 3;

  // location latitude and longitude
  Position? position;

  // weather data, stored in promise
  Future<Weather>? weather;

  // stores top recommended activities list
  List<Activity> activities = [
    Activity(name: 'ride a bike', category: 'fitness', indoors: false),
    Activity(name: 'take a walk', category: 'fitness', indoors: false),
    Activity(name: 'meditate', category: 'relaxation', indoors: true),
    Activity(name: 'read a book', category: 'relaxation', indoors: true)
  ];

  // determines which activity in list is displayed
  int currentActivityIndex = 0;

  // -----------------------------------------------------------------------

  void recommendationSystem(bool indoors) {
    // look through activities in the database (or index ideally)

    // ALGORITHM HERE

    // setState(() {
    //   activities = ...;
    // });
  }

  // todo: recommendation algorithm
  // click handler for generate button
  void getActivity() {
    // print(moodValue);
    print(energyValue);
    print(activityType);
    weather?.then((result) {
      print(result);
      print(result.weatherMain);
      bool indoors = indoorWeather.contains(result.weatherMain);

      recommendationSystem(indoors);

      // then automatically go to activities tab to see results
      setState(() {
        currentPageIndex = 1;
      });
    });
  }

  // determine the current position of the device.
  // returns error when the location services are not enabled or permissions are denied
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // test if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if location services aren't enabled don't continue
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // test if device allows location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // request location permissions from device
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // permissions are denied, can't continue
        return Future.error('Location permissions are denied');
      }
    }

    // permissions allowed, can proceed accessing position
    return await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.high);
  }

  // given coordinates, return weather data for that location
  Future<Weather> _getWeather(wf, lat, lon) async {
    return wf.currentWeatherByLocation(lat, lon);
  }

  // when page loads, fetch position & weather data and store in state
  @override
  initState() {
    super.initState();
    // get position
    _determinePosition().then((value) {
      setState(() {
        position = value;
      });
      return position;
    })
        // get weather
        .then((pos) {
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
      greeting = 'Good morning';
    } else if (currentTimeOfDay >= 12 && currentTimeOfDay < 18) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
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
            // // weather info container
            // Container(
            //   width: MediaQuery.of(context).size.width, // takes up entire screen width
            //   padding:
            //       const EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
            //   color: Theme.of(context).colorScheme.shadow,

            //   // FutureBuilder waits for the weather to load before rendering
            //   child: FutureBuilder<Weather>(
            //     future: weather,
            //     initialData: null,
            //     builder: (
            //       BuildContext context,
            //       AsyncSnapshot<Weather> snapshot,
            //     ) {
            //       //  waiting to retrieve data
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: const [
            //             CircularProgressIndicator(),
            //           ],
            //         ); // loading animation
            //       }
            //       // ready to display info
            //       else if (snapshot.connectionState == ConnectionState.done) {
            //         if (snapshot.hasError) {
            //           return const Text('Error');
            //         } else if (snapshot.hasData) {
            //           return Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Row(
            //                   children: [
            //                     // temperature in Fahrenheit
            //                     Text(
            //                       '${snapshot.data!.temperature!.fahrenheit!.round()}\u2109',
            //                       style: const TextStyle(
            //                           fontSize: 30,
            //                           fontWeight: FontWeight.bold),
            //                     ),
            //                     const SizedBox(width: 5),
            //                     // icon for weather type, retrieved as an image from openweather
            //                     Column(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       children: [
            //                         Image.network(
            //                             'http://openweathermap.org/img/w/${snapshot.data!.weatherIcon}.png'),
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //                 Column(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   crossAxisAlignment: CrossAxisAlignment.end,
            //                   children: [
            //                     // weather type
            //                     Text(
            //                       snapshot.data!.weatherMain ?? 'Loading...',
            //                       style: const TextStyle(fontSize: 18),
            //                     ),
            //                     // city name for weather
            //                     Row(
            //                       children: [
            //                         const Icon(Icons.place, size: 16),
            //                         Text('${snapshot.data!.areaName}'),
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //               ]);
            //         } else {
            //           return const Text('Empty data');
            //         }
            //       }
            //       // not connected to snapshot yet, show loading
            //       else {
            //         return Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: const [
            //             CircularProgressIndicator(),
            //           ],
            //         ); // loading animation
            //       }
            //     },
            //   ),
            // ),
            const SizedBox(height: 10), // add some top padding

            // greeting text
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$greeting, $userName',
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20), // add some spacing
            const Text(
              'What type of activity do you want to do today?',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: DropdownButton<String>(
                value: activityType,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                ),
                elevation: 16,
                isExpanded: true,
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    activityType = value!;
                  });
                },
                items: typeList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 30), // add some spacing

            // // prompt user for mood
            // const Text(
            //   'How are you feeling today?',
            //   style: TextStyle(fontSize: 20),
            //   textAlign: TextAlign.center,
            // ),
            // const SizedBox(height: 10), // add some spacing
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Icon(Icons.sentiment_very_dissatisfied, size: 30.0),    // sad face icon
            //     SizedBox(
            //       width: 250,
            //       child: Expanded(
            //         // slider with 5 ticks, binds to mood value state
            //         child: Slider(
            //           value: moodValue,
            //           min: 1,
            //           max: 5,
            //           divisions: 4, // divisions = num possible values - 1
            //           label: _moodSliderLabels[moodValue.round() - 1],
            //           onChanged: (double value) {
            //             setState(() {
            //               moodValue = value;
            //             });
            //           },
            //         ),
            //       ),
            //     ),
            //     const Icon(Icons.sentiment_very_satisfied, size: 30.0),   // happy face icon
            //   ],
            // ),
            // const SizedBox(height: 10), // add some spacing

            // prompt user for energy level
            const Text(
              'How much energy do you have today?',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.bed, size: 30.0),
                SizedBox(
                  width: 250,
                  child: Expanded(
                    // slider with 5 ticks, binds to energy value state
                    child: Slider(
                      value: energyValue,
                      min: 1,
                      max: 5,
                      divisions: 4, // divisions = num possible values - 1
                      label: _energySliderLabels[energyValue.round() - 1],
                      onChanged: (double value) {
                        setState(() {
                          energyValue = value;
                        });
                      },
                    ),
                  ),
                ),
                const Icon(Icons.bolt, size: 30.0),
              ],
            ),
            const SizedBox(height: 20), // add some spacing

            // button to generate activity
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.background,
                elevation: 1,
              ),
              onPressed: getActivity,
              child: const Text('Give me an activity'),
            ),
            Expanded(
                child:
                    Container()), // fill space so that the below container sticks to bottom
          ],
        ),
        Container(
          // TODO: finish contents for second page
          // ideally this page will call google maps API and recommend local
          // activities that we will rank based on user's mood
          alignment: Alignment.center,
          child:
              // display recommended activity
              Column(
            children: [
              Container(
                  // only render if it has been generated already
                  child: activities.isNotEmpty
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(10),
                          color: Theme.of(context).primaryColor,
                          child: Column(
                            children: [
                              // section label
                              const Text(
                                'Today\'s Activity:',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5), // add some spacing

                              // activity name
                              Text(activities[currentActivityIndex].name,
                                  style: const TextStyle(
                                    fontSize: 28,
                                  )),
                              const SizedBox(height: 10), // add some spacing

                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: const BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Text(
                                    activities[currentActivityIndex].category,
                                    style: const TextStyle(fontSize: 14)),
                              ),

                              // refresh button to get the next top activity
                              IconButton(
                                  icon: const Icon(Icons.refresh),
                                  color: Theme.of(context).colorScheme.primary,
                                  onPressed:
                                      // prevent further refreshes if reached the last activity in the list
                                      currentActivityIndex <
                                              activities.length - 1
                                          ? () {
                                              setState(() {
                                                currentActivityIndex += 1;
                                              });
                                            }
                                          : null) // button is disabled if onPressed is null
                            ],
                          ))
                      : null),
              const SizedBox(height: 20), // add some spacing

              const Text(
                'Other Activities to Try',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10), // add some spacing

              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: numResultsShown - 1,
                  itemBuilder: (BuildContext context, int index) {
                    // number of indices after current activity index (+1 to skip current activity)
                    // e.g. current activity is id 3, then display 4 5 6... here
                    int itemIndex = index + currentActivityIndex + 1;
                    if (itemIndex >= activities.length) {
                      return null;
                    }
                    return Container(
                        height: 50,
                        color: Theme.of(context).primaryColor,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(activities[itemIndex].name,
                                    style: const TextStyle(fontSize: 20)),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: const BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Text(activities[itemIndex].category,
                                      style: const TextStyle(fontSize: 14)),
                                ),
                              ]),
                        ));
                  })
            ],
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
