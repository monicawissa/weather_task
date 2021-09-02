import 'package:clima_weather/business_logic_layer/blocs/weather_bloc.dart';
import 'package:clima_weather/business_logic_layer/events/weather_event.dart';
import 'package:clima_weather/business_logic_layer/states/weather_state.dart';
import 'package:clima_weather/data_layer/models/weather.dart';
import 'package:clima_weather/data_layer/repositories/weather_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
  });

  group('GetWeather', () {
    final weather = Weather(name: 'London');

    test(
      'OLD WAY emits [WeatherLoading, WeatherLoaded] when successful',
      () {
        when(mockWeatherRepository.fetchWeather(any))
            .thenAnswer((_) async => weather);
        final bloc = WeatherBloc(mockWeatherRepository);
        bloc.add(WeatherEventRequested(city: 'London'));
        expectLater(
          bloc,
          emitsInOrder([
            WeatherStateInitial(),
            WeatherStateLoading(),
            WeatherStateSuccess(weather.name),
          ]),
        );
      },
    );
  });
}
