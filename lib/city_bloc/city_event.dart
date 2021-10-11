part of 'city_bloc.dart';

@immutable
abstract class CityEvent {}

class GetCityWeather extends CityEvent {
  final String? query;

  GetCityWeather({this.query});
}
