import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sample_json_renderer/service/json_handler.dart';
import 'package:sample_json_renderer/service/json_parser.dart';
import 'package:sample_json_renderer/utils/constants.dart';

class DataProvider {
  static final DataProvider instance = DataProvider._internal();

  factory DataProvider() {
    return instance;
  }

  DataProvider._internal() {
    initializeHomePageJson();
  }
  static Map<String, dynamic>? _homePageJsonData = {};

  Future<void> initializeHomePageJson() async {
    _homePageJsonData =
        await JsonHandler().readJson(Constants.homePageJsonPath);
    JsonParser();
  }

  static Map<String, dynamic> get getHomePageJson => _homePageJsonData ?? {};
}

class AppThemeProvider {
  static final AppThemeProvider instance = AppThemeProvider._internal();

  factory AppThemeProvider() {
    return instance;
  }
  AppThemeProvider._internal() {
    stream = brightnessController.stream;
  }

  Stream<Brightness>? stream;

  Future<void> initializeHomePageJson() async {}

  StreamController<Brightness> brightnessController =
      StreamController<Brightness>();
}
