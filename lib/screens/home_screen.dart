// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/city_bloc/city_bloc.dart';
import 'package:weather_app/models/wether_m.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var cityBloc = CityBloc();
  @override
  void dispose() {
    super.dispose();
    cityBloc.close();
  }

  var searchQ = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            TextFormField(
              controller: searchQ,
              decoration: InputDecoration(
                  suffix: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  cityBloc.add(GetCityWeather(query: searchQ.text));
                },
              )),
            ),
            //search bar
            Container(
                child: BlocBuilder(
              bloc: cityBloc,
              builder: (_, state) {
                if (state is CityLoading) {
                  return loading();
                }
                if (state is CitySuccess) {
                  return weatherData(state.weatherData);
                }
                if (state is CityError) {
                  return errorS();
                }
                if (state is CityInitial) {
                  return initialW();
                }
                return initialW();
              },
            ))
          ],
        )),
      ),
    );
  }

  Widget loading() {
    return Container(
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget errorS() {
    return Container(
      child: const Center(
        child: Text("hello error"),
      ),
    );
  }

  Widget initialW() {
    return Container(
      child: const Center(
        child: Text("search ui"),
      ),
    );
  }

  Widget weatherData(WetherM? wetherM) {
    return Container(
      child: Center(
          child: Column(
        children: [
          Text(wetherM!.coord!.lat.toString()),
        ],
      )),
    );
  }
}
