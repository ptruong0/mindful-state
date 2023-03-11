import 'package:flutter/material.dart';
import 'package:mindful_state/services/recommendations.dart';
import 'package:weather/weather.dart';

import 'services/activity.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({required this.weather, Key? key}) : super(key: key);

  final Weather weather;

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String activityType = 'fitness';
  double energyValue = 1.0;
  late List<Activity> activities;

  void getActivity() {
    Map<int, int> test = generateRecommendations(
        activityType, energyValue, activities, widget.weather);
  }

  final List<String> typeList = <String>[
    'fitness',
    'relaxation',
    'fun',
    'productivity',
  ];

  final List<String> _energySliderLabels = <String>[
    'Very Low',
    'Low',
    'Medium',
    'High',
    'Very High',
  ];

  @override
  Widget build(BuildContext context) {
    // Greeting to display
    final now = DateTime.now();
    final currentTimeOfDay = now.hour;
    String greeting;
    if (currentTimeOfDay >= 5 && currentTimeOfDay < 12) {
      greeting = 'Good morning';
    } else if (currentTimeOfDay >= 12 && currentTimeOfDay < 18) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // greeting text
          Text(
            '$greeting, user',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
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
                child: Slider(
                  value: energyValue,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: _energySliderLabels[energyValue.round() - 1],
                  onChanged: (double value) {
                    setState(() {
                      energyValue = value;
                    });
                  },
                ),
              ),
              const Icon(Icons.bolt, size: 30.0),
            ],
          ),
          const SizedBox(height: 20), // add some spacing

          // button to generate activity
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 1,
            ),
            onPressed: () {
              getActivity();
            },
            child: const Text('Generate Activity'),
          ),
        ],
      ),
    );
  }
}
