import 'package:clima_weather/data_layer/models/weather.dart';
import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  final Weather weatherDetail;

  WeatherItem(this.weatherDetail);

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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
        decoration: BoxDecoration(
            color: Colors.black45, borderRadius: BorderRadius.circular(10.0)),
        // width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Temp Min : " + weatherDetail.main.tempMin.toString(),
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 4.0),
                Text(
                  "☁",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.yellow,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Temp Max : " + weatherDetail.main.tempMax.toString(),
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            showDetails(weatherDetail.weather2[0].description.toString(),
                weatherDetail.name.toString()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "🌫",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Wind Speed : \n" + weatherDetail.wind.speed.toString(),
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
