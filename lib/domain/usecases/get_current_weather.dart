import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture_example/core/error/failure.dart';
import 'package:flutter_tdd_clean_architecture_example/domain/entities/weather.dart';
import 'package:flutter_tdd_clean_architecture_example/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase(this.weatherRepository);

  Future<Either<Failure, WeatherEntity>> execute(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
