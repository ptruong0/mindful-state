// boiler plate code for recommendation
// taken from Swarna pseudocode
import 'package:weather/weather.dart';

import 'activity.dart';

// how strongly we should consider each factor when assigning scores to activities
const Map<String, double> weights = {
  'category': 0.5,
  'weather': 0.2,
  'energy': 0.2,
  'pastScore': 0.1
};

List<Activity> generateRecommendations(String category, double energy,
    List<Activity> activities, Weather weather) {
  Map<int, double> recommendDict = {};

  bool rainOrSnow = false;

  if (weather.weatherDescription?.contains('rain') == true ||
      weather.weatherDescription?.contains('thunderstorm') == true ||
      weather.weatherDescription?.contains('snow') == true ||
      weather.weatherDescription?.contains('blizzard') == true) {
    rainOrSnow = true;
  }

  
  for (var i in activities) {
    // try to rank each on a scale of 1 to 10
    // weights will differentiate the importance of each factor
    double categoryScore = 0;
    double weatherScore = 0;
    double energyScore = 0;

    // category matches
    if (i.category == category) {
      categoryScore += 5;
    }

    // outdoors, good weather
    if (i.outdoors && !rainOrSnow) {
      weatherScore += 10; // ideal
    }
    // outdoors, bad weather
    else if (i.outdoors && rainOrSnow) {
      recommendDict[i.id] = -1000;  // don't recommend!
      continue;
    }
    // indoors, bad weather
    else if (!i.outdoors && rainOrSnow) {
      weatherScore += 10; // ideal
    }
    // indoors, good weather
    else {
      weatherScore += 5;  // ok
    }
    if (i.energy == energy) {
      energyScore += 10;
    } else if (i.energy < energy) {
      // +score if user energy is closer to activity energy level
      energyScore += 10 - (energy - i.energy);
    } else {
      // activity energy is higher than user energy, not great
      energyScore += 1;
    }

    recommendDict[i.id] = (categoryScore * weights['category']!) + 
        (weatherScore * weights['weather']!) + 
        (energyScore * weights['energy']!) + 
        // user past score
        (i.score * weights['pastScore']!);
  }

  // sort activities from highest to lowest score
  activities.sort((a, b) {
    return recommendDict[b.id]!.compareTo(recommendDict[a.id]!);
  });

  return activities;
}
