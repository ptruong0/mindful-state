import 'package:flutter/material.dart';

import 'services/activity.dart';

class ActivitiesTab extends StatefulWidget {
  const ActivitiesTab({Key? key}) : super(key: key);

  @override
  _ActivitiesTabState createState() => _ActivitiesTabState();
}

class _ActivitiesTabState extends State<ActivitiesTab> {
  late List<Activity> activities;
  late int currentActivityIndex;
  int numResultsShown = 5;

//
  @override
  void initState() {
    super.initState();
    currentActivityIndex = 0;
    activities = [
      Activity(
          name: 'ride a bike',
          category: 'fitness',
          indoors: false,
          id: 1,
          energy: 3,
          score: 5),
      Activity(
          name: 'take a walk',
          category: 'fitness',
          indoors: false,
          id: 2,
          energy: 2,
          score: 5),
      Activity(
          name: 'meditate',
          category: 'relaxation',
          indoors: true,
          id: 1,
          energy: 1,
          score: 5),
      Activity(
          name: 'read a book',
          category: 'relaxation',
          indoors: true,
          id: 1,
          energy: 1,
          score: 5),
    ];
    // change to something like Activity.generateActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
              // only render if it has been generated already
              child: activities.isNotEmpty
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10),
                      //color: Theme.of(context).primaryColor,
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
                                //color: Colors.deepPurple,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Text(
                                activities[currentActivityIndex].category,
                                style: const TextStyle(fontSize: 14)),
                          ),

                          // refresh button to get the next top activity
                          IconButton(
                              icon: const Icon(Icons.refresh),
                              //color: Theme.of(context).colorScheme.primary,
                              onPressed:
                                  // prevent further refreshes if reached the last activity in the list
                                  currentActivityIndex < activities.length - 1
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
                return SizedBox(
                    height: 50,
                    //color: Theme.of(context).primaryColor,
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
                                  //color: Colors.deepPurple,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Text(activities[itemIndex].category,
                                  style: const TextStyle(fontSize: 14)),
                            ),
                          ]),
                    ));
              })
        ],
      ),
    );
  }
}
