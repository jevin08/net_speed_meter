import 'dart:convert';

import 'package:net_speed_meter/main.dart';

class EverydayData {
  DateTime date = DateTime.now();
  double mobileDataUsage = 0.0;
  double wifiDataUsage = 0.0;
  EverydayData({
    required this.date,
    required this.mobileDataUsage,
    required this.wifiDataUsage,
});
  factory EverydayData.fromJson(Map<String, dynamic> jsonData) =>
      EverydayData(date: jsonData['data'],
          mobileDataUsage: jsonData['mobileDataUsage'],
          wifiDataUsage: jsonData['wifiDataUsage']
      );
  static Map<String, dynamic> toMap(EverydayData model) => <String, dynamic>{
    'date': model.date,
    'wifiDataUsage':model.wifiDataUsage,
    'mobileDataUsage':model.mobileDataUsage,
  };
  static String serialize(EverydayData model) =>
      json.encode(EverydayData.toMap(model));

  static EverydayData deserialize(String json) =>
      EverydayData.fromJson(jsonDecode(json));
}

class AppModel {
  String authKey;
  bool isDarkMode;
  Map<DateTime, EverydayData> data;

  AppModel({
    required this.authKey,
    required this.isDarkMode,
    required this.data,
  });

  factory AppModel.fromJson(Map<String, dynamic> jsonData) => AppModel(
        authKey: jsonData['auth_key'],
        isDarkMode: jsonData['isDarkMode'],
        data: jsonData['data'],
      );
  static Map<String, dynamic> toMap(AppModel model) => <String, dynamic>{
        'authKey': model.authKey,
        'isDarkMode': model.isDarkMode,
        'data': model.data
      };
  static String serialize(AppModel model) =>
      json.encode(AppModel.toMap(model));

  static AppModel deserialize(String json) =>
    AppModel.fromJson(jsonDecode(json));
}
/*
Introduction
SRS
Database Design
UML
1) Use case
2) class
3) Sequence - user state flow
4) Activity - object state flow
5) DFD
6) ER Diagram
Implementation Details
Testing
*/
