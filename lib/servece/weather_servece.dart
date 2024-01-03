import '../api/apirepo.dart';
import '../model/currentweatherdata.dart';
import '../model/fivedays_data.dart';

class WeatherService {
  final String city;
//https://api.openweathermap.org/data/2.5/weather?&q=amman&appid=bfce548f8ee8b143ed4aa6fc26fc61ee
  String baseUrl = 'https://api.openweathermap.org/data/2.5';
  String apiKey = 'appid=bfce548f8ee8b143ed4aa6fc26fc61ee';
  WeatherService({required this.city});
  void getCurrentWeatherData({
    Function()? beforSend,
    Function(CurrentWeatherData currentWeatherData)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    final url = '$baseUrl/weather?&q=$city&lang=en&$apiKey';
    ApiRepository(
      url: '$url',
    ).get(
        beforeSend: () => {
              if (beforSend != null)
                {
                  beforSend(),
                },
            },
        onSuccess: (data) => {
              onSuccess!(CurrentWeatherData.fromJson(data)),
            },
        onError: (error) => {
              if (onError != null)
                {
                  print(error),
                  onError(error),
                }
            });
  }

  void getFiveDaysThreeHoursForcastData({
    Function()? beforSend,
    Function(List<FiveDayData> fiveDayData)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    final url = '$baseUrl/forecast?&q=$city&lang=en&$apiKey';
    print(url);
    ApiRepository(
      url: '$url',
    ).get(
        beforeSend: () => {},
        onSuccess: (data) => {
              onSuccess!((data['list'] as List)
                  .map((t) => FiveDayData.fromJson(t))
                  .toList())
            },
        onError: (error) => {
              print(error),
              onError!(error),
            });
  }
}
