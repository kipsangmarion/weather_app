part of 'city_bloc.dart';

@immutable
abstract class CityState {}

class CityInitial extends CityState {}

class CityLoading extends CityState {}

class CitySuccess extends CityState {
  final WetherM? weatherData;

  CitySuccess(this.weatherData);
}

class CityError extends CityState {}
