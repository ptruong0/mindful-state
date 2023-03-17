import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  static final WeatherFactory _wf =
      WeatherFactory(dotenv.env['WEATHER_API_KEY'] ?? '');

  static Future<Position> getCurrentPosition() async {
    try {
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

      if (permission == LocationPermission.deniedForever) {
        // permissions are denied forever, handle appropriately
        throw Exception(
            'Location permissions are permanently denied, cannot request permissions.');
      }

      // permissions allowed, can proceed accessing position
      return await Geolocator.getCurrentPosition(
          //forceAndroidLocationManager: false,
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      // handle any errors that occur
      print('Error getting position: $e');
      rethrow;
    }
  }

  static Future<Weather> getCurrentWeather(double lat, double lon) async {
    try {
      final weather = await _wf.currentWeatherByLocation(lat, lon);
      return weather;
    } catch (e) {
      // handle any errors that occur
      print('Error getting weather: $e');
      rethrow;
    }
  }
}
