// boiler plate code for recommendation
// taken from Swarna pseudocode

Map<int, int> generateRecommendations(
    User user, List<Activity> activities, int weather) {
  Map<String, int> recommendDict = {};

  for (var i in activities) {
    if (i.category == user.category) {
      recommendDict[i.id] = (recommendDict[i.id] ?? 0) + 5;
    }

    if (i.outdoors == 0 && weather == 0) {
      recommendDict[i.id] = (recommendDict[i.id] ?? 0) + 1;
    }

    if (i.outdoors == 0 && weather == 1) {
      recommendDict[i.id] = (recommendDict[i.id] ?? 0) + 1;
    }

    if (i.outdoors == 1 && weather == 1) {
      recommendDict[i.id] = (recommendDict[i.id] ?? 0) + 1;
    }

    if (i.outdoors == 1 && weather == 0) {
      recommendDict[i.id] = (recommendDict[i.id] ?? 0) - 1000;
    }

    if (i.energy == user.energy) {
      recommendDict[i.id] = (recommendDict[i.id] ?? 0) + 2;
    }

    if (i.energy < user.energy) {
      recommendDict[i.id] = (recommendDict[i.id] ?? 0) + 1;
    }

    recommendDict[i.id] = (recommendDict[i.id] ?? 0) + i.score;
  }

  var sortedDict = recommendDict.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  return Map.fromEntries(sortedDict);
}
