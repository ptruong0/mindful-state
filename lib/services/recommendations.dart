// boiler plate code for recommendation
// taken from Swarna pseudocode

import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather/weather.dart';

import 'activity.dart';

Map<int, int> generateRecommendations(String category, double energy,
    List<Activity> activities, Weather weather) {
  Map<int, int> recommendDict = {};

  bool rainOrSnow = false;

  if (weather.weatherDescription?.contains('rain') == true ||
      weather.weatherDescription?.contains('thunderstorm') == true ||
      weather.weatherDescription?.contains('snow') == true ||
      weather.weatherDescription?.contains('blizzard') == true) {
    rainOrSnow = true;
  }

  for (var i in activities) {
    if (i.category == category) {
      recommendDict[i.id] = (recommendDict[i.id] ?? 0) + 5;
    }

    if (i.indoors == false && rainOrSnow == false) {
      recommendDict[i.id] = (recommendDict[i.id] ?? 0) + 1;
    }

    if (i.indoors == false && rainOrSnow == true) {
      recommendDict[i.id] = (recommendDict[i.id] ?? 0) + 1;
    }

    if (i.indoors == true && rainOrSnow == true) {
      recommendDict[i.id] = (recommendDict[i.id] ?? 0) + 1;
    }

    if (i.indoors == true && rainOrSnow == false) {
      recommendDict[i.id] = (recommendDict[i.id] ?? 0) - 1000;
    }

    if (i.energy == energy) {
      recommendDict[i.id] = (recommendDict[i.id] ?? 0) + 2;
    }

    if (i.energy < energy) {
      recommendDict[i.id] = (recommendDict[i.id] ?? 0) + 1;
    }

    recommendDict[i.id] = (recommendDict[i.id] ?? 0) + i.score;
  }

  var sortedDict = recommendDict.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  return Map.fromEntries(sortedDict);
}
