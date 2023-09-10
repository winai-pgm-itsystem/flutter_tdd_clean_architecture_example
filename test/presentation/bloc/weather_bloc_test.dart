import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture_example/core/error/failure.dart';
import 'package:flutter_tdd_clean_architecture_example/domain/entities/weather.dart';
import 'package:flutter_tdd_clean_architecture_example/presentation/bloc/weather_bloc.dart';
import 'package:flutter_tdd_clean_architecture_example/presentation/bloc/weather_event.dart';
import 'package:flutter_tdd_clean_architecture_example/presentation/bloc/weather_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });

  const testWeatherDetail = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: 'iconCode',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  test(
    'initial state should be empty',
    () async {
      //assert
      expect(weatherBloc.state, WeatherEmpty());
    },
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName))
          .thenAnswer((_) async => const Right(testWeatherDetail));

      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoaded(testWeatherDetail),
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherLoadFailure] when get data is unsuccessful',
      build: () {
        when(mockGetCurrentWeatherUseCase.execute(testCityName)).thenAnswer(
            (_) async => const Left(ServerFailure('Server failure')));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            WeatherLoading(),
            const WeatherLoadFailure('Server failure'),
          ]);
}
