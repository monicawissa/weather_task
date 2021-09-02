class ForeCast {
  String cod;
  int message;
  int cnt;
  List<FiveDayForeCast> fiveDayForeCastList;
  City city;

  ForeCast(
      {this.cod, this.message, this.cnt, this.fiveDayForeCastList, this.city});

  ForeCast.fromJson(Map<String, dynamic> json) {
    print('ForeCast');
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    if (json['list'] != null) {
      fiveDayForeCastList = new List<FiveDayForeCast>();
      json['list'].forEach((v) {
        fiveDayForeCastList.add(new FiveDayForeCast.fromJson(v));
      });
    }
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    print('ForeCast');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cod'] = this.cod;
    data['message'] = this.message;
    data['cnt'] = this.cnt;
    if (this.fiveDayForeCastList != null) {
      data['list'] = this.fiveDayForeCastList.map((v) => v.toJson()).toList();
    }
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    return data;
  }
}

class FiveDayForeCast {
  int dt;
  Mainn main;
  List<Weatherr> weather;
  Clouds clouds;
  Wind wind;
  int visibility;
  double pop;
  Sys sys;
  String dtTxt;
  Rain rain;

  FiveDayForeCast(
      {this.dt,
      this.main,
      this.weather,
      this.clouds,
      this.wind,
      this.visibility,
      this.pop,
      this.sys,
      this.dtTxt,
      this.rain});

  FiveDayForeCast.fromJson(Map<String, dynamic> json) {
    print('FiveDayForeCast');
    dt = json['dt'];
    print(json);
    main = json['main'] != null ? new Mainn.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      weather = new List<Weatherr>();
      json['weather'].forEach((v) {
        weather.add(new Weatherr.fromJson(v));
      });
    }
    clouds =
        json['clouds'] != null ? new Clouds.fromJson(json['clouds']) : null;
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    visibility = json['visibility'];
    pop = json['pop'].toDouble();
    sys = json['sys'] != null ? new Sys.fromJson(json['sys']) : null;
    // var f = json['dt_txt'].split(' ')[0].split('-')[2];
    // var l = json['dt_txt'].split(' ')[1].split(':')[0];
    // var fandl = '$f-$l';
    //dtTxt = fandl;
    dtTxt = json['dt_txt'];
    rain = json['rain'] != null ? new Rain.fromJson(json['rain']) : null;
    print('FiveDayForeCast');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    if (this.main != null) {
      data['main'] = this.main.toJson();
    }
    if (this.weather != null) {
      data['weather'] = this.weather.map((v) => v.toJson()).toList();
    }
    if (this.clouds != null) {
      data['clouds'] = this.clouds.toJson();
    }
    if (this.wind != null) {
      data['wind'] = this.wind.toJson();
    }
    data['visibility'] = this.visibility;
    data['pop'] = this.pop;
    if (this.sys != null) {
      data['sys'] = this.sys.toJson();
    }
    data['dt_txt'] = this.dtTxt;
    if (this.rain != null) {
      data['rain'] = this.rain.toJson();
    }
    return data;
  }
}

class Mainn {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;
  double tempKf;

  Mainn(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.seaLevel,
      this.grndLevel,
      this.humidity,
      this.tempKf});

  Mainn.fromJson(Map<String, dynamic> json) {
    print('Mainn');
    temp = json['temp'].toDouble();
    feelsLike = json['feels_like'].toDouble();
    tempMin = json['temp_min'].toDouble();
    tempMax = json['temp_max'].toDouble();
    pressure = json['pressure'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
    humidity = json['humidity'];
    tempKf = json['temp_kf'].toDouble();
    print('Mainn');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['temp_min'] = this.tempMin;
    data['temp_max'] = this.tempMax;
    data['pressure'] = this.pressure;
    data['sea_level'] = this.seaLevel;
    data['grnd_level'] = this.grndLevel;
    data['humidity'] = this.humidity;
    data['temp_kf'] = this.tempKf;
    return data;
  }
}

class Weatherr {
  int id;
  String main;
  String description;
  String icon;

  Weatherr({this.id, this.main, this.description, this.icon});

  Weatherr.fromJson(Map<String, dynamic> json) {
    print('Weatherr');
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
    print('Weatherr');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main'] = this.main;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Clouds {
  int all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    print('Clouds');
    all = json['all'];
    print('Clouds');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = this.all;
    return data;
  }
}

double reciprocal(double d) => 1 / d;

class Wind {
  double speed;
  int deg;
  double gust;

  Wind({this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    print('wind');
    speed = json['speed'].toDouble();
    deg = json['deg'];
    gust = json['gust'].toDouble();
    print('wind');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed'] = this.speed;
    data['deg'] = this.deg;
    data['gust'] = this.gust;
    return data;
  }
}

class Sys {
  String pod;

  Sys({this.pod});

  Sys.fromJson(Map<String, dynamic> json) {
    print('sys');
    pod = json['pod'];
    print('sys');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pod'] = this.pod;
    return data;
  }
}

class Rain {
  double d3h;

  Rain({this.d3h});

  Rain.fromJson(Map<String, dynamic> json) {
    print('Rain');
    d3h = json['3h'].toDouble();
    print('Rain');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['3h'] = this.d3h;
    return data;
  }
}

class City {
  int id;
  String name;
  Coord coord;
  String country;
  int population;
  int timezone;
  int sunrise;
  int sunset;

  City(
      {this.id,
      this.name,
      this.coord,
      this.country,
      this.population,
      this.timezone,
      this.sunrise,
      this.sunset});

  City.fromJson(Map<String, dynamic> json) {
    print('city');
    id = json['id'];
    name = json['name'];
    coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
    country = json['country'];
    population = json['population'];
    timezone = json['timezone'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    print('city');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.coord != null) {
      data['coord'] = this.coord.toJson();
    }
    data['country'] = this.country;
    data['population'] = this.population;
    data['timezone'] = this.timezone;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    return data;
  }
}

class Coord {
  double lat;
  double lon;

  Coord({this.lat, this.lon});

  Coord.fromJson(Map<String, dynamic> json) {
    print('coord');
    lat = json['lat'];
    lon = json['lon'];
    print('coord');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}
