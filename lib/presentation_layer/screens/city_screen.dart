import 'package:clima_weather/business_logic_layer/blocs/weather_bloc.dart';
import 'package:clima_weather/business_logic_layer/events/weather_event.dart';
import 'package:clima_weather/business_logic_layer/states/weather_state.dart';
import 'package:clima_weather/data_layer/models/weather.dart';
import 'package:clima_weather/presentation_layer/screens/weather_item.dart';
import 'package:clima_weather/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String typedValue;
  List<Weather> weathers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    // icon: Icon(
                    //   Icons.search,
                    //   color: Colors.white,
                    //   size: 40,
                    // ),
                    hintText: 'Enter City,City..etc',
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    typedValue = value;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepPurple),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                      ),
                    ),
                    onPressed: () {
                      BlocProvider.of<WeatherBloc>(context)
                          .add(WeatherEventRequested(city: typedValue));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Get Weather',
                        style: kButtonTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(child: buildBlocWidget()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBlocWidget() {
    return BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, weatherState) {
      if (weatherState is WeatherStateSuccess) {}
    }, builder: (context, weatherState) {
      if (weatherState is WeatherStateLoading) {
        return Center(child: CircularProgressIndicator());
      }
      if (weatherState is WeatherStateSuccess &&
          weatherState.weathers.length != null &&
          weatherState.weathers.length > 0) {
        return buildLoadedBlocWidget(weatherState.weathers);
      }
      if (weatherState is WeatherStateFailure) {
        return Text(
          'Something went wrong',
          style: TextStyle(color: Colors.redAccent, fontSize: 16),
        );
      }
      return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Text(
            'write range from 3 to 7 cities seperated with comma !',
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

  Widget buildLoadedBlocWidget(List<Weather> weathers) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Container(
        child: buildWeathersList(weathers),
      ),
    );
  }

  Widget buildWeathersList(List<Weather> weathers) {
    return ListView.builder(
      //key: Key('builder ${selected.toString()}'),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      itemBuilder: (context, idx) {
        return WeatherItem(weathers[idx]);
      },
      itemCount: weathers.length,
    );

    // GridView.builder(
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 1,
    //       childAspectRatio: 2 / 3,
    //       crossAxisSpacing: 1,
    //       mainAxisExtent: 1),
    //   shrinkWrap: true,
    //   physics: const ClampingScrollPhysics(),
    //   padding: EdgeInsets.zero,
    //   itemCount: weathers.length,
    //   itemBuilder: (ctx, idx) {
    //     return WeatherItem(weathers[idx]);
    //   });
  }
}
