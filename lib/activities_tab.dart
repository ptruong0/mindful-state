import 'package:flutter/material.dart';

import 'services/activity.dart';
import 'services/db.dart';

class ActivitiesTab extends StatefulWidget {
  const ActivitiesTab({required this.activities, Key? key}) : super(key: key);

  final List<Activity> activities;

  @override
  _ActivitiesTabState createState() => _ActivitiesTabState();
}

class _ActivitiesTabState extends State<ActivitiesTab> {
  // determines which activity in list is displayed
  late int currentActivityIndex;

  // number of activities that will be displayed on the recommendation page
  final int numResultsShown = 5;

//
  @override
  void initState() {
    super.initState();
    currentActivityIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            // only render if it has been generated already
            child: widget.activities.isNotEmpty
                ? Column(
                    children: [
                      Container(
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
                              Text(
                                widget.activities[currentActivityIndex].name,
                                style: const TextStyle(
                                  fontSize: 28,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              const SizedBox(height: 10), // add some spacing

                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: const BoxDecoration(
                                    //color: Colors.deepPurple,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Text(
                                    widget.activities[currentActivityIndex]
                                        .category,
                                    style: const TextStyle(fontSize: 14)),
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text(
                                            "Did you like this activity?"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () async {
                                              // Handle "Like" button press
                                              Navigator.of(ctx).pop();
                                              await Database
                                                  .updateActivityPreference(
                                                      1,
                                                      widget
                                                          .activities[
                                                              currentActivityIndex]
                                                          .name);
                                            },
                                            child: const Text("Like"),
                                          ),
                                          TextButton(
                                              onPressed: () async {
                                                // Handle "Dislike" button press
                                                Navigator.of(ctx).pop();
                                                await Database
                                                    .updateActivityPreference(
                                                        1,
                                                        widget
                                                            .activities[
                                                                currentActivityIndex]
                                                            .name);
                                              },
                                              child: const Text("Dislike")),
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Text("Complete"),
                                ),
                              ),

                              // refresh button to get the next top activity
                              IconButton(
                                  icon: const Icon(Icons.refresh),
                                  //color: Theme.of(context).colorScheme.primary,
                                  onPressed:
                                      // prevent further refreshes if reached the last activity in the list
                                      currentActivityIndex <
                                              widget.activities.length - 1
                                          ? () {
                                              setState(() {
                                                currentActivityIndex += 1;
                                              });
                                            }
                                          : null) // button is disabled if onPressed is null
                            ],
                          )),
                      const SizedBox(height: 20), // add some spacing

                      const Text(
                        'Other Activities to Try',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                    ],
                  )
                : const Text(
                    'To get activities, fill out the information on the Home tab.',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: numResultsShown - 1,
              itemBuilder: (BuildContext context, int index) {
                // number of indices after current activity index (+1 to skip current activity)
                // e.g. current activity is id 3, then display 4 5 6... here
                int itemIndex = index + currentActivityIndex + 1;
                if (itemIndex >= widget.activities.length) {
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
                            Flexible(
                              child: Text(widget.activities[itemIndex].name,
                                  style: const TextStyle(fontSize: 16)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: const BoxDecoration(
                                  //color: Colors.deepPurple,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Text(widget.activities[itemIndex].category,
                                  style: const TextStyle(fontSize: 12)),
                            ),
                          ]),
                    ));
              })
        ],
      ),
    );
  }
}
