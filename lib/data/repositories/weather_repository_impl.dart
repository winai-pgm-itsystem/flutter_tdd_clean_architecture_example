import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture_example/core/error/exception.dart';
import 'package:flutter_tdd_clean_architecture_example/core/error/failure.dart';
import 'package:flutter_tdd_clean_architecture_example/data/data_sources/remote_data_source.dart';
import 'package:flutter_tdd_clean_architecture_example/domain/entities/weather.dart';
import 'package:flutter_tdd_clean_architecture_example/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl({required this.weatherRemoteDataSource});
  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
