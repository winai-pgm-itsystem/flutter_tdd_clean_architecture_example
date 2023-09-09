import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture_example/core/error/failure.dart';
import 'package:flutter_tdd_clean_architecture_example/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}
 