import 'package:equatable/equatable.dart';
import 'package:flutter_tdd_clean_architecture_example/domain/entities/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  const WeatherLoaded(this.result);

  final WeatherEntity result;

  @override
  List<Object?> get props => [result];
}

class WeatherLoadFailure extends WeatherState {
  const WeatherLoadFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
