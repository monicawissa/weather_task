import 'package:clima_weather/business_logic_layer/blocs/forecast_bloc.dart';
import 'package:clima_weather/business_logic_layer/blocs/weather_bloc.dart';
import 'package:clima_weather/business_logic_layer/events/weather_event.dart';
import 'package:clima_weather/business_logic_layer/states/forecast_state.dart';
import 'package:clima_weather/data_layer/models/fiveday_forecast.dart';
import 'package:clima_weather/data_layer/models/weather.dart';
import 'package:clima_weather/data_layer/repositories/weather_repository.dart';
import 'package:clima_weather/presentation_layer/screens/forecast_item.dart';
import 'package:clima_weather/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  Weather locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Weather weather = new Weather();
  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ForeCastBloc>(context)
        .add(WeatherEventRequested(city: widget.locationWeather.name));
    updateUI(widget.locationWeather);
  }

  void updateUI(Weather weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      print(weatherData);
      var temp = weatherData.main.temp;
      temperature = temp.toInt();
      var condition = weatherData.weather2[0].id;
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData.name;
    });
  }

  Widget showDetails(String weatherDetail, String name) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.yellow,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            weatherDetail,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget buildBlocWidget() {
    return BlocConsumer<ForeCastBloc, ForeCastState>(
        listener: (context, foreCastState) {
      if (foreCastState is ForeCastStateSuccess) {}
    }, builder: (context, foreCastState) {
      if (foreCastState is ForeCastStateLoading) {
        return Center(child: CircularProgressIndicator());
      }
      if (foreCastState is ForeCastStateSuccess &&
          foreCastState.foreCast != null) {
        return buildLoadedBlocWidget(foreCastState.foreCast);
      }
      if (foreCastState is ForeCastStateFailure) {
        return Text(
          'Something went wrong',
          style: TextStyle(color: Colors.redAccent, fontSize: 16),
        );
      }
      return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Text(
            'No ForeCast Found',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      );
    });
  }

  Widget buildLoadedBlocWidget(List<FiveDayForeCast> foreCast) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Container(
        child: buildForeCast(foreCast),
      ),
    );
  }

  Widget buildForeCast(List<FiveDayForeCast> foreCast) {
    return ListView.builder(
      //key: Key('builder ${selected.toString()}'),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      itemBuilder: (context, idx) {
        return ForeCastItem(foreCast[idx]);
      },
      itemCount: foreCast.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // FlatButton(
                  //   onPressed: () async {
                  //     var weatherData = await weather.getLocationWeather();
                  //     updateUI(weatherData);
                  //   },
                  //   child: Icon(
                  //     Icons.near_me,
                  //     size: 50.0,
                  //   ),
                  // ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => WeatherBloc(
                                      weatherRepository: WeatherRepository(
                                          httpClient: http.Client())),
                                  child: CityScreen(),
                                )),
                      );
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '$temperature°',
                          textAlign: TextAlign.right,
                          style: kTempTextStyle,
                        ),
                        Text(
                          weatherIcon,
                          textAlign: TextAlign.right,
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15.0, left: 15.0),
                    child: Text(
                      '$weatherMessage in $cityName',
                      textAlign: TextAlign.center,
                      style: kMessageTextStyle,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 30.0, bottom: 20),
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          'forcast next 5 days :'.toUpperCase(),
                          style: Theme.of(context).textTheme.caption.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: Icon(
                        Icons.next_plan_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: buildBlocWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
