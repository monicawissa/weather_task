import 'package:clima_weather/business_logic_layer/events/weather_event.dart';
import 'package:clima_weather/business_logic_layer/states/weather_state.dart';
import 'package:clima_weather/data_layer/models/weather.dart';
import 'package:clima_weather/data_layer/repositories/weather_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null),
        super(WeatherStateInitial());
  @override
  Stream<WeatherState> mapEventToState(WeatherEvent weatherEvent) async* {
    if (weatherEvent is WeatherEventRequested) {
      yield WeatherStateLoading();
      try {
        print("weather create");

        List<String> str = weatherEvent.city.split(',');
        print(str[0]);
        if (str.length < 3 || str.length > 7)
          yield WeatherStateSuccess(weathers: []);
        else {
          List<Weather> weathers =
              await weatherRepository.getWeatherFromCities(str);
          yield WeatherStateSuccess(weathers: weathers);
        }
        // str.forEach((i) async* {
        //   var w = await weatherRepository.getWeatherFromCity(i);
        //   if (w != null) weathers.add(w);
        //   print("weather" + w.main.tempMin.toString());
        //   yield WeatherStateSuccess(weathers: weathers);
        // });
        //
        // print("weather end");

        // List<Weather> weathers = new List<Weather>();
        // List<String> str = weatherEvent.city.split(',');
        // print(str[0]);
        // var w = await weatherRepository.getWeatherFromCity(str[0]);
        // if (w != null) weathers.add(w);
        // print("weather" + w.main.tempMin.toString());
        // yield WeatherStateSuccess(weathers: weathers);
      } catch (exception) {
        yield WeatherStateFailure();
      }
    } else if (weatherEvent is WeatherEventRefresh) {
      try {
        List<String> str = weatherEvent.city.split(',');
        print(str[0]);
        if (str.length < 3 || str.length > 7)
          yield WeatherStateSuccess(weathers: []);
        else {
          List<Weather> weathers =
              await weatherRepository.getWeatherFromCities(str);
          yield WeatherStateSuccess(weathers: weathers);
        }
      } catch (exception) {
        yield WeatherStateFailure();
      }
    }
  }
}
