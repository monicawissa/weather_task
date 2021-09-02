import 'package:clima_weather/business_logic_layer/events/weather_event.dart';
import 'package:clima_weather/business_logic_layer/states/forecast_state.dart';
import 'package:clima_weather/data_layer/repositories/weather_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForeCastBloc extends Bloc<WeatherEvent, ForeCastState> {
  final WeatherRepository weatherRepository;
  ForeCastBloc({@required this.weatherRepository})
      : assert(weatherRepository != null),
        super(ForeCastStateInitial());
  @override
  Stream<ForeCastState> mapEventToState(WeatherEvent weatherEvent) async* {
    if (weatherEvent is WeatherEventRequested) {
      yield ForeCastStateLoading();
      try {
        print("ForeCast create");

        var w = await weatherRepository.getforecastOfCity(weatherEvent.city);
        yield ForeCastStateSuccess(foreCast: w);
      } catch (exception) {
        print(exception);
        yield ForeCastStateFailure();
      }
    } else if (weatherEvent is WeatherEventRefresh) {
      try {
        var w = await weatherRepository.getforecastOfCity(weatherEvent.city);
        yield ForeCastStateSuccess(foreCast: w);
      } catch (exception) {
        yield ForeCastStateFailure();
      }
    }
  }
}
