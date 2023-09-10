import 'package:flutter_tdd_clean_architecture_example/data/data_sources/remote_data_source.dart';
import 'package:flutter_tdd_clean_architecture_example/domain/repositories/weather_repository.dart';
import 'package:flutter_tdd_clean_architecture_example/domain/usecases/get_current_weather.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeatherUseCase,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
