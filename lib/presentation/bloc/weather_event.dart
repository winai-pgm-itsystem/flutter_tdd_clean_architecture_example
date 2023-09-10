import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class OnCityChanged extends WeatherEvent {
  const OnCityChanged(this.cityName);

  final String cityName;

  @override
  List<Object?> get props => [cityName];
}
