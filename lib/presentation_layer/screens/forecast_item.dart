import 'package:clima_weather/data_layer/models/fiveday_forecast.dart';
import 'package:flutter/material.dart';

class ForeCastItem extends StatelessWidget {
  final FiveDayForeCast FiveDayForeCastDetail;

  ForeCastItem(this.FiveDayForeCastDetail);

  Widget showDetails(String fiveDayForeCastDetail) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            fiveDayForeCastDetail,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.yellow,
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
                  "Temp Min : " + FiveDayForeCastDetail.main.tempMin.toString(),
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
                  "Temp Max : " + FiveDayForeCastDetail.main.tempMax.toString(),
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            showDetails(
                FiveDayForeCastDetail.weather[0].description.toString()),
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
                  "Wind Speed : \n" +
                      FiveDayForeCastDetail.wind.speed.toString(),
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
