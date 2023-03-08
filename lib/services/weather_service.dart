import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  static final WeatherFactory _wf =
      WeatherFactory(dotenv.env['WEATHER_API_KEY'] ?? '');

  static Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // test if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if location services aren't enabled don't continue
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // test if device allows location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // request location permissions from device
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // permissions are denied, can't continue
        throw Exception('Location permissions are denied');
      }
    }

    // permissions allowed, can proceed accessing position
    return await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.high);
  }

  static Future<Weather> getCurrentWeather(double lat, double lon) async {
    return _wf.currentWeatherByLocation(lat, lon);
  }
}
