import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'business_logic_layer/blocs/weather_bloc_observer.dart';
import 'data_layer/repositories/weather_repository.dart';
import 'presentation_layer/screens/loading_screen.dart';

void main() {
  Bloc.observer = WeatherBlocObserver();
  final WeatherRepository weatherRepository =
      WeatherRepository(httpClient: http.Client());
  //other blocs ?
  runApp(MyApp(
    weatherRepository: weatherRepository,
  ));
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;
  MyApp({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoadingScreen(weatherRepository),
    );
    //LoadingScreen(),
  }
}
