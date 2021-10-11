import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/wether_m.dart';

import '../const.dart';
import '../weather_api.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc() : super(CityInitial());

  @override
  Stream<CityState> mapEventToState(
    CityEvent event,
  ) async* {
    if (event is GetCityWeather) {
      try {
        yield CityLoading();
        var res = await weatherApi.getCityWeather(
            query: event.query, appId: MrionConsts.apiKey);
        yield CitySuccess(res);
      } catch (e) {
        yield CityError();
      }
    }
  }
}
