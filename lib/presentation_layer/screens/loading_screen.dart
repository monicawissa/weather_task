import 'package:clima_weather/business_logic_layer/blocs/forecast_bloc.dart';
import 'package:clima_weather/data_layer/repositories/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  WeatherRepository weatherRepository;
  LoadingScreen(this.weatherRepository);

  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await widget.weatherRepository.getLocationWeather();
    print(weatherData);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (context) =>
            ForeCastBloc(weatherRepository: widget.weatherRepository),
        child: LocationScreen(
          locationWeather: weatherData,
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
