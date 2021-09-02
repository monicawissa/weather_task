import 'package:clima_weather/data_layer/models/fiveday_forecast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ForeCastState extends Equatable {
  const ForeCastState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ForeCastStateInitial extends ForeCastState {}

class ForeCastStateLoading extends ForeCastState {}

class ForeCastStateSuccess extends ForeCastState {
  final List<FiveDayForeCast> foreCast;
  const ForeCastStateSuccess({@required this.foreCast})
      : assert(foreCast != null);
  @override
  // TODO: implement props
  List<Object> get props => [foreCast];
}

class ForeCastStateFailure extends ForeCastState {}
