import 'package:flutter_tdd_clean_architecture_example/core/constants/constants.dart';
import 'package:flutter_tdd_clean_architecture_example/core/error/exception.dart';
import 'package:flutter_tdd_clean_architecture_example/data/data_sources/remote_data_source.dart';
import 'package:flutter_tdd_clean_architecture_example/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  const testCityName = 'New York';
  group(
    'Group current weather',
    () {
      test(
        'Should return weather model when the reponse code is 200',
        () async {
          //arrange
          when(
            mockHttpClient.get(Uri.parse(
              Urls.currentWeatherByName(testCityName),
            )),
          ).thenAnswer(
            (_) async => http.Response(
              readJson('helpers/dummy_data/dummy_weather_response.json'),
              200,
            ),
          );

          //act
          final result =
              await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

          //assert
          expect(result, isA<WeatherModel>());
        },
      );

      test(
        'Should throw a server exception when the response code is 404 or other',
        () async {
          //arrange
          when(
            mockHttpClient.get(Uri.parse(
              Urls.currentWeatherByName(testCityName),
            )),
          ).thenAnswer(
            (_) async => http.Response(
              'Not found',
              404,
            ),
          );

          //act
          final result =
              weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

          //assert
          expect(result, throwsA(isA<ServerException>()));
        },
      );
    },
  );
}
